Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from mx.vmgattei.com (mx.vmgattei.com [77.223.18.35])
 by ozlabs.org (Postfix) with ESMTP id EAB562C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 03:18:03 +1100 (EST)
Received: from localhost (mx.vmgattei.com [127.0.0.1])
 by mx.vmgattei.com (Postfix) with ESMTP id 5683822D72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 17:12:49 +0100 (CET)
Received: from mx.vmgattei.com ([127.0.0.1])
 by localhost (mx.vmgattei.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcHWPW0Xm34B for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 12 Dec 2013 17:12:49 +0100 (CET)
Message-ID: <52A9E074.5080607@sirius-es.it>
Date: Thu, 12 Dec 2013 17:12:36 +0100
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/12/2013 14:11, Gerhard Sittig wrote:
> this series improves the previously introduced common clock support for
> MPC512x such that SoC variants 5123 and 5125 get addressed appropriately
> (MPC5125 turned out to be rather different from MPC5121 than I perceived
> before -- there is much more than "just two FECs and no MBX")
Ohhh yesss..... welcome to hell! :-)

I report also these differences:

- I/O control module:
        to do integration with linux pin-muxing subsystem

- GPIO module:
        controller is the same of the mpc5121 but with these differences:
        - 64 gpios divided in 2 banks
        - input only gpios are numbers form 0 to 3 of the first bank
        I'm finishing to write the patch... when done I'll post in ML

- NFC: one of the biggest unsolved mystery
        Is this ip-core used in others microcontrollers? Seems to be 
used only in mpc5125!!!

>
> Matteo, can you verify the crystal frequency in the DTS update, please?
Crystal frequency is ok: 33MHz.

> And that v3.13-rc kernels with v6 of the COMMON_CLK introduction for
> MPC512x plus this series for MPC5125 operate your peripherals, both with
> an updated device tree as well as with a former device tree that lacks
> clock specs?  Thank you!  Setting CONFIG_COMMON_CLK_DEBUG=y in your
> .config and eyeballing /sys/kernel/debug/clk/clk_summary will help you.
>
>
I tested all on TWR board.

In DTS, for the moment, have to comment out this block:
-        usb@3000 {
-            compatible = "fsl,mpc5121-usb2-dr";
-            reg = <0x3000 0x400>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            interrupts = <43 0x8>;
-            dr_mode = "host";
-            phy_type = "ulpi";
-            clocks = <&clks MPC512x_CLK_USB1>;
-            clock-names = "ipg";
-        };
Because USB controller pinout is not initialized correctly and when 
system boot, causes a kernel panic.

For the rest, kernel works correctly. For MPC5125 the patches are OK.

I also check clk_summary and all clocks values are OK (except for NFC 
clock value).

I notice that there are missing clock like: gpio1, gpio2, fuse, dma,  
wdt, pmc, rtc.
Is this OK or should be added?


Regards,

Matteo Facchinetti
Sirius Electronic Systems
