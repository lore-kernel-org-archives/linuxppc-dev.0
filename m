Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE1531A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 08:11:20 +1100 (AEDT)
Message-ID: <1427317797.6468.86.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@kernel.org>
Date: Thu, 26 Mar 2015 08:09:57 +1100
In-Reply-To: <20150325183316.GA9090@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, cov@codeaurora.org,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-25 at 19:33 +0100, Ingo Molnar wrote:
> * Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
> > +static inline void arch_unmap(struct mm_struct *mm,
> > +			struct vm_area_struct *vma,
> > +			unsigned long start, unsigned long end)
> > +{
> > +	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> > +		mm->context.vdso_base = 0;
> > +}
> 
> So AFAICS PowerPC can have multi-page vDSOs, right?
> 
> So what happens if I munmap() the middle or end of the vDSO? The above 
> condition only seems to cover unmaps that affect the first page. I 
> think 'affects any page' ought to be the right condition? (But I know 
> nothing about PowerPC so I might be wrong.)

You are right, we have at least two pages.
> 
> > +#define __HAVE_ARCH_REMAP
> > +static inline void arch_remap(struct mm_struct *mm,
> > +			      unsigned long old_start, unsigned long old_end,
> > +			      unsigned long new_start, unsigned long new_end)
> > +{
> > +	/*
> > +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> > +	 * check to old_start == vdso_base.
> > +	 */
> > +	if (old_start == mm->context.vdso_base)
> > +		mm->context.vdso_base = new_start;
> > +}
> 
> mremap() doesn't allow moving multiple vmas, but it allows the 
> movement of multi-page vmas and it also allows partial mremap()s, 
> where it will split up a vma.
> 
> In particular, what happens if an mremap() is done with 
> old_start == vdso_base, but a shorter end than the end of the vDSO? 
> (i.e. a partial mremap() with fewer pages than the vDSO size)

Is there a way to forbid splitting ? Does x86 deal with that case at all
or it doesn't have to for some other reason ?

Cheers,
Ben.

> Thanks,
> 
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
