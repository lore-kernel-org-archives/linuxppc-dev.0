Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x22c.google.com (mail-vk0-x22c.google.com
 [IPv6:2607:f8b0:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr9G931M1zF1Sp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 18:25:37 +1100 (AEDT)
Received: by mail-vk0-x22c.google.com with SMTP id y127so11548651vky.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:25:37 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 08:25:14 +0100
Message-ID: <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:
>
>>>  static void __init check_cpu_feature_properties(unsigned long node)
>>>  {
>>> -       unsigned long i;
>>>         struct feature_property *fp = feature_properties;
>>>         const __be32 *prop;
>>>
>>
>> Much simpler is just add
>>
>> if (ARRAY_SIZE() == 0)
>>  return;
>>
>>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
>
> ...or convert to while(), which will be more readable.

So you'd prefer something like:

while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
  ...
  ++fp;
}

right ?
