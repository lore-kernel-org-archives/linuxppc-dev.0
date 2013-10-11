Return-Path: <ivan.mercier@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A0AC2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 02:04:14 +1100 (EST)
Received: by mail-la0-f42.google.com with SMTP id ep20so3576987lab.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 08:04:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381418079.7979.396.camel@snotra.buserror.net>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
 <1381271655.7979.290.camel@snotra.buserror.net>
 <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
 <1381418079.7979.396.camel@snotra.buserror.net>
From: Mercier Ivan <ivan.mercier@gmail.com>
Date: Fri, 11 Oct 2013 17:03:30 +0200
Message-ID: <CAMc2ieqO5eKiXdGh0qraJy3FKPMbzkpTGgWrSwwGHh7sn2iCFw@mail.gmail.com>
Subject: Re: Elbc device driver
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
this should be correct (I'm using chip select 3 for this device)
        lbc: localbus@ffe124000 {
                reg = <0xf 0xfe124000 0 0x1000>;
                ranges = <3 0 0xf 0xe0000000 0x08000000>;

                a3p400{
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "my_a3p_driver";
                        reg = <0x0 0x0 0x800000>;
                };
        };

yeah, I'm including p3041-post.dtsi.

so it I get it, I should code my driver doing basically:
{
        static u8 __iomem * a3p
        struct device_node *np;

         np = of_find_compatible_node(NULL, NULL, "my_a3p_driver");
        if (!np) {
                printk(KERN_CRIT "Could not find my_a3p_driver node\n");
                return;
        }

        a3p_bcsr = of_iomap(np, 0);
        of_node_put(np);

        if (!a3p_bcsr) {
                printk(KERN_CRIT "Could not remap BCSR\n");
                return;
        }
}

Thanks for your help Scott


2013/10/10 Scott Wood <scottwood@freescale.com>:
> On Thu, 2013-10-10 at 16:54 +0200, Mercier Ivan wrote:
>> Hi,
>> I've got a KERN_INFO msg: "fsl-lbc a3p400.11: failed to get memory
>> region" corresponding to my elbc device that I try to map.
>>                 a3p400@3,0 {
>>                         compatible = "fsl,elbc";
>>                         reg = <0 0xe0000000 0x1000000>;
>>                 };
>
> The node name and unit address do not match the contents of the node.
> The former describes a device that sits on the localbus, while the
> latter has a compatible describes the localbus itself.  I don't know
> what that reg is, but it doesn't match the unit address.
>
>> The corresponding law on ELBC is 0xe0000000 ->0xf0000000.
>> I want to map my device on 0xe0000000 ->0xe8000000 as it has 16 adress bits.
>>
>> Now the controler registers are properly set,but how do I map the device?
>
> Your eLBC node should look something like this (I'm assuming CCSR is at
> 0xffe000000, and that you actually meant 0x0e0000000 and not
> 0xfe0000000, though probably one of those assumptions is wrong):
>
>         localbus@ffe124000 {
>                 compatible = "fsl,elbc", "simple-bus";
>                 reg = <0xf 0xfe124000 0 0x1000>;
>                 interrupts = <25 2 0 0>;
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>
>                 ranges = <3 0 0 0xe0000000 0x08000000>;
>
>                 /* If at all possible, replace "a3p400" in the node name with
> something generic */
>                 a3p400@3,0 {
>                         compatible = "something appropriate here";
>                         reg = <3 0 0x08000000>;
>                 };
>         };
>
> Note that at the dts level, you should be including
> arch/powerpc/boot/dts/fsl/p3041-post.dtsi and thus your board dts would
> only need to supply reg, ranges, and the a3p400 node (see
> arch/powerpc/boot/dts/p3041ds.dts for an example).
>
> -Scott
>
>
>
