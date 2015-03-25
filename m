Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C424D1A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 05:36:54 +1100 (AEDT)
Received: by wibgn9 with SMTP id gn9so52208624wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 11:36:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Mar 2015 19:36:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150325183647.GA9331@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150325183316.GA9090@gmail.com>
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


* Ingo Molnar <mingo@kernel.org> wrote:

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

I.e. mremap() supports the shrinking (and growing) of vmas. In that 
case mremap() will unmap the end of the vma and will shrink the 
remaining vDSO vma.

Doesn't that result in a non-working vDSO that should zero out 
vdso_base?

Thanks,

	Ingo
