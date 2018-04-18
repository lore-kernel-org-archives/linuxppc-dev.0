Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RC3J1W91zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 05:33:48 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id d79-v6so4338205lfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 12:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418192732.GD30953@bombadil.infradead.org>
References: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
 <20180417204712.GB3603@bombadil.infradead.org>
 <CAFqt6zbhHm7s=_N8QOh-+qcw=dbyx-qgq3ajp3OmGLGYANO0ww@mail.gmail.com>
 <20180418192732.GD30953@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 19 Apr 2018 01:03:43 +0530
Message-ID: <CAFqt6zY7Yzzh+iFfc0FmD9mzvCj3C67cqZQ3+xDU6D7+jGDRuw@mail.gmail.com>
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

On Thu, Apr 19, 2018 at 12:57 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Apr 19, 2018 at 12:34:15AM +0530, Souptick Joarder wrote:
>> > Re-reading spufs_ps_fault(), I wouldn't change anything inside it.  Just
>> > change its return type to vm_fault_t and call it done.
>>
>> In that case, return value of spufs_wait() has to changed
>> to VM_FAULT_ type and we end with changing all the
>> references where spufs_wait() is called. I think we shouldn't
>> go with that approach. That's the reason I introduce inline
>> vmf_handle_error() and convert err to VM_FAULT_ type.
>
> No, don't change the type of 'ret' or spufs_wait.  Just do this:
>
> -static int spufs_ps_fault(struct vm_fault *vmf,
> +static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
>                                     unsigned long ps_offs,
>                                     unsigned long ps_size)
>

Agree. but vm_insert_pfn should be replaced with new
vmf_insert_pfn, right ?
