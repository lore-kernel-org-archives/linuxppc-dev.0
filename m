Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id E8C3767A65
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 13:55:35 +1100 (EST)
Date: 18 Mar 2005 02:55:29 -0000
Message-ID: <20050318025529.553.qmail@kunk.qbjnet.com>
From: linuxppcdev@qbjnet.com
To: linuxppc-dev@ozlabs.org
Subject: Re: DMA appears broken in 2.6.11 for Mac 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Said:
> On Mon, 2005-03-14 at 03:51 +0000, linuxppcdev@qbjnet.com wrote:
> > Just updated a couple of old Mac 7200 (601) boxen and ran into trouble with
> > the ide driver and a promise PDC20267 card. 
> > 
> > The very same drives and card work fine on a 9500 but hang on a 7200. If
> > I set the kernel arg ide=nodma I get in the dmesg:
> > ide_setup: ide=nodma : Prevented DMA
> > and the 7200 boots and runs fine.
> > 
> > Another suspect, the mace ethernet driver (which also appears to use DMA)
> > doesn't work on the 7200 with 2.6.11 but does with 2.4.28 and it works 
> > with 2.6.11 on the 9500.
> 
> Interesting. Not sure what's up, though. Those old machines were known
> to have bugs relative to cache coherency... also check wetehr we are
> setting the cache line size properly in PCI devices. You can also try to
> disable use of PCI memory write & invalidate command in all devices.
 
Did some more testing on this. Built a 2.4.30-pre1 kernel from bk source.

DMA works fine booting 2.4.30

I compared the dmesg and lspci and I see no differences in the cache line
size.

Is it possible that the ppc 601 kernel fixes aren't getting done properly
in 2.6??

Bob
