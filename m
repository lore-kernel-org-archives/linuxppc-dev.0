Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com
 [IPv6:2a00:1450:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88A9D1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 20:43:38 +1100 (AEDT)
Received: by wibg7 with SMTP id g7so141398965wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 02:43:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 26 Mar 2015 10:43:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150326094330.GA15407@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com>
 <1427317867.6468.87.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427317867.6468.87.camel@kernel.crashing.org>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2015-03-25 at 19:36 +0100, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > > +#define __HAVE_ARCH_REMAP
> > > > +static inline void arch_remap(struct mm_struct *mm,
> > > > +			      unsigned long old_start, unsigned long old_end,
> > > > +			      unsigned long new_start, unsigned long new_end)
> > > > +{
> > > > +	/*
> > > > +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> > > > +	 * check to old_start == vdso_base.
> > > > +	 */
> > > > +	if (old_start == mm->context.vdso_base)
> > > > +		mm->context.vdso_base = new_start;
> > > > +}
> > > 
> > > mremap() doesn't allow moving multiple vmas, but it allows the 
> > > movement of multi-page vmas and it also allows partial mremap()s, 
> > > where it will split up a vma.
> > 
> > I.e. mremap() supports the shrinking (and growing) of vmas. In that 
> > case mremap() will unmap the end of the vma and will shrink the 
> > remaining vDSO vma.
> > 
> > Doesn't that result in a non-working vDSO that should zero out 
> > vdso_base?
> 
> Right. Now we can't completely prevent the user from shooting itself 
> in the foot I suppose, though there is a legit usage scenario which 
> is to move the vDSO around which it would be nice to support. I 
> think it's reasonable to put the onus on the user here to do the 
> right thing.

I argue we should use the right condition to clear vdso_base: if the 
vDSO gets at least partially unmapped. Otherwise there's little point 
in the whole patch: either correctly track whether the vDSO is OK, or 
don't ...

There's also the question of mprotect(): can users mprotect() the vDSO 
on PowerPC?

Thanks,

	Ingo
