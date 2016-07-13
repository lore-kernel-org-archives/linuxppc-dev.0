Return-Path: <keescook@google.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqXtQ3f81zDqHB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 08:04:30 +1000 (AEST)
Received: by mail-wm0-x22b.google.com with SMTP id o80so88839549wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:04:30 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CALCETrVDJDjdoh7yvOPd=_5twQnzQRhe8G2KLaRw-NnA1Uf__g@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-2-git-send-email-keescook@chromium.org>
 <CALCETrVDJDjdoh7yvOPd=_5twQnzQRhe8G2KLaRw-NnA1Uf__g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 13 Jul 2016 15:04:26 -0700
Message-ID: <CAGXu5jLPZiRJx8n3_7GW2bufiuUgE9=c6dQcNxDRPHMU72sD9g@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] mm: Implement stack frame object validation
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rik van Riel <riel@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>,
 Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 3:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jul 13, 2016 at 2:55 PM, Kees Cook <keescook@chromium.org> wrote:
>> This creates per-architecture function arch_within_stack_frames() that
>> should validate if a given object is contained by a kernel stack frame.
>> Initial implementation is on x86.
>>
>> This is based on code from PaX.
>>
>
> This, along with Josh's livepatch work, are two examples of unwinders
> that matter for correctness instead of just debugging.  ISTM this
> should just use Josh's code directly once it's been written.

Do you have URL for Josh's code? I'd love to see what happening there.

In the meantime, usercopy can use this...

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
