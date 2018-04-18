Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com
 [IPv6:2a00:1450:4010:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RBPJ3WdkzF1v3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 05:04:20 +1000 (AEST)
Received: by mail-lf0-x236.google.com with SMTP id p142-v6so4189541lfd.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 12:04:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417204712.GB3603@bombadil.infradead.org>
References: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
 <20180417204712.GB3603@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 19 Apr 2018 00:34:15 +0530
Message-ID: <CAFqt6zbhHm7s=_N8QOh-+qcw=dbyx-qgq3ajp3OmGLGYANO0ww@mail.gmail.com>
Subject: Re: [PATCH] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2018 at 2:17 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Apr 18, 2018 at 12:50:38AM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Reference id -> 1c8f422059ae ("mm: change return type to
>> vm_fault_t")
>>
>> Previously vm_insert_pfn() returns err but driver returns
>> VM_FAULT_NOPAGE as default. The new function vmf_insert_pfn()
>> will replace this inefficiency by returning correct VM_FAULT_*
>> type.
>>
>> vmf_handle_error is a inline wrapper function which
>> will convert error number to vm_fault_t type err.
>
> I think you sent the wrong version of this one ...
>
> The commit message should mention that we're fixing a minor bug, that
> the error from vm_insert_pfn() was being ignored and the effect of this
> is likely to be only felt in OOM situations.

Ok, I will add this.
>
>> @@ -256,11 +257,11 @@ static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
>>               vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
>>               pfn = (ctx->spu->local_store_phys + offset) >> PAGE_SHIFT;
>>       }
>> -     vm_insert_pfn(vma, vmf->address, pfn);
>> +     ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>
>>       spu_release(ctx);
>>
>> -     return VM_FAULT_NOPAGE;
>> +     return ret;
>>  }
>
> I thought I said not to introduce vmf_handle_error(), because it's too
> trivial and obfuscates what's actually going on.
>
>> -static int spufs_ps_fault(struct vm_fault *vmf,
>> +static inline vm_fault_t vmf_handle_error(int err)
>> +{
>> +     return VM_FAULT_NOPAGE;
>> +}
>> +
>
> Re-reading spufs_ps_fault(), I wouldn't change anything inside it.  Just
> change its return type to vm_fault_t and call it done.

In that case, return value of spufs_wait() has to changed
to VM_FAULT_ type and we end with changing all the
references where spufs_wait() is called. I think we shouldn't
go with that approach. That's the reason I introduce inline
vmf_handle_error() and convert err to VM_FAULT_ type.
