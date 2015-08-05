Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 162801A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 13:56:48 +1000 (AEST)
Received: by igr7 with SMTP id 7so87691381igr.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2015 20:56:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438723510.2097.97.camel@freescale.com>
References: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
 <1438714472.2097.89.camel@freescale.com>
 <CAJ2oMhLzck9SxgzcXpEXVk_Yf0KoM=D4cOToizoOUPQFZ4JjWA@mail.gmail.com>
 <1438720268.2097.94.camel@freescale.com>
 <CAJ2oMhLDpbnqp=15Z_zWw8c1dY2fRCokG+_hneL=pFUMZdHN5Q@mail.gmail.com>
 <1438723510.2097.97.camel@freescale.com>
Date: Wed, 5 Aug 2015 06:56:45 +0300
Message-ID: <CAJ2oMhKNXz56xcxmNFeaZXHct0ERf0m9V_uTbtCZCUKcGtPkqw@mail.gmail.com>
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

On Wed, Aug 5, 2015 at 12:25 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, 2015-08-05 at 00:22 +0300, Ran Shalit wrote:
>> On Tue, Aug 4, 2015 at 11:31 PM, Scott Wood <scottwood@freescale.com> wrote:
>> > On Tue, 2015-08-04 at 23:26 +0300, Ran Shalit wrote:
>> > > On Tue, Aug 4, 2015 at 9:54 PM, Scott Wood <scottwood@freescale.com>
>> > > wrote:
>> > > > On Tue, 2015-08-04 at 18:29 +0300, Ran Shalit wrote:
>> > > > > Hello,
>> > > > >
>> > > > > I would please like to ask if describing flash nor used with GPMC,
>> > > > > whould be done as described in:
>> > > > > https://www.kernel.org/doc/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
>> > > > > It is described in the above link as "TI's GPMC", so I'm not sure if
>> > > > > it is relevent for powerpc too.
>> > > >
>> > > > That binding is for TI GPMC.
>> > > >
>> > > > Are you saying you have some PPC chip that has a flash controller
>> > > > called
>> > > > GPMC?
>> > > >
>> > > > -Scott
>> > > >
>> > >
>> > > Hi Scott,
>> > >
>> > > Thanks, I've worked with TI's chips, so I now understand that I made
>> > > here some confusion...
>> > > It is GPCM , not GPMC, my mistake.
>> > > We already configured it in u-boot, but on doing read/write from
>> > > kernel it doesn not work.
>> > > It seems that for the linux to use the correct driver, we need to
>> > > define the nor in the device tree.
>> > > Is there any example how to define nor GPCM in device tree ? Is it
>> > > possible not to override the existing GPCM configuration ?
>> >
>> > Pretty much all of the mpc8xxx/qoriq device trees have GPCM NOR defined.
>> > See
>> > Documentation/devicetree/bindings/powerpc/fsl/lbc.txt and examples such as
>> > arch/powerpc/boot/dts/p4080ds.dts (part of the lbc node is in
>> > arch/powerpc/boot/dts/fsl/p4080si-post.dtsi).
>> >
>> > Linux will not change the GPCM configuration.
>> >
>> > -Scott
>> >
>>
>> On more thing, if I may.
>> The localbus is also connected to nvram & cpld.
>> I've noticed that read/write works well, even though I didn't define
>> anything in device tree.
>> Is there any reasom to add these devices into device tree, or can we
>> use the cpld and nvram without the definition in device tree ?
>
> I don't know what you're doing in your kernel to access devices that aren't
> in the device tree.  You should add the devices to the device tree, and have
> the kernel use it rather than hardcoded info.
>
> -Scott
>
Hi,

Yes I understand.
But It is worse noting that I have no localbus entry in the device tree.
Yes, The nvram, cpld which are both connected to device tree, seems to
work without any issues.

Thanks,
Ran
