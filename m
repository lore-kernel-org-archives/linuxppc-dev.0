Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B9A81A03AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 15:17:01 +1000 (AEST)
Message-ID: <1442899021.18408.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when
 passing it to probe_kernel_address()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 15:17:01 +1000
In-Reply-To: <1442888219.19102.213.camel@freescale.com>
References: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
 <1442888219.19102.213.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 21:16 -0500, Scott Wood wrote:
> On Mon, 2015-09-21 at 17:22 +0800, Kevin Hao wrote:
> > With the reimplementation of probe_kernel_address() in commit
> > ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
> > probe_kernel_read()"), the explication of the cast for the addr
> > parameter has been dropped. So we have to explicitly cast the
> > regs->nip to void * when passing it to probe_kernel_address() in
> > order to fix the following build error:
> >   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
> >   arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of 
> > 'probe_kernel_read' makes pointer from integer without a cast [-Werror]
> >       ret = probe_kernel_address(regs->nip, inst);
> >       ^
> > 
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > 
> > This is against linux-next.
> 
> I don't see ecc83243e1d4 in linux-next.  What tree is it in?

It was in linux-next:

  commit ecc83243e1d4f67015906017e420435aff1104c9
  Author:     Andrew Morton <akpm@linux-foundation.org>
  AuthorDate: Thu Sep 17 10:19:09 2015 +1000
  Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
  CommitDate: Thu Sep 17 10:19:09 2015 +1000

      uaccess: reimplement probe_kernel_address() using probe_kernel_read()


But Andrew's tree comes as patches that Stephen commits, so the commit ids
change when Andrew pushes new patches, so in today's linux-next it's:


  commit d2cf644bea102203f9fc221a819f2dcb6a15b8ad
  Author:     Andrew Morton <akpm@linux-foundation.org>
  AuthorDate: Sat Sep 19 11:36:21 2015 +1000
  Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
  CommitDate: Sat Sep 19 11:36:21 2015 +1000

      uaccess: reimplement probe_kernel_address() using probe_kernel_read()


cheers
