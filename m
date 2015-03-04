Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 871CF1A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 10:56:20 +1100 (AEDT)
Message-ID: <1425513380.32154.13.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Date: Thu, 05 Mar 2015 10:56:20 +1100
In-Reply-To: <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
 <1425442601.9084.9.camel@ellerman.id.au>
 <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-04 at 13:13 -0800, Kees Cook wrote:
> 
> I had a question in the powerpc-specific change that may have gone unnoticed:
> 
> Can mmap ASLR be safely enabled in the legacy mmap case here? Other archs
> use "mm->mmap_base = TASK_UNMAPPED_BASE + random_factor".
> 
> Separate from this series, do you happen to know if this improvement
> can be made, or if the legacy mmap on powerpc can't handle this?

Yeah I saw that. The short answer is I'm not sure.

I assume we have that distinction for some good reason, but whether we still
need it I don't know. I'll dig a bit and see if anyone can remember the details.

cheers
