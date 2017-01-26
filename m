Return-Path: <arndbergmann@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8MQ91snnzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 23:57:21 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id 101so4813244iom.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 04:57:21 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB026EBC6@AcuExch.aculab.com>
References: <20170126100044.7e439f72@kryten>
 <063D6719AE5E284EB5DD2968C1650D6DB026EBC6@AcuExch.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Jan 2017 13:57:18 +0100
Message-ID: <CAK8P3a2LuOfx-7Ypr4OPEn8r56f4zBdffPLn2wgwEmnM+zWW6g@mail.gmail.com>
Subject: Re: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
To: David Laight <David.Laight@aculab.com>
Cc: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "rric@kernel.org" <rric@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 26, 2017 at 12:00 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Anton Blanchard
>> Sent: 25 January 2017 23:01
>> gcc trunk has failed to build PowerPC64 kernels for a month or so. The issue
>> is in oprofile, which is common code but ends up being sucked into
>> arch/powerpc and therefore subject to the -Werror applied to arch/powerpc:
> ...
>> linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:25: error: %d directive
>> output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Werror=format-
>> truncation=]
>>    snprintf(buf, 10, "cpu%d", i);
>
> FFS these warnings are getting OTT.
> The compiler needs to be able to track the domain of integers before applying
> some of these warnings.

gcc-7 introduces lots of new warnings, some better than others. I'm
trying to categorize
both the new warnings and any others added in the recent years that we
may have missed
to see whether we want to turn them on by default or only in
scripts/Makefile.extrawarn
when building with W=1, W=2 or W=3.

I made a spreadsheet with the warnings that we have available in each version,
and also the number of unique output lines for that warning, see

https://docs.google.com/spreadsheets/d/1QemrLyvzrSDfm_MO3-_pwdfsTp2uqwjOdRBxxj6oo5M/edit?usp=sharing

For this specific warning, an ARM allmodconfig build shows 360
distinct warnings from a
total of 243 files. It's probably a good idea to look over them once
to see if anything sticks
out, but otherwise I think we change it to the W=2 level.

     Arnd
