Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-x22a.google.com (mail-vc0-x22a.google.com
 [IPv6:2607:f8b0:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A7641400C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 00:32:44 +1100 (EST)
Received: by mail-vc0-f170.google.com with SMTP id hu19so3198812vcb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 06:32:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <533EB207.1020203@monstr.eu>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-10-git-send-email-robherring2@gmail.com>
 <533EA2B0.7080703@monstr.eu>
 <CAL_JsqKFK8YDoODYKg5b8SmDzqdNSS6UvYr3_atzhcL2uR-=rA@mail.gmail.com>
 <533EB207.1020203@monstr.eu>
Date: Fri, 4 Apr 2014 08:32:41 -0500
Message-ID: <CAL_Jsq+tf4wgjB7uTNipWEj5d6tPkd6QwO_xiW87P51Y_y48vw@mail.gmail.com>
Subject: Re: [PATCH 09/20] of/fdt: create common debugfs
From: Rob Herring <robherring2@gmail.com>
To: Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 4, 2014 at 8:22 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 04/04/2014 03:00 PM, Rob Herring wrote:
>> On Fri, Apr 4, 2014 at 7:16 AM, Michal Simek <monstr@monstr.eu> wrote:
>>> On 04/04/2014 12:16 AM, Rob Herring wrote:
>>>> From: Rob Herring <robh@kernel.org>
>>>>
>>>> Both powerpc and microblaze have the same FDT blob in debugfs feature.
>>>> Move this to common location and remove the powerpc and microblaze
>>>> implementations. This feature could become more useful when FDT
>>>> overlay support is added.
>>
>> [snip]

> Anyway I am testing it for microblaze and getting problem
> caused by this patch:
> commit 3d2ee8571ac0580d49c3f41fa28336289934900a
> Author: Rob Herring <robh@kernel.org>
> Date:   Wed Apr 2 15:10:14 2014 -0500
>
>     of/fdt: Convert FDT functions to use libfdt
>
> And reason is that in unflatten_dt_node()
>
> pathp = fdt_get_name(blob, *poffset, &l);
>
> is returning NULL
> and here
>         /* version 0x10 has a more compact unit name here instead of the full
>          * path. we accumulate the full path size using "fpsize", we'll rebuild
>          * it later. We detect this because the first character of the name is
>          * not '/'.
>          */
>         if ((*pathp) != '/') {
>
> code is trying to read it which is causing this kernel bug:
> Oops: kernel access of bad area, sig: 11
>
> It means fdt_next_node(is doing something wrong)
>
> Any easy way how to debug it?

I didn't think fdt_get_path should fail. Can you add a print of
*poffset and pathp values.

Rob
