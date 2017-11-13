Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb5935D3RzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 20:35:34 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id z184so6867050pgd.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 01:35:34 -0800 (PST)
Date: Mon, 13 Nov 2017 18:35:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv4 3/6] powerpc64: Add .opd based function descriptor
 dereference
Message-ID: <20171113093527.GA24353@jagdpanzerIV>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
 <20171109234830.5067-4-sergey.senozhatsky@gmail.com>
 <20171113071149.crpthceuvtxtzj2s@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113071149.crpthceuvtxtzj2s@santosiv.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (11/13/17 12:41), Santosh Sivaraj wrote:
> * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote (on 2017-11-10 08:48:27 +0900):
> 
> > We are moving towards separate kernel and module function descriptor
> > dereference callbacks. This patch enables it for powerpc64.
> > 
> > For pointers that belong to the kernel
> > -  Added __start_opd and __end_opd pointers, to track the kernel
> >    .opd section address range;
> > 
> > -  Added dereference_kernel_function_descriptor(). Now we
> >    will dereference only function pointers that are within
> >    [__start_opd, __end_opd);
> > 
> > For pointers that belong to a module
> > -  Added dereference_module_function_descriptor() to handle module
> >    function descriptor dereference. Now we will dereference only
> >    pointers that are within [module->opd.start, module->opd.end).
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  arch/powerpc/include/asm/module.h   |  3 +++
> >  arch/powerpc/include/asm/sections.h | 12 ++++++++++++
> >  arch/powerpc/kernel/module_64.c     | 14 ++++++++++++++
> >  arch/powerpc/kernel/vmlinux.lds.S   |  2 ++
> >  4 files changed, 31 insertions(+)
> >
> 
> Looks good on powerpc. If you wish:
> 
> Tested-by: Santosh Sivaraj <santosh@fossix.org> # for powerpc

thanks!

	-ss
