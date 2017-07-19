Return-Path: <thomas.besemer@gmail.com>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCWRD682NzDr56
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 08:09:44 +1000 (AEST)
Received: by mail-wm0-x234.google.com with SMTP id k69so10032823wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:09:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717005846.GD13471@gate.crashing.org>
References: <CAO7m3AkpuUdApRiiDw+Sv6fqyhVsfBOUA8cw1xChJLxT1r6_wA@mail.gmail.com>
 <20170717005846.GD13471@gate.crashing.org>
From: Thomas Besemer <thomas.besemer@gmail.com>
Date: Wed, 19 Jul 2017 15:09:41 -0700
Message-ID: <CAO7m3AmDBO29CES2Tu8KvS1Y8FBhFQ7ehA8AKRDkvo_iOWPRgA@mail.gmail.com>
Subject: Re: 440EP NOR Flash Mapping with DTS
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 16, 2017 at 5:58 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Sun, Jul 16, 2017 at 05:31:05PM -0700, Thomas Besemer wrote:
>> I'm trying to map some NOR flash in via DTS on a Yosemite
>> style 440EP board. I've tried a few different things, below
>> showing my latest attempt.  During Kernel boot, it does not
>> appear to detect the device, as no messages are emitted.
>>
>> Flash is Spansion S29GL256P, base address 0xFE000000.
>>
>> EBC0: ebc {
>>        compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
>>        dcr-reg = <0x012 0x002>;
>>        #address-cells = <2>;
>>        #size-cells = <1>;
>>        clock-frequency = <0>; /* Filled in by zImage */
>>        interrupts = <0x5 0x1>;
>>        interrupt-parent = <&UIC1>;
>>
>>        nor_flash@FE0000000,0 {
>
> @0,fe000000
>
>>                reg = <0xFE000000 0x02000000>;
>
> reg = <0 0xfe000000 0x02000000>;
>
>
> Cheers,
>
>
> Segher

I'm still having trouble with this, and think it's a DTS syntax problem.  I did
load up kernel with some printk()'s in key areas, and it was not finding the
device due to invalid ranges.  I simply added 'ranges;' to the EBC entry,
it detected, but did not properly map in MTD's.  Here is summary of warnings
on DTS, full DTS, and what it looks like mapped in.

I will note that I can't find many examples on this, and my syntax is not much
different than what was originally checked in.  I suspect that the
'ranges' field
is wrong, but I can't find documentation on what fields represent.

Thanks.

DTB Warning:

Warning (ranges_format): /plb/opb/ebc has empty "ranges" property but
its #address-cells (2) differs from /plb/opb (1)

DTB Entry:

POB0: opb {
        compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
        #address-cells = <1>;
        #size-cells = <1>;
        /* Bamboo is oddball in the 44x world and doesn't use the ERPN
         * bits.
         */
        ranges = <0x00000000 0x00000000 0x00000000 0x80000000
                  0x80000000 0x00000000 0x80000000 0x80000000>;
        interrupt-parent = <&UIC1>;
        interrupts = <0x7 0x4>;
        clock-frequency = <0>; /* Filled in by zImage */

        EBC0: ebc {
                compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
                dcr-reg = <0x012 0x002>;
                clock-frequency = <0>; /* Filled in by zImage */
                interrupts = <0x5 0x1>;
                interrupt-parent = <&UIC1>;
                #address-cells = <2>;
                #size-cells = <1>;

                ranges;  /*  WITHOUT THIS, CHIP NOT FOUND   */

                nor_flash@0,FE000000 {
                        compatible = "amd,s29gl256p", "cfi-flash";
                        bank-width = <2>;
                        reg = <0 0xFE000000 0x02000000>;
                        #address-cells = <1>;
                        #size-cells = <1>;
                        partition@0 {
                                label = "Kernel";
                                reg = <0x00000000 0x00180000>;
                        };
                        partition@180000 {
                                label = "OS Filesystem";
                                reg = <0x00180000 0x01DE0000>;
                        };
                };
        };

Result MTD:

# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 02000000 00020000 "fe000000.nor_flash"
#

Boot Messages:

[    6.272519] fe000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank. Ma
nufacturer ID 0x000001 Chip ID 0x002201
[    6.282969] Amd/Fujitsu Extended Query Table at 0x0040
[    6.288094]   Amd/Fujitsu Extended Query version 1.3.
[    6.293132] number of CFI chips: 1
