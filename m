Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA1891A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 01:55:38 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 04CFD440D8F_6D5AD66B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 14:55:34 +0000 (GMT)
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 9E03143E09B_6D5AD64F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 14:55:32 +0000 (GMT)
Received: by mail-qk0-f176.google.com with SMTP id o6so70172300qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Mar 2016 06:55:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456785480.5360.60.camel@buserror.net>
References: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
 <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
 <1456785480.5360.60.camel@buserror.net>
Date: Tue, 1 Mar 2016 15:55:31 +0100
Message-ID: <CAPk1OjG8hFAtJM1wLFcTHCD1Ld9fKuvcZgKpuDZ1=o-_RQGXOw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] powerpc/86xx: Introduce and use common dtsi
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

Scott,

On 29 February 2016 at 23:38, Scott Wood <oss@buserror.net> wrote:
[...]
> Could you post a diff of what the decompiled trees look like before and after
> this change (e.g. interrupts went from 2-cell to 4-cell)?  It is very hard to
> review in this form.  Or better, like the config change, have a commit that
> first makes changes to what the unified trees will be, and then a second
> commit that generates the same output using includes.

Yes I'll surely do it.

>> +/include/ "qoriq-mpic.dtsi"
>> +     pic@40000 {
>> +             compatible = "chrp,open-pic";
>> +     };
>
> This is removing the fsl,mpic compatible, which is required for 4-cell
> interrupt specifiers.

Ok.

>> +&pci0 {
>> +     compatible = "fsl,mpc8641-pcie";
>> +     device_type = "pci";
>> +     #size-cells = <2>;
>> +     #address-cells = <3>;
>> +     bus-range = <0x0 0xff>;
>> +     clock-frequency = <33333333>;
>
> The clock frequency of PCI Express is not 33 MHz.

A lot of dtsi files into fsl directory have got that value!

>> diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
[...]
>> +/dts-v1/;
>> +
>> +/ {
>> +     compatible = "fsl,MPC8641";
>
> This compatible is pointless -- it will be overwritten by the board
> compatible.

Ok.

Thanks for have reviewed my patches.

Ciao,
Alessio
