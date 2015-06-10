Return-Path: <robherring2@gmail.com>
Received: from mail-vn0-x22c.google.com (mail-vn0-x22c.google.com
 [IPv6:2607:f8b0:400c:c0f::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDD11A0E41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 04:18:19 +1000 (AEST)
Received: by vnbf62 with SMTP id f62so9523780vnb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 11:18:14 -0700 (PDT)
MIME-Version: 1.0
Sender: robherring2@gmail.com
In-Reply-To: <557853D5.1040207@c-s.fr>
References: <5572D773.1090008@c-s.fr>
 <CAL_JsqLRFfjOkzw24EttG4kZtafxki+SgRHXFYoLDfjDBwGmbg@mail.gmail.com>
 <557853D5.1040207@c-s.fr>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jun 2015 13:17:53 -0500
Message-ID: <CAL_JsqKuEpBEf6noqjU-N1a38pL8L--Fv-3qfx-xA14oF_+6rg@mail.gmail.com>
Subject: Re: [BUG] mpc8323_rdb platform doesn't boot since kernel 3.16
To: leroy christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2015 at 10:12 AM, leroy christophe
<christophe.leroy@c-s.fr> wrote:
> Le 06/06/2015 17:32, Rob Herring a =C3=A9crit :
>>
>> On Sat, Jun 6, 2015 at 6:20 AM, christophe leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> I've got a MPC8323 RDB evaluation platform from freescale
>>> kernel 4.0 doesn't boot
>>> kernel 3.16 doesn't boot
>>> kernel 3.15 boots ok
>>>
>>> I disected the issue down to your commit "of/fdt: Convert FDT functions
>>> to
>>> use libfdt" (e6a6928c3ea1d0195ed75a091e345696b916c09b)
>>>
>>> Do you have an idea of what the issue could be ?
>>
>> Is your dtb older version of the dtb format (before 0x10)? libfdt
>> doesn't work on the older versions.
>
> Yes, dtb has version 0x11, which seems to be the issue (see below)

In that your bootloader doesn't understand 0x11.

>> If not, do you have logs with debug enabled in drivers/of/fdt.c?
>
> I get "unflatten: error -11 processing FDT"

Can I get the full debug prints.

> Indeed, Uboot (version 1.1.6 - installed on that evaluation board) adds a
> node called "chosen" at the end of the BLOB.
> But Uboot doesn't update the FDT len in the BLOB header, therefore the
> following test fails in fdt_offset_ptr()
>
>     if (fdt_version(fdt) >=3D 0x11)
>         if (((offset + len) < offset)
>             || ((offset + len) > fdt_size_dt_struct(fdt)))
>             return NULL;
>
>
> If I comment this test out, Linux 3.16 to 4.0 work properly on my evaluat=
ion
> board.
>
> Can we find a proper workaround for this issue ?

The options are:

- update the ancient bootloader
- make dtc build 0x10 version dtb for this platform (-V option will do this=
)
- make the kernel fix the field (I'm not sure how we get the correct
length. dt_string offset minus dt_struct offset?)
- make the kernel force the version to 0x10 (I don't think there are
any other changes from 0x10 to 0x11.)

I'd probably lean toward the 2nd option. This is what the bootloader
is compatible with and won't break if we rev the format again. I
believe there is already some plumbing to pass per platform options to
dtc. The question is what other platforms have this problem.

Rob

> Christophe
>
>
