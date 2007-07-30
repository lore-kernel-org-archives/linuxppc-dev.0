Return-Path: <norsk5@yahoo.com>
Received: from web50107.mail.re2.yahoo.com (web50107.mail.re2.yahoo.com
	[206.190.38.35]) by ozlabs.org (Postfix) with SMTP id 11839DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 08:53:47 +1000 (EST)
Date: Mon, 30 Jul 2007 15:47:05 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
To: Linas Vepstas <linas@austin.ibm.com>, Dave Jiang <djiang@mvista.com>
In-Reply-To: <20070730214404.GE4884@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <845900.3390.qm@web50107.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com, Arnd Bergmann <arnd@arndb.de>,
	bluesmoke-devel@lists.sourceforge.net
Reply-To: dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- Linas Vepstas <linas@austin.ibm.com> wrote:

> On Mon, Jul 30, 2007 at 01:17:40PM -0700, Dave Jiang wrote:
> > Arnd Bergmann wrote:
> > > The best solution may be to look at how it's structured at the
> > > register level. If the PCI EDAC registers are implemented separately
> > > from the regular PCI registers, a device tree entry would be appropriate.
> > > If not, your idea of registering a platform_device from fsl_add_bridge
> > > is probably more sensible.
> > > 
> > 
> > We can probably do either. From looking at the 8560 and 8548 manuals, the PCI
> > error registers are 0xe00 offset of the start of PCI registers. For example,
> > the PCI registers would start at 0x8000 offset. And the PCI error registers
> > would be at 0xe00 offset from there and would be the very last block of
> > registers. 
> 
> Anywhere I can easily get an overview of these "PCI error registers"?
> 
> Also: please note that the linux kernel has a pci error recovery
> mechanism built in; its used by pseries and PCI-E. I'm not clear
> on what any of this has to do with EDAC, which I thought was supposed 
> to be for RAM only. (The EDAC project once talked about doing pci error 
> recovery, but that was years ago, and there is a separate system for
> that, now.)

no, edac can/does harvest PCI bus errors, via polling and other hardware error detectors.

The pci error recovery added a couple of NEW device callback functions in the driver interface, 
which the bus layer can call to notify drivers that a PCI bus error occurred. Then the driver can
do some action on the event.

But at the current time, few PCI device drivers initialize those callback functions and
thus errors are lost and some IO transactions fail.

Over time, as drivers get updated (might take some time) then drivers
can take some sort of action FOR THEMSELVES

Yet, there is no tracking of errors - except for a log message in the log file.

There is NO meter on frequency of errors, etc. One must grep the log file and that is not a very
cycle friendly mechanism.

The reason I added PCI parity/error device scanning, was that when I was at Linux Networx, we had
parity errors on the PCI-X bus, but didn't know the cause.  After we discovered that a simple
PCI-X riser card had manufacturing problems (quality) and didn't drive lines properly, it caused
parity errors. This feature allowed us to track nodes that were having parity problems, but we had
no METER to know it.

Recovery is a good thing, BUT how do you know you having LOTS of errors/recovery events? You need
a meter. EDAC provides that METER

I met with Yanmin Zhang of Intel at OLS after his paper presentation on PCI Express Advanced Error
Reporting in the Kernel, and we talked about this same thing. I am talking with him on having the
recovery code present information into EDAC sysfs area. (hopefully, anyway)

The recovery generates log messages BUT having to periodically 'grep' the log file looking for
errors is not a good use of CPU cycles. grep once for a count and then grep later for a count and
then compare the counts for a delta count per unit time. ugly.

The EDAC solution is to be able to have a Listener thread in user space that can be notified (via
poll()) that an event has occurred.

There are more than one consumer (error recover) of error events:

1) driver recovery after a transaction (which is the recovery consumer above)
2) Management agents for health of a node
3) Maintainance agents for predictive component replacement

Rates of change of errors can be gathered as well.

EDAC allows for presentation of error counts via sysfs entries, from which user space
programs can harvest for over-time profiling

We have MEMORY (edac_mc) devices for chipsets now, but via the new edac_device class, such things
as ECC error tracking on DMA error checkers, FABRIC switchs, L1 and L2 cache ECC events, core CPU
data ECC checkers, etc can be done. I have an out of kernel tree MIPS driver do just this. Other
types of harvesters can be generated as well for other and/or new hardware error detectors.

doug thompson

> 
> --linas
> 
> 
> 
