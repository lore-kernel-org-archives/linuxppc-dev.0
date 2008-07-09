Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org, benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 02/02] powerpc/cell: add support
	=?iso-8859-1?q?for=09power_button_of_future_IBM_cell?= blades
Date: Wed, 9 Jul 2008 15:15:03 +0200
References: <20080704190535.316377278@arndb.de>
	<20080707185644.0d6c9757@de.ibm.com>
	<1215574530.8970.306.camel@pasglop>
In-Reply-To: <1215574530.8970.306.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200807091515.04484.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Christian Krafft <krafft@de.ibm.com>,
	Christian Krafft <krafft@linux.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 July 2008, Benjamin Herrenschmidt wrote:
> Sorry Christian, i'm still not too happy with this one.
>=20
> There are two issues at hand here:
>=20
> =A0- The use of SELECT, that will be frowned on unfortunately.

Ok, this should be easy to fix, by making it depend on INPUT
instead, like the ACPI power button does. It's modeled after
that anyway.

> =A0- I'm not too sure it's very safe the way you do it. If I understand
> correctly, you can get called for that sysreset at -any- time, including
> when interrupts are off right ?

Yes, that sounds like a problem.

> That means potentially, code that has interrupts off will be interrupted
> by input_report/input_sync, which is really bad (may corrupt the input
> layer internal list management for example).

I can't think of a case where this can realistically hit us (the blades
don't have any other input devices normally), but of course you are
right that it's broken anyway.

> You could solve both things with a little trick: Have the platform code
> just basically set a global flag when the button was pressed and have a
> module that depends on INPUT & INPUT_DEV poll for it (slowly pls) and do
> the input report.

Ugly, but doable, yes. I wonder if there is a way that we can trigger some
interrupt from system_reset_exception context in order to get around the
polling though. tasklets and workqueues unfortunately won't do us any good
here because they also depend on disabling interrupts.

	Arnd <><
