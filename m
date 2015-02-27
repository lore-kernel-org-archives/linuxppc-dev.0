Return-Path: <keescook@google.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDF61A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 11:20:03 +1100 (AEDT)
Received: by mail-oi0-f50.google.com with SMTP id v1so12902838oia.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 16:20:01 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5j+3D7FrAJNLHTgEuK5wnOmUZG13xxi6eONuWiY2zKCMqQ@mail.gmail.com>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
 <20150227102136.17ef1fe6@canb.auug.org.au>
 <20150226153435.df670671fb10eb9efa0fa845@linux-foundation.org>
 <CAGXu5jK0YbyL+Z=YrCfkfGbYz6=65Rr_MAXLwrF36gJa2Ce4_w@mail.gmail.com>
 <20150226160641.547657c397ecfee078779217@linux-foundation.org>
 <CAGXu5j+3D7FrAJNLHTgEuK5wnOmUZG13xxi6eONuWiY2zKCMqQ@mail.gmail.com>
Date: Thu, 26 Feb 2015 16:20:01 -0800
Message-ID: <CAGXu5jLVKzLC8qFr+B2N06PJ0Ap88=8KSphEiYtNH28uOBLp7g@mail.gmail.com>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "x86@kernel.org" <x86@kernel.org>, Hector Marco Gisbert <hecmargi@upv.es>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 ismael Ripoll <iripoll@upv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2015 at 4:11 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 26, 2015 at 4:06 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Thu, 26 Feb 2015 15:37:37 -0800 Kees Cook <keescook@chromium.org> wrote:
>>
>>> Agh, no, please let's avoid the CONFIG addition.
>>
>> That is precisely how we do this.
>>
>>> Hector mentioned in private mail that he was looking at an alternative
>>> that adds exec_base to struct mm which would avoid all this insanity.
>>>
>>> Can't we do something like:
>>>
>>> #ifndef mmap_rnd
>>> # define mmap_rnd 0
>>> #endif
>>
>> Sure, and sprinkle
>>
>> #define mmap_rnd mmap_rnd
>>
>> in five arch header files where nobody thinks to look.
>>
>> For better or for worse, we are consolidating such things into arch/*/Kconfig.
>
> Okay, fair enough. Even with your configs (though shouldn't they be
> ARCH_HAS or just HAVE?) I've now stumbled over the issue that we can't
> put randomize_et_dyn in binfmt_elf because it conflicts with linking
> against compat_binfmt_elf.

Instead of all this, how about we rework the existing CONFIG and just
change around how s390 does this to match the other architectures and
remove the ifdef in binfmt_elf.c at the same time? Let me work
something up...

-Kees

-- 
Kees Cook
Chrome OS Security
