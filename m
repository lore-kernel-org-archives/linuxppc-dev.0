Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RBwD4bXxzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 05:27:40 +1000 (AEST)
Date: Wed, 18 Apr 2018 12:27:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
Message-ID: <20180418192732.GD30953@bombadil.infradead.org>
References: <20180417192038.GA22918@jordon-HP-15-Notebook-PC>
 <20180417204712.GB3603@bombadil.infradead.org>
 <CAFqt6zbhHm7s=_N8QOh-+qcw=dbyx-qgq3ajp3OmGLGYANO0ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFqt6zbhHm7s=_N8QOh-+qcw=dbyx-qgq3ajp3OmGLGYANO0ww@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2018 at 12:34:15AM +0530, Souptick Joarder wrote:
> > Re-reading spufs_ps_fault(), I wouldn't change anything inside it.  Just
> > change its return type to vm_fault_t and call it done.
> 
> In that case, return value of spufs_wait() has to changed
> to VM_FAULT_ type and we end with changing all the
> references where spufs_wait() is called. I think we shouldn't
> go with that approach. That's the reason I introduce inline
> vmf_handle_error() and convert err to VM_FAULT_ type.

No, don't change the type of 'ret' or spufs_wait.  Just do this:

-static int spufs_ps_fault(struct vm_fault *vmf,
+static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
                                    unsigned long ps_offs,
                                    unsigned long ps_size)
