Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSRLz0mmGzDw20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 12:50:03 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 3so14694012pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 17:50:03 -0800 (PST)
Date: Tue, 29 Nov 2016 12:49:42 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Nick Clifton <nickc@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
Message-ID: <20161129124942.17ee80a6@roar.ozlabs.ibm.com>
In-Reply-To: <3cc30a4c-59db-fc24-7b77-69f8665dadc3@redhat.com>
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
 <20161128230724.375227b4@roar.ozlabs.ibm.com>
 <a3674ff0-2c57-b04e-6cdf-3ac43296f854@redhat.com>
 <20161129000211.54199985@roar.ozlabs.ibm.com>
 <3cc30a4c-59db-fc24-7b77-69f8665dadc3@redhat.com>
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

On Mon, 28 Nov 2016 14:25:31 +0000
Nick Clifton <nickc@redhat.com> wrote:

> Hi Nicholas,
> 
> >> ... this actually seems like a better fix to me.  If you do not want the 
> >> PT_INTERP segment, then telling this linker this is a good idea.  So wouldn't
> >> a patch like this be a better solution to the problem ?  
> > 
> > Yes, I wasn't asking for the binutils change to be reverted.  
> 
> Oh right.  Actually it looks like at least part of the patch is going to have
> to be reverted, (the part that sorts the PT_LOAD segments into ascending order), 
> as currently it breaks building Linux  kernels.  *sigh*

If the kernel has been doing the wrong thing, we can accept the breakage.
It's a matter for binutils policy in the end I suppose.

> 
> > I don't think the
> > boot wrapper is relying on this non-standard form. If we go with
> > --no-dynamic-linker then I'm assuming we get a standard ELF binary?
> > That seems desirable.  
> 
> Yes, you definitely should get a proper ELF binary.
> 
> > I was just checking whether this is the best think for the kernel to do.
> > Is it possible to get a similar behaviour using the linker script instead
> > (so it's compatible with older binutils)?  
> 
> Actually probably not.  :-(  Several backends, including the PPC, will now 
> attempt to automatically create and install the PT_INTERP segment unless you
> explicitly tell them not too.  Even if you are using a custom linker script.

Okay. It sounds like we should use --no-dynamic-linker whether or not your
patch is changed.

Thanks,
Nick
