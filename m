Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS6KC5rJnzDvST
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:02:23 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id e9so13104932pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 05:02:23 -0800 (PST)
Date: Tue, 29 Nov 2016 00:02:10 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Nick Clifton <nickc@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
Message-ID: <20161129000211.54199985@roar.ozlabs.ibm.com>
In-Reply-To: <a3674ff0-2c57-b04e-6cdf-3ac43296f854@redhat.com>
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
 <20161128230724.375227b4@roar.ozlabs.ibm.com>
 <a3674ff0-2c57-b04e-6cdf-3ac43296f854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 28 Nov 2016 12:39:38 +0000
Nick Clifton <nickc@redhat.com> wrote:

> Hi Nicholas,
> 
> >>> The boot wrapper performs its own relocations and does not require
> >>> PT_INTERP segment.
> >>>
> >>> Without this option, binutils 2.28 and newer tries to create a program
> >>> header segment due to PT_INTERP, and the link fails because there is no
> >>> space for it.    
> >>
> >> 2.28 is not released yet though is it?
> >>
> >> So can we just declare versions with that behaviour broken?  
> > 
> > No it's not released yet, but I don't know if it's due entirely to binutils
> > bug. Let's see what Nick thinks.  
> 
> Well the patch that caused this problem was an attempt to fix the linker so 
> that it would enforce the ELF standard.  Prior to the patch the linker would 
> silently create binaries that violated the standard and which, at least for
> the people reporting the problem in binutils PR 20815, failed to execute.
> 
> It now appears however that some programs, including the boot wrapper and the
> Linux kernel, may actually rely upon non-standard ELF binaries being created.
> Before I revert the patch however, I would like to ask...
> 
> >>> +# Do not include PT_INTERP segment when linking pie. Non-pie linking
> >>> +# just ignores this option.
> >>> +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
> >>> +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
> >>> +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
> >>> +	nodl="--no-dynamic-linker"
> >>> +fi    
> 
> ... this actually seems like a better fix to me.  If you do not want the 
> PT_INTERP segment, then telling this linker this is a good idea.  So wouldn't
> a patch like this be a better solution to the problem ?

Yes, I wasn't asking for the binutils change to be reverted. We're
generally happy to adapt to toolchain improvements. I don't think the
boot wrapper is relying on this non-standard form. If we go with
--no-dynamic-linker then I'm assuming we get a standard ELF binary?
That seems desirable.

I was just checking whether this is the best think for the kernel to do.
Is it possible to get a similar behaviour using the linker script instead
(so it's compatible with older binutils)?

Thanks,
Nick
