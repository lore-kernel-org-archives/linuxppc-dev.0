Return-Path: <amodra@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7VmX6LGrzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 16:24:28 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id qo8so19226670pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2016 23:24:28 -0700 (PDT)
Date: Mon, 16 May 2016 15:54:25 +0930
From: Alan Modra <amodra@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
Message-ID: <20160516062425.GA24091@bubble.grove.modra.org>
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 03:41:09PM +0200, Florian Weimer wrote:
> We noticed that on ppc64, the sbrk system call in the 32-bit subsystem 
> returns executable memory.  I assume it is related to this, in 
> arch/powerpc/include/asm/page.h:
> 
> /*
>   * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
>   * and needs to be executable.  This means the whole heap ends
>   * up being executable.
>   */
> #define VM_DATA_DEFAULT_FLAGS32 (VM_READ | VM_WRITE | VM_EXEC | \
>                                   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> 
> 
> What is the rationale for this?  This comment must be *really* old, 

I think the comment is just plain wrong.  ppc32 needs an executable
stack because it builds trampolines on the stack to support calling
nested functions.  I presume that's why the heap is executable.  (If
I'm wrong about heap+stack needing the same protection then I can't
think of any reason to require an executable heap.)

> because ld.so in glibc should make sure that the PLT is executable.  And 
> for current binaries, .bss is *not* executable, contrary to what the 
> comment suggests.
> 
> Is this comment about pre-ELF binaries?  If yes, would it possible to 
> change the default for ELF binaries?
> 
> Thanks,
> Florian

-- 
Alan Modra
Australia Development Lab, IBM
