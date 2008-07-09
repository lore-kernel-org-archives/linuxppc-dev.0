Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 02/02] powerpc/cell: add support
	for	power button of future IBM cell blades
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807091515.04484.arnd@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080707185644.0d6c9757@de.ibm.com>
	<1215574530.8970.306.camel@pasglop>
	<200807091515.04484.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 06:45:30 +1000
Message-Id: <1215636330.8970.387.camel@pasglop>
Mime-Version: 1.0
Cc: Christian Krafft <krafft@de.ibm.com>,
	Christian Krafft <krafft@linux.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 15:15 +0200, Arnd Bergmann wrote:
> Ugly, but doable, yes. I wonder if there is a way that we can trigger some
> interrupt from system_reset_exception context in order to get around the
> polling though. tasklets and workqueues unfortunately won't do us any good
> here because they also depend on disabling interrupts.

You can trigger a DEC interrupt at any time but you don't have
a nice hook to catch it. You can probably trigger an IPI to yourself
using a special call to the iic, do we have any available number ?

Ben.
