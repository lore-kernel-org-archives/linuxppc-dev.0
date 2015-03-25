Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF2241A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 05:33:24 +1100 (AEDT)
Received: by wgra20 with SMTP id a20so37647674wgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 11:33:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Mar 2015 19:33:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150325183316.GA9090@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> +static inline void arch_unmap(struct mm_struct *mm,
> +			struct vm_area_struct *vma,
> +			unsigned long start, unsigned long end)
> +{
> +	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> +		mm->context.vdso_base = 0;
> +}

So AFAICS PowerPC can have multi-page vDSOs, right?

So what happens if I munmap() the middle or end of the vDSO? The above 
condition only seems to cover unmaps that affect the first page. I 
think 'affects any page' ought to be the right condition? (But I know 
nothing about PowerPC so I might be wrong.)


> +#define __HAVE_ARCH_REMAP
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +	/*
> +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> +	 * check to old_start == vdso_base.
> +	 */
> +	if (old_start == mm->context.vdso_base)
> +		mm->context.vdso_base = new_start;
> +}

mremap() doesn't allow moving multiple vmas, but it allows the 
movement of multi-page vmas and it also allows partial mremap()s, 
where it will split up a vma.

In particular, what happens if an mremap() is done with 
old_start == vdso_base, but a shorter end than the end of the vDSO? 
(i.e. a partial mremap() with fewer pages than the vDSO size)

Thanks,

	Ingo
