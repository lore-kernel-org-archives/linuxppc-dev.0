Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmKSC0bKpzDqpN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 02:19:07 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id e84so7792819oib.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 09:19:06 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160708084639.GA4562@gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <20160708084639.GA4562@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jul 2016 09:19:04 -0700
Message-ID: <CA+55aFzv4kQitzhWgxRAi5XXM30f70d4dbTGkr7t=fZSh4r3Ow@mail.gmail.com>
Subject: Re: [PATCH 0/9] mm: Hardened usercopy
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rik van Riel <riel@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 "the arch/x86 maintainers" <x86@kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Mathias Krause <minipli@googlemail.com>,
 Jan Kara <jack@suse.cz>, Vitaly Wool <vitalywool@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Laura Abbott <labbott@fedoraproject.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, sparclinux@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 8, 2016 at 1:46 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> Could you please try to find some syscall workload that does many small user
> copies and thus excercises this code path aggressively?

Any stat()-heavy path will hit cp_new_stat() very heavily. Think the
usual kind of "traverse the whole tree looking for something". "git
diff" will do it, just checking that everything is up-to-date.

That said, other things tend to dominate.

                 Linus
