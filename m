Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF8F1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 18:31:42 +1100 (AEDT)
Received: by wghk14 with SMTP id k14so38196949wgh.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2015 23:31:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 3 Mar 2015 08:31:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150303073132.GA30602@gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kees Cook <keescook@chromium.org> wrote:

> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

Looks good so far:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

While reviewing this series I also noticed that the following code 
could be factored out from architecture mmap code as well:

  - arch_pick_mmap_layout() uses very similar patterns across the 
    platforms, with only few variations. Many architectures use 
    the same duplicated mmap_is_legacy() helper as well. There's 
    usually just trivial differences between mmap_legacy_base() 
    approaches as well.

  - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
    exposed to the arch routine - the arch routine should only 
    concentrate on arch details, not generic flags like
    PF_RANDOMIZE.

In theory the mmap layout could be fully parametrized as well: i.e. no 
callback functions to architectures by default at all: just 
declarations of bits of randomization desired (or, available address 
space bits), and perhaps an arch helper to allow 32-bit vs. 64-bit 
address space distinctions.

'Weird' architectures could provide special routines, but only by 
overriding the default behavior, which should be generic, safe and 
robust.

Thanks,

	Ingo
