Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr9R92CnpzDrVr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 18:33:24 +1100 (AEDT)
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
Date: Tue, 27 Feb 2018 08:33:19 +0100
MIME-Version: 1.0
In-Reply-To: <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/02/2018 à 08:25, Mathieu Malaterre a écrit :
> On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:
>>
>>>>   static void __init check_cpu_feature_properties(unsigned long node)
>>>>   {
>>>> -       unsigned long i;
>>>>          struct feature_property *fp = feature_properties;
>>>>          const __be32 *prop;
>>>>
>>>
>>> Much simpler is just add
>>>
>>> if (ARRAY_SIZE() == 0)
>>>   return;
>>>
>>>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
>>
>> ...or convert to while(), which will be more readable.
> 
> So you'd prefer something like:
> 
> while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
>    ...
>    ++fp;
> }
> 
> right ?
> 


Why not do as suggested by Segher, ie just replace < by != in the 
original form ?
Or add in front:
if (!ARRAY_SIZE(feature_properties))
	return;

Christophe
