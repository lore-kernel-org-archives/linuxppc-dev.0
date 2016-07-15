Return-Path: <keescook@google.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrKHw3LX5zDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 14:25:48 +1000 (AEST)
Received: by mail-wm0-x22f.google.com with SMTP id o80so12548142wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:25:48 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20160714232019.GA28254@350D>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 14 Jul 2016 21:25:42 -0700
Message-ID: <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] mm: Hardened usercopy
To: bsingharora@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>,
 Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-ia64@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 4:20 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Wed, Jul 13, 2016 at 02:55:55PM -0700, Kees Cook wrote:
>> [...]
>> +++ b/mm/usercopy.c
>> @@ -0,0 +1,219 @@
>> [...]
>> +/*
>> + * Checks if a given pointer and length is contained by the current
>> + * stack frame (if possible).
>> + *
>> + *   0: not at all on the stack
>> + *   1: fully within a valid stack frame
>> + *   2: fully on the stack (when can't do frame-checking)
>> + *   -1: error condition (invalid stack position or bad stack frame)
>
> Can we use enums? Makes it easier to read/debug

Sure, I will update this.

>> [...]
>> +static void report_usercopy(const void *ptr, unsigned long len,
>> +                         bool to_user, const char *type)
>> +{
>> +     pr_emerg("kernel memory %s attempt detected %s %p (%s) (%lu bytes)\n",
>> +             to_user ? "exposure" : "overwrite",
>> +             to_user ? "from" : "to", ptr, type ? : "unknown", len);
>> +     dump_stack();
>> +     do_group_exit(SIGKILL);
>
> SIGKILL -- SIGBUS?

I'd like to keep SIGKILL since it indicates a process fiddling with a
kernel bug. The real problem here is that there doesn't seem to be an
arch-independent way to Oops the kernel and kill a process ("die()" is
closest, but it's defined on a per-arch basis with varying arguments).
This could be a BUG, but I'd rather not panic the entire kernel.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
