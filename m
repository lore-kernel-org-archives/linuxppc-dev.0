Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x236.google.com (mail-qt0-x236.google.com
 [IPv6:2607:f8b0:400d:c0d::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zql4S1WhlzF1Dt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:45:44 +1100 (AEDT)
Received: by mail-qt0-x236.google.com with SMTP id c7so18999839qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 06:45:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:45:41 +0200
Message-ID: <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>
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

On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:

>>  static void __init check_cpu_feature_properties(unsigned long node)
>>  {
>> -       unsigned long i;
>>         struct feature_property *fp = feature_properties;
>>         const __be32 *prop;
>>
>
> Much simpler is just add
>
> if (ARRAY_SIZE() == 0)
>  return;
>
>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {

...or convert to while(), which will be more readable.

-- 
With Best Regards,
Andy Shevchenko
