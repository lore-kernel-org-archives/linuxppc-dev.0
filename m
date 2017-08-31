Return-Path: <seth.forshee@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjhVG0TtWzDrV9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:28:05 +1000 (AEST)
Received: from mail-io0-f200.google.com ([209.85.223.200])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <seth.forshee@canonical.com>)
 id 1dnOZl-0006Ny-F4
 for linuxppc-dev@lists.ozlabs.org; Thu, 31 Aug 2017 12:28:01 +0000
Received: by mail-io0-f200.google.com with SMTP id 2so21503111ion.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:28:01 -0700 (PDT)
Date: Thu, 31 Aug 2017 07:27:59 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Build failures in powerpc ptrace selftests
Message-ID: <20170831122759.6uspj5v727gyclbe@ubuntu-xps13>
References: <20170830130525.xwj3oy2cx2qdwvqc@ubuntu-xps13>
 <20170830174147.GA7040@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170830174147.GA7040@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 31, 2017 at 01:41:47AM +0800, Simon Guo wrote:
> Hi Seth,
> On Wed, Aug 30, 2017 at 08:05:25AM -0500, Seth Forshee wrote:
> > With gcc 7 from Ubuntu 17.10 I'm getting the follwing error building the
> > ptrace selftests for powerpc:
> > 
> >   ptrace-tm-vsx.c: In function ‘tm_vsx’:
> >   ptrace-tm-vsx.c:42:2: error: PIC register clobbered by ‘r2’ in ‘asm’
> >     asm __volatile__(
> >     ^~~
> >   make[1]: *** [ptrace-tm-vsx] Error 1
> >   ptrace-tm-spd-vsx.c: In function ‘tm_spd_vsx’:
> >   ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by ‘r2’ in ‘asm’
> >     asm __volatile__(
> >     ^~~
> >   make[1]: *** [ptrace-tm-spd-vsx] Error 1
> >   ptrace-tm-spr.c: In function ‘tm_spr’:
> >   ptrace-tm-spr.c:46:2: error: PIC register clobbered by ‘r2’ in ‘asm’
> >     asm __volatile__(
> >     ^~~
> > 
> > Best I can tell gcc now considers any inline asm which clobbers r2 an
> > error, and I get it even with -fno-pic. I'm not familiar with powerpc
> > asm, but it's not obvious to me why r2 is in the clobber list for any of
> > these.
> Thanks for reporting this issue.
> 
> In PPC ABI, r2 is used as TOC pointer and it might be changed by inter-module 
> function calls. I believe that is the reason why it was put into clobber list 
> originally.
> 
> In our case, dual entry is used to save TOC pointer (r2) update for function
> calls within one module. There is no r2 change and I think r2 can be moved out 
> of clobber list.
> 
> I don't have a GCC-7 environment. If possible, could you help to try following 
> patch?

Your patch fixes the build errors for me. Thanks!

Seth
