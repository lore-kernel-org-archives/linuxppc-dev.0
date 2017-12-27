Return-Path: <linus971@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z6PF32pswzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2017 07:13:43 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id p139so26213523itb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 12:13:42 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Dec 2017 12:13:39 -0800
Message-ID: <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips <linux-mips@linux-mips.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 27, 2017 at 12:11 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I tried to keep the generic patches generic, so perhaps I should just
> put the arm64 vmlinux.lds.S change in a patch on its own?

I guess it doesn't matter, but regardless of where it gets introduced
I would like to see the explanation for where the heck that magical
".init.discard.text" comes from. It's definitely not obvious from the
patches, and is presumably some odd arm64 special case.

                Linus
