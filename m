Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9B5E2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 09:50:38 +1100 (EST)
Message-ID: <1386629419.10013.62.camel@snotra.buserror.net>
Subject: Re: questions: second of the 2 pcie controllers does not scan the bus.
From: Scott Wood <scottwood@freescale.com>
To: Ruchika <ruchika.k@servergy.com>
Date: Mon, 9 Dec 2013 16:50:19 -0600
In-Reply-To: <52A2706A.7030205@servergy.com>
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
 <1385159644.1403.532.camel@snotra.buserror.net>
 <Pine.LNX.4.64.1311230053360.12354@digraph.polyomino.org.uk>
 <1386376365.7375.209.camel@snotra.buserror.net>
 <52A2706A.7030205@servergy.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-06 at 18:48 -0600, Ruchika wrote:
> Hi,
> I am working with an p4080 based board. I am trying to get 2 PCIE 
> controllers probed properly.
> 
> In uboot I have no problems scanning and discovering what is connected 
> to both controllers/PCI bridges.
> 
> For both PCIE1/2 uboot sets up the Primary, secondary and Subordinate 
> bus numbers to 0,1,1 respectively.
> 
> When linux boots up and probes the controllers, PCIE1 is probed and the 
> bridge scanned properly but PCIE2 is probed at the bridge but not 
> attempted a scan.
> I see this message
> "pci 0001:02:00.0: bridge configuration invalid ([bus 01-01]), reconfiguring
> "
> 
> I updated uboot to set the secondary and subordinate numbers to 2 (left 
> the primary number to 0) and a subsequent kernel boot scanned the bus 
> for PCIE2 successfully.
> I found these numbers to be very critical since the device tree blob 
> (bus-range) for pci is also based off these.
> 
> I'd like to get a good fix rather than the uboot hack and get better 
> understanding of the problem. If there are any pointers someone could 
> provide it would be awesome.

This is the code that prints that:

        /* Check if setup is sensible at all */
        if (!pass &&
            (primary != bus->number || secondary <= bus->number ||
             secondary > subordinate)) {
                dev_info(&dev->dev, "bridge configuration invalid ([bus %02x-%0
                         secondary, subordinate);
                broken = 1;
        }

Start by printing out more information to determine which of those
checks is failing (e.g. what is primary and bus->number).  If it turns
out that U-Boot is configuring the PCI bus incorrectly, send e-mail to
the U-Boot list.  Be sure to mention what version of Linux and U-Boot
you're using.

-Scott
