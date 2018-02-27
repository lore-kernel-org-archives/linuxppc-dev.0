Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x230.google.com (mail-vk0-x230.google.com
 [IPv6:2607:f8b0:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr9gr4zmxzF1Cj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 18:44:24 +1100 (AEDT)
Received: by mail-vk0-x230.google.com with SMTP id s1so3878911vke.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:44:24 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
 <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 08:44:01 +0100
Message-ID: <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 27/02/2018 =C3=A0 08:25, Mathieu Malaterre a =C3=A9crit :
>>
>> On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>>
>>> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org>
>>>> wrote:
>>>
>>>
>>>>>   static void __init check_cpu_feature_properties(unsigned long node)
>>>>>   {
>>>>> -       unsigned long i;
>>>>>          struct feature_property *fp =3D feature_properties;
>>>>>          const __be32 *prop;
>>>>>
>>>>
>>>> Much simpler is just add
>>>>
>>>> if (ARRAY_SIZE() =3D=3D 0)
>>>>   return;
>>>>
>>>>> -       for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) =
{
>>>>> +       for (; fp !=3D feature_properties +
>>>>> ARRAY_SIZE(feature_properties); ++fp) {
>>>
>>>
>>> ...or convert to while(), which will be more readable.
>>
>>
>> So you'd prefer something like:
>>
>> while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
>>    ...
>>    ++fp;
>> }
>>
>> right ?
>>
>
>
> Why not do as suggested by Segher, ie just replace < by !=3D in the origi=
nal
> form ?

I can do that.

> Or add in front:
> if (!ARRAY_SIZE(feature_properties))
>         return;

(not tested) I believe the compiler still go over the for() loop and
will complain about the original unsigned comparison.

> Christophe
