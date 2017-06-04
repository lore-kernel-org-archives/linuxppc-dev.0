Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wggSV690rzDqKc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 00:34:18 +1000 (AEST)
Received: by mail-qk0-f193.google.com with SMTP id y201so10503893qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Jun 2017 07:34:17 -0700 (PDT)
Date: Sun, 4 Jun 2017 11:34:05 -0300
From: Breno Leitao <leitao@debian.org>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: [PATCH] powerpc/kernel: improve FP and vector registers
 restoration
Message-ID: <20170604143403.c7kekgvnfigc43x3@gmail.com>
References: <1496439810-11240-1-git-send-email-leitao@debian.org>
 <20170603080411.59df057d@kryten>
 <20170603224213.7pf3vdltypx3uwom@gmail.com>
 <20170604113814.6c04fae8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170604113814.6c04fae8@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 04, 2017 at 11:38:14AM +1000, Anton Blanchard wrote:
> On Sat, 3 Jun 2017 19:42:14 -0300
> Breno Leitao <leitao@debian.org> wrote:
> 
> > Hi Anton,
> > 
> > On Sat, Jun 03, 2017 at 08:04:11AM +1000, Anton Blanchard wrote:
> > > Hi Breno,
> > >   
> > > > Currently tsk->thread->load_vec and load_fp are not initialized
> > > > during a task creation, which set garbage to these variables
> > > > (non-zero value).  
> > > 
> > > Nice catch! It seems like we should zero load_tm too though?  
> > 
> > Yes, it seems we need to zero load_tm also, since it does not seem to
> > be zeroed anywhere else.
> > 
> > But I did some tests, and load_tm is always zero after start_thread()
> > is being called.
> > 
> > In fact, start_thread() is being called and pt_regs->load_tm is
> > already zero since the function start.
> > 
> > I also wrote a SystemTap script[1] to investigate it better, and I've
> > never seen a single load_tm != 0 in a my machine. I tested on both
> > POWER8 bare metal and KVM guests. (load_vec and load_fp happened to
> > have garbage all the time)
> > 
> > Any idea if this is just occasional event, or, if there is someone
> > zeroing it in an obscure code?
> 
> Quite likely no one uses TM :) Try:

In fact, I had tested with TM[1] and haven't seen any issue, but I was not
calling a nested application (through execve() syscall). Somehow if I
call  "$ ./tm_application ; /bin/true", I do not see a non-zero load_tm
in the new task->thread.

On the other side, I see the corruption with your test case, mainly if I
sleep after 'tbegin.' and before execlp(), giving a chance to have
load_tm incremented, and this value is being inherited in the new
task->thread.

This is obviously wrong, I will send a patch to have it fixed.

Thanks for the guidance!

[1] https://github.com/leitao/htm_torture
