Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpywp0MS2zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:34:14 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 527CF440DD2_715ED82B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 08:34:10 +0000 (GMT)
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 A07F443E046_715ED6CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 08:33:48 +0000 (GMT)
Received: by mail-qk0-f170.google.com with SMTP id r191so2017102qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461039981.32510.201.camel@buserror.net>
References: <460384482-21320-1-git-send-email-alessio.bogani@elettra.eu>
 <1460966279-29188-1-git-send-email-alessio.bogani@elettra.eu>
 <1461039981.32510.201.camel@buserror.net>
Date: Tue, 19 Apr 2016 10:33:47 +0200
Message-ID: <CAPk1OjHbNZfcsGfmt_tyD=3YBcJaVYLvpExtVYWaSo=5jZb+sQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Add support for Emerson/Artesyn
 MVME7100
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Thanks for reviewing it!

On 19 April 2016 at 06:26, Scott Wood <oss@buserror.net> wrote:
> On Mon, 2016-04-18 at 09:57 +0200, Alessio Igor Bogani wrote:
>> +     pci0: pcie@f1008000 {
>> +             reg = <0xf1008000 0x1000>;
>> +             ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0
>> 0x50000000
>> +                       0x01000000 0x0 0x00000000 0xf0000000 0x0
>> 0x00800000>;
[...]
>> +
>> +     pci1: pcie@f1009000 {
>> +             compatible = "fsl,mpc8641-pcie";
>> +             device_type = "pci";
>> +             #size-cells = <2>;
>> +             #address-cells = <3>;
>> +             reg = <0xf1009000 0x1000>;
>> +             bus-range = <0 0xff>;
>
> Why are pci0 and pci1 so different? Why does mpc8641si-post.dtsi not have pci1?

You are right. The MPC8641 processor offers two pci so
mpc8641si-post.dtsi should be the right place where to define both.
What about the boards which don't use the pci1? Will 'status =
"disabled"' be enough?

>> +asm("        .globl _zimage_start\n\
>> +     _zimage_start:\n\
>> +             mfmsr   10\n\
>> +             rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
>> +             sync\n\
>> +             mtmsr   10\n\
>> +             isync\n\
>> +             b _zimage_start_lib\n\
>> +");
>
> Please put this in an asm file.

Ok.

> Is U-Boot really not clearing MSR[EE]?  How old is this U-Boot?
[...]
>> +     defined(TARGET_83xx) || defined(TARGET_MVME7100)
>>       unsigned long   bi_immr_base;   /* base of IMMR register
[...]
> TARGET_86xx would match the U-Boot definition better.
[...]
>> +     _set_L2CR(_get_L2CR() | L2CR_L2E);
[...]
> U-Boot doesn't enable L2 cache?

In fact it isn't U-Boot but MotLoad which it doesn't clear MSR[EE] and
disable L2 cache just before pass control to operating system. It
seems to be partially compatible with older version of U-Boot
(boot/mvme7100.c) but I wasn't able to use an uImage to boot so I have
switched to the dtbImage target.

Thanks!

Ciao,
Alessio
