Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrNVf03P6zF1JK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 02:52:09 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id t6so14240474qtn.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:52:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
 <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
 <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 17:52:06 +0200
Message-ID: <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>
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

On Tue, Feb 27, 2018 at 9:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
> On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
> <christophe.leroy@c-s.fr> wrote:

>>>>> Much simpler is just add
>>>>>
>>>>> if (ARRAY_SIZE() == 0)
>>>>>   return;

>> Or add in front:
>> if (!ARRAY_SIZE(feature_properties))
>>         return;
>
> (not tested) I believe the compiler still go over the for() loop and
> will complain about the original unsigned comparison.

Did you run tests? Did you look into object file?

In kernel we much rely on the compiling away the code which is
deterministically not in use.
Here I'm pretty sure it will compile away entire function.

-- 
With Best Regards,
Andy Shevchenko
