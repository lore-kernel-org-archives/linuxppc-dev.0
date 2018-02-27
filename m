Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrQZq3pT0zF1CW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 04:25:54 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id x4so13476462uaj.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:25:54 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
 <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
 <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
 <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 18:25:31 +0100
Message-ID: <CA+7wUsw-ckcgRP8=7GfwpSkEoOc3cs=8NABgBEpDNPbwiss0bg@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2018 at 4:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 9:44 AM, Mathieu Malaterre <malat@debian.org> wro=
te:
>> On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
>> <christophe.leroy@c-s.fr> wrote:
>
>>>>>> Much simpler is just add
>>>>>>
>>>>>> if (ARRAY_SIZE() =3D=3D 0)
>>>>>>   return;
>
>>> Or add in front:
>>> if (!ARRAY_SIZE(feature_properties))
>>>         return;
>>
>> (not tested) I believe the compiler still go over the for() loop and
>> will complain about the original unsigned comparison.
>
> Did you run tests? Did you look into object file?

The goal of this series is simply to remove warning treated as error.

I tried from home and I can still see the error using gcc 6.3.0, so
the original for() loop needs to be rewritten.

  CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c: In function =E2=80=98check_cpu_feature_properti=
es=E2=80=99:
arch/powerpc/kernel/prom.c:301:16: error: comparison of unsigned
expression < 0 is always false [-Werror=3Dtype-limits]
  for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
                ^
cc1: all warnings being treated as errors


> In kernel we much rely on the compiling away the code which is
> deterministically not in use.
> Here I'm pretty sure it will compile away entire function.
>
> --
> With Best Regards,
> Andy Shevchenko
