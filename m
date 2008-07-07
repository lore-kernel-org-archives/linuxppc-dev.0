Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id BA64ADDEDC
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:18:03 +1000 (EST)
Date: Mon, 7 Jul 2008 17:17:33 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
Message-ID: <20080707221733.GJ9594@localdomain>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215409693.8970.79.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-07-03 at 19:19 -0700, Roland McGrath wrote:
> > Why not just use ELF_HWCAP for this?  It looks like powerpc only has 3 bits
> > left there (keeping it to 32), but 3 is not 0.  If not that, why not use
> > dsocaps?  That is, some magic in the vDSO, which glibc already supports on
> > all machines where it uses the vDSO.  (For how it works, see the use in
> > arch/x86/vdso/vdso32/note.S for CONFIG_XEN.)
> 
> Well, we use strings to represent the platforms already (ie, the actual
> CPU microarchitecture). Fitting those into bits would be annoying, it
> makes sense to have AT_BASE_PLATFORM to be the "base" variant of
> AT_PLATFORM.
> 
> _However_ there is a bug in that this patch adds an entry without
> bumping the number of entries in the cached array (ie.
> AT_VECTOR_SIZE_BASE needs to be updated).

Ugh, yes.  I was hoping to work this in such a way that AT_VECTOR_SIZE
(and thus the size of mm_struct) increases only for architectures that
implement AT_BASE_PLATFORM... would it be wrong to account for it in
AT_VECTOR_SIZE_ARCH?
