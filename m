Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBdk62HRWzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 13:49:49 +1100 (AEDT)
Received: by mail-pg0-x231.google.com with SMTP id j3so238097pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 19:49:49 -0700 (PDT)
Date: Tue, 10 Oct 2017 04:18:47 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: fix build error in powerpc ptrace
 selftests.
Message-ID: <20171009201847.GA9571@simonLocalRHEL7.x64>
References: <1504232234-4161-1-git-send-email-wei.guo.simon@gmail.com>
 <87lgkjwbxj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87lgkjwbxj.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
On Tue, Oct 10, 2017 at 09:10:32PM +1100, Michael Ellerman wrote:
> wei.guo.simon@gmail.com writes:
> 
> > From: Simon Guo <wei.guo.simon@gmail.com>
> >
> > GCC 7 will take "r2" in clobber list as an error will it will get following
> > build errors for powerpc ptrace selftests even with -fno-pic option:
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
> > This patch fix the build error by removing "r2" out of clobber list.
> 
> But do any of the blocks clobber r2? If so then it should be in the
> clobber list.

I see none of them clobbers r2, and neither does those assembly
functions which those blocks calls, like "loadvsx".

For the change on tools/testing/selftests/powerpc/ptrace/Makefile, it
can be ignored since I noticed recent commit a3c01050584da3 "selftests/powerpc: 
Force ptrace tests to build -fno-pie". Please let me know if you want
a new v2 to remove that change on ptrace/Makefile.

Thanks,
- Simon
