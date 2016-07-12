Return-Path: <luto@amacapital.net>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpyBy3GF0zDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:01:46 +1000 (AEST)
Received: by mail-lf0-x232.google.com with SMTP id f93so25355308lfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 16:01:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMzpN2j2F9gQCRGmzVb0LjQT9mmU9m=HRG2Vbf-g79+i57dvdg@mail.gmail.com>
References: <cover.1468270393.git.luto@kernel.org>
 <dc84a1b979d800049bfd0629ed9380238cba2807.1468270393.git.luto@kernel.org>
 <CAMzpN2j2F9gQCRGmzVb0LjQT9mmU9m=HRG2Vbf-g79+i57dvdg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 12 Jul 2016 16:01:23 -0700
Message-ID: <CALCETrXN3Jd=8TOsHejVNQj8ef4KH-GYzW8rD6ounq=ZX9TT5A@mail.gmail.com>
Subject: Re: [PATCH v5 18/32] signal: Consolidate {TS,
 TLF}_RESTORE_SIGMASK code
To: Brian Gerst <brgerst@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>,
 Kees Cook <keescook@chromium.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2016 at 4:57 AM, Brian Gerst <brgerst@gmail.com> wrote:
> On Mon, Jul 11, 2016 at 4:53 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> In general, there's no need for the "restore sigmask" flag to live in
>> ti->flags.  alpha, ia64, microblaze, powerpc, sh, sparc (64-bit only),
>> tile, and x86 use essentially identical alternative implementations,
>> placing the flag in ti->status.
>>
>> Replace those optimized implementations with an equally good common
>> implementation that stores it in a bitfield in struct task_struct
>> and drop the custom implementations.
>>
>> Additional architectures can opt in by removing their
>> TIF_RESTORE_SIGMASK defines.
>
> There is a small typo in the subject, should be "signal: Consolidate
> {TS,TIF}_RESTORE_SIGMASK code"

I really did mean "TLF" -- it's a powerpc-ism.  This patch doesn't
affect TIF_RESTORE_SIGMASK on architectures that have that flag,
although it makes it much easier for them to get rid of it.

--Andy
