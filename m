Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPfvQ59FWzDqyK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 03:19:14 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id l68so34167006wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 09:19:14 -0700 (PDT)
Date: Tue, 15 Mar 2016 16:19:02 +0000
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Al Viro <viro@ZenIV.linux.org.uk>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build failure after merge of the aio tree
Message-ID: <20160315161901.GA2713@sudip-laptop>
References: <20160315174634.6766cd88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160315174634.6766cd88@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2016 at 05:46:34PM +1100, Stephen Rothwell wrote:
> Hi Benjamin,
> 
> After merging the aio tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
> 
> fs/built-in.o: In function `aio_thread_op_foo_at':
> aio.c:(.text+0x4dab4): undefined reference to `__get_user_bad'
> aio.c:(.text+0x4daec): undefined reference to `__get_user_bad'
> 
> Caused by commit
> 
>   150a0b4905f1 ("aio: add support for async openat()")
> 
> despite commit
> 
>   d2f7a973e11e ("aio: don't use __get_user() for 64 bit values")
> 
> This is due to a bug in the powerpc __get_user_check() macro (the return
> value is defined to be "unsigned long" which is only 32 bits on a 32
> bit platform).

m68k allmodconfig and all defs of m32r fails while building next-20160315.

regards
sudip
