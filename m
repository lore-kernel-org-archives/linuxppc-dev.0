Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443691A1BF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 05:18:36 +1000 (AEST)
Received: by igui7 with SMTP id i7so7488147igu.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2015 12:18:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhJO7c=qNR4GK4_uPKQpFrSk+C7T4g5v3XPXd4YyEiVyNw@mail.gmail.com>
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
Date: Sun, 9 Aug 2015 22:18:33 +0300
Message-ID: <CAJ2oMhKa3TTmMQ+C_3ZtYTHWKw2vqShnQCQNta-5kJAy-7NqSQ@mail.gmail.com>
Subject: Re: GPMC in device tree
From: Ran Shalit <ranshalit@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 9, 2015 at 9:27 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> On Thu, Aug 6, 2015 at 6:07 AM, Scott Wood <scottwood@freescale.com> wrote:
>> On Wed, 2015-08-05 at 17:27 +0300, Ran Shalit wrote:
>>> On Wed, Aug 5, 2015 at 9:11 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>>> > On Wed, Aug 5, 2015 at 6:56 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>>> > > On Wed, Aug 5, 2015 at 12:25 AM, Scott Wood <scottwood@freescale.com>
>>> > > wrote:
>>> > > > On Wed, 2015-08-05 at 00:22 +0300, Ran Shalit wrote:
>>> > > > > On more thing, if I may.
>>> > > > > The localbus is also connected to nvram & cpld.
>>> > > > > I've noticed that read/write works well, even though I didn't define
>>> > > > > anything in device tree.
>>> > > > > Is there any reasom to add these devices into device tree, or can we
>>> > > > > use the cpld and nvram without the definition in device tree ?
>>> > > >
>>> > > > I don't know what you're doing in your kernel to access devices that
>>> > > > aren't
>>> > > > in the device tree.  You should add the devices to the device tree,
>>> > > > and have
>>> > > > the kernel use it rather than hardcoded info.
>>> > > >
>>> > > > -Scott
>>> > > >
>>> > > Hi,
>>> > >
>>> > > Yes I understand.
>>> > > But It is worse noting that I have no localbus entry in the device tree.
>>> > > Yes, The nvram, cpld which are both connected to device tree, seems to
>>> > > work without any issues.
>>> > >
>>> > > Thanks,
>>> > > Ran
>>> >
>>> > I apologyze for the bad english, I meant "it worth to note" that there
>>> > is no localbus entry at all in the device tree.
>>> > So I wander how the nvram and cpld worked...
>>
>> I don't know how it worked -- presumably there's something in your kernel
>> that hardcodes knowledge of those devices.
>>
>>> > If I may please ask, what should be the "compatible" for generic
>>> > devices such as  nvram/cpld ?
>>
>> CPLD is not a generic device.  The compatible should describe the logic that
>> has been programmed into the CPLD.
>>
>>> > I assume that if they worked without any entry, it means that there is
>>> > no need for specific driver.
>>> >
>>> > Regards,
>>> > Ran
>>>
>>> Hi,
>>>
>>> After studing the localbus configuration as should be configured in
>>> device tree for powerpc, I think I have come with the following
>>> configuration, (not yet tested on board):
>>>
>>>
>>>  localbus@e0005000{
>>> #address-cells = <2>;
>>> #size-cells = <1>;
>>>     compatible = "fsl,mpc8349-localbus", "simple-bus";
>>>      reg = <0xe0005000 0x1000>;
>>>      interrupts = <77 0x8>;
>>>      interrupt-parent = <&ipic>;
>>>
>>>
>>> /* NOR and NAND Flashes */
>>>    ranges = <0x0 0x0 0xff800000 0x00800000         /* 8MB NOR Flash */
>>>              0x1 0x0 0xF8000000 0x08000000      /* User flash (same
>>> nor, in burst mode) 128M */
>>>              0x2 0x0 0xf7e00000 0x00200000>;    /*NVRAM/CPLD C2 is
>>> selected in CPLD , */
>>> /*nvram 0xf7e00000 1MB */
>>> /*cpld      0xf7f00000 1M  (<- different address!)*/
>>> nor@0,0 {
>>> #address-cells = <1>;
>>> #size-cells = <1>;
>>> compatible = "cfi-flash";
>>> reg = <0x0 0x0 0x1000000>;
>>> #bank-width = <1>;
>>> device-width = <4>;
>>>
>>> };
>>> };
>>
>
> Hi ,
>
> I reboot the board, with the new device tree localbus, but I don't
> have any new /dev/mtdX entry for the NOR flash.
> There is no HW issue, becuase we can R/W access the NOR flash from u-boot.
> Is there any hint what can be the issue here ? I've checked in kernel
> config and validated that mtd is supported.
> The NOR flash is S29GL512P , SPANSION.
>
> localbus@e0005000 {
> #address-cells = <2>;
> #size-cells = <1>;
>    compatible = "fsl,mpc8349-localbus", "simple-bus";
>     reg = <0xe0005000 0x1000>;
>     interrupts = <77 0x8>;
>     interrupt-parent = <&ipic>;
>
>
> # NOR and NAND Flashes
>   ranges = <0x0 0x0 0xff800000 0x00800000
>     0x1 0x0 0xF8000000 0x08000000
>     0x2 0x0 0xf7e00000 0x00200000>;
> nor@0,0 {
> #address-cells = <1>;
> #size-cells = <1>;
> compatible = "cfi-flash";
> reg = <0x0 0x0 0x00800000>;
> #bank-width = <1>;
> device-width = <1>;
>
> };
> };
>
> Best Regards,
> Ran

Hello,

Just to update,
I eventually solved this issue.
I don't do any configuration in device tree. All BRx configuration is
already done in u-boot (as was done from the start), and everything
seems to work OK: cpld, nvram.

For NOR FPGA I only added NOR configuration to kernel:

CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xf8000000
CONFIG_MTD_PHYSMAP_LEN=0x7800000
CONFIG_MTD_PHYSMAP_BANKWIDTH=4

Thank you for the tips,
Ran
