Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7AF71A0702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 09:34:52 +1000 (AEST)
Message-ID: <1439249673.4099.7.camel@freescale.com>
Subject: Re: GPMC in device tree
From: Scott Wood <scottwood@freescale.com>
To: Ran Shalit <ranshalit@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Aug 2015 18:34:33 -0500
In-Reply-To: <CAJ2oMhKa3TTmMQ+C_3ZtYTHWKw2vqShnQCQNta-5kJAy-7NqSQ@mail.gmail.com>
References: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
 <1438714472.2097.89.camel@freescale.com>
 <CAJ2oMhLzck9SxgzcXpEXVk_Yf0KoM=D4cOToizoOUPQFZ4JjWA@mail.gmail.com>
 <1438720268.2097.94.camel@freescale.com>
 <CAJ2oMhLDpbnqp=15Z_zWw8c1dY2fRCokG+_hneL=pFUMZdHN5Q@mail.gmail.com>
 <1438723510.2097.97.camel@freescale.com>
 <CAJ2oMhKNXz56xcxmNFeaZXHct0ERf0m9V_uTbtCZCUKcGtPkqw@mail.gmail.com>
 <CAJ2oMhK0WHR2at7h2Cw46nXTtDBkgMxbATm95dNYwdLPrs+GPw@mail.gmail.com>
 <CAJ2oMh+9Ls0if-yutBzCgZgdTZ+Z4zo1dKq+niRzL6uWvaQeqw@mail.gmail.com>
 <1438830473.2097.138.camel@freescale.com>
 <CAJ2oMhJO7c=qNR4GK4_uPKQpFrSk+C7T4g5v3XPXd4YyEiVyNw@mail.gmail.com>
 <CAJ2oMhKa3TTmMQ+C_3ZtYTHWKw2vqShnQCQNta-5kJAy-7NqSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-08-09 at 22:18 +0300, Ran Shalit wrote:
> On Sun, Aug 9, 2015 at 9:27 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> > 
> > Hi ,
> > 
> > I reboot the board, with the new device tree localbus, but I don't
> > have any new /dev/mtdX entry for the NOR flash.
> > There is no HW issue, becuase we can R/W access the NOR flash from u-boot.
> > Is there any hint what can be the issue here ? I've checked in kernel
> > config and validated that mtd is supported.
> > The NOR flash is S29GL512P , SPANSION.
> > 
> >  localbus@e0005000{
> > #address-cells = <2>;
> > #size-cells = <1>;
> >    compatible = "fsl,mpc8349-localbus", "simple-bus";
> >     reg = <0xe0005000 0x1000>;
> >     interrupts = <77 0x8>;
> >     interrupt-parent = <&ipic>;
> > 
> > 
> > # NOR and NAND Flashes
> >   ranges = <0x0 0x0 0xff800000 0x00800000
> >     0x1 0x0 0xF8000000 0x08000000
> >     0x2 0x0 0xf7e00000 0x00200000>;

You have overlap between cs0 and cs1.

> > nor@0,0 {
> > #address-cells = <1>;
> > #size-cells = <1>;
> > compatible = "cfi-flash";
> > reg = <0x0 0x0 0x00800000>;
> > #bank-width = <1>;
> > device-width = <1>;

It's "bank-width", not "#bank-width".

> > 
> > };
> > };
> > 
> > Best Regards,
> > Ran
> 
> Hello,
> 
> Just to update,
> I eventually solved this issue.
> I don't do any configuration in device tree. All BRx configuration is
> already done in u-boot (as was done from the start), and everything
> seems to work OK: cpld, nvram.
> 
> For NOR FPGA I only added NOR configuration to kernel:
> 
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=0xf8000000
> CONFIG_MTD_PHYSMAP_LEN=0x7800000
> CONFIG_MTD_PHYSMAP_BANKWIDTH=4

I don't recommend this.  You're bypassing the device tree entirely.

Why did you put bankwidth 4 here, but bankwidth 1 in the device tere?

-Scott
