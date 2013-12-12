Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9CDC62C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 09:26:04 +1100 (EST)
Date: Thu, 12 Dec 2013 23:25:51 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
Message-ID: <20131212222551.GE26910@book.gsilab.sittig.org>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
 <52A9E074.5080607@sirius-es.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A9E074.5080607@sirius-es.it>
Cc: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 12, 2013 at 17:12 +0100, Matteo Facchinetti wrote:
> 
> On 10/12/2013 14:11, Gerhard Sittig wrote:
> >this series improves the previously introduced common clock support for
> >MPC512x such that SoC variants 5123 and 5125 get addressed appropriately
> >(MPC5125 turned out to be rather different from MPC5121 than I perceived
> >before -- there is much more than "just two FECs and no MBX")
> Ohhh yesss..... welcome to hell! :-)
> 
> I report also these differences:
> 
> - I/O control module:
>        to do integration with linux pin-muxing subsystem
> 
> - GPIO module:
>        controller is the same of the mpc5121 but with these differences:
>        - 64 gpios divided in 2 banks
>        - input only gpios are numbers form 0 to 3 of the first bank
>        I'm finishing to write the patch... when done I'll post in ML

Yes, I've seen the 2x 32bits thing on MPC5125.  Can't tell
whether one can just use two mpc8xxx-gpio nodes in the device
tree and be done.

MPC5121 has just one 32bits GPIO bank.  And four of those pins
are "GPI only" as well.  This may be identical to one of the two
MPC5125 banks.

> - NFC: one of the biggest unsolved mystery
>        Is this ip-core used in others microcontrollers? Seems to be
> used only in mpc5125!!!
> 
> >
> >Matteo, can you verify the crystal frequency in the DTS update, please?
> Crystal frequency is ok: 33MHz.

great

> >And that v3.13-rc kernels with v6 of the COMMON_CLK introduction for
> >MPC512x plus this series for MPC5125 operate your peripherals, both with
> >an updated device tree as well as with a former device tree that lacks
> >clock specs?  Thank you!  Setting CONFIG_COMMON_CLK_DEBUG=y in your
> >.config and eyeballing /sys/kernel/debug/clk/clk_summary will help you.
> >
> >
> I tested all on TWR board.

Thank you!  I think this qualifies as Tested-by: then. :)

> In DTS, for the moment, have to comment out this block:
> -        usb@3000 {
> -            compatible = "fsl,mpc5121-usb2-dr";
> -            reg = <0x3000 0x400>;
> -            #address-cells = <1>;
> -            #size-cells = <0>;
> -            interrupts = <43 0x8>;
> -            dr_mode = "host";
> -            phy_type = "ulpi";
> -            clocks = <&clks MPC512x_CLK_USB1>;
> -            clock-names = "ipg";
> -        };
> Because USB controller pinout is not initialized correctly and when
> system boot, causes a kernel panic.
> 
> For the rest, kernel works correctly. For MPC5125 the patches are OK.
> 
> I also check clk_summary and all clocks values are OK (except for
> NFC clock value).

Since there is no user of the NFC block yet, I did not implement
the driver for the clock item.  The list of clocks in debugfs
should completely lack an NFC entry since nothing was registered
with the CCF subsystem.

> I notice that there are missing clock like: gpio1, gpio2, fuse, dma,
> wdt, pmc, rtc.
> Is this OK or should be added?

Are there registers for those clock items?  Haven't seen any when
flipping through the RM's clocks chapter.  If there's no
(software controllable) gate or divider, then there's no clock
item in need of software support.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
