Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RC8g1z7YzF1RM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 05:38:27 +1000 (AEST)
Date: Wed, 18 Apr 2018 12:38:21 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
Message-ID: <20180418193821.GE30953@bombadil.infradead.org>
References: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
 <20180417204712.GB3603@bombadil.infradead.org>
 <CAFqt6zbhHm7s=_N8QOh-+qcw=dbyx-qgq3ajp3OmGLGYANO0ww@mail.gmail.com>
 <20180418192732.GD30953@bombadil.infradead.org>
 <CAFqt6zY7Yzzh+iFfc0FmD9mzvCj3C67cqZQ3+xDU6D7+jGDRuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFqt6zY7Yzzh+iFfc0FmD9mzvCj3C67cqZQ3+xDU6D7+jGDRuw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2018 at 01:03:43AM +0530, Souptick Joarder wrote:
> On Thu, Apr 19, 2018 at 12:57 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Thu, Apr 19, 2018 at 12:34:15AM +0530, Souptick Joarder wrote:
> >> > Re-reading spufs_ps_fault(), I wouldn't change anything inside it.  Just
> >> > change its return type to vm_fault_t and call it done.
> >>
> >> In that case, return value of spufs_wait() has to changed
> >> to VM_FAULT_ type and we end with changing all the
> >> references where spufs_wait() is called. I think we shouldn't
> >> go with that approach. That's the reason I introduce inline
> >> vmf_handle_error() and convert err to VM_FAULT_ type.
> >
> > No, don't change the type of 'ret' or spufs_wait.  Just do this:
> >
> > -static int spufs_ps_fault(struct vm_fault *vmf,
> > +static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
> >                                     unsigned long ps_offs,
> >                                     unsigned long ps_size)
> >
> 
> Agree. but vm_insert_pfn should be replaced with new
> vmf_insert_pfn, right ?

Oh, right, sorry, I missed that.

So something like this:

-static int spufs_ps_fault(struct vm_fault *vmf,
+static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
                                    unsigned long ps_offs,
                                    unsigned long ps_size)
 {
        struct spu_context *ctx = vmf->vma->vm_file->private_data;
        unsigned long area, offset = vmf->pgoff << PAGE_SHIFT;
-       int ret = 0;
+       int err = 0;
+       vm_fault_t ret = VM_FAULT_NOPAGE;
 
        spu_context_nospu_trace(spufs_ps_fault__enter, ctx);
 
@@ -349,21 +350,22 @@ static int spufs_ps_fault(struct vm_fault *vmf,
        if (ctx->state == SPU_STATE_SAVED) {
                up_read(&current->mm->mmap_sem);
                spu_context_nospu_trace(spufs_ps_fault__sleep, ctx);
-               ret = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
+               err = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
                spu_context_trace(spufs_ps_fault__wake, ctx, ctx->spu);
                down_read(&current->mm->mmap_sem);
        } else {
                area = ctx->spu->problem_phys + ps_offs;
-               vm_insert_pfn(vmf->vma, vmf->address, (area + offset) >> PAGE_SHIFT);
+               ret = vmf_insert_pfn(vmf->vma, vmf->address,
+                               (area + offset) >> PAGE_SHIFT);
                spu_context_trace(spufs_ps_fault__insert, ctx, ctx->spu);
        }
 
-       if (!ret)
+       if (!err)
                spu_release(ctx);
 
 refault:
        put_spu_context(ctx);
-       return VM_FAULT_NOPAGE;
+       return ret;
 }
