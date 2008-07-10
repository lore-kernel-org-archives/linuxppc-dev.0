Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 02/02] powerpc/cell: add support
	=?iso-8859-1?q?for=09power_button_of_future_IBM_cell?= blades
Date: Thu, 10 Jul 2008 16:34:47 +0200
References: <20080704190535.316377278@arndb.de>
	<200807091515.04484.arnd@arndb.de>
	<1215636330.8970.387.camel@pasglop>
In-Reply-To: <1215636330.8970.387.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807101634.48097.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 July 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-07-09 at 15:15 +0200, Arnd Bergmann wrote:
> > Ugly, but doable, yes. I wonder if there is a way that we can trigger some
> > interrupt from system_reset_exception context in order to get around the
> > polling though. tasklets and workqueues unfortunately won't do us any good
> > here because they also depend on disabling interrupts.
> 
> You can trigger a DEC interrupt at any time but you don't have
> a nice hook to catch it. You can probably trigger an IPI to yourself
> using a special call to the iic, do we have any available number ?

Yes, we are only using 4 out of 15 possible IPIs. Probably worth a try,
but it might not be cleaner than your suggested solution.

	Arnd <><
