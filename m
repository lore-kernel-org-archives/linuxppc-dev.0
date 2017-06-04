Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgLFJ0wzbzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jun 2017 11:38:27 +1000 (AEST)
Date: Sun, 4 Jun 2017 11:38:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: [PATCH] powerpc/kernel: improve FP and vector registers
 restoration
Message-ID: <20170604113814.6c04fae8@kryten>
In-Reply-To: <20170603224213.7pf3vdltypx3uwom@gmail.com>
References: <1496439810-11240-1-git-send-email-leitao@debian.org>
 <20170603080411.59df057d@kryten>
 <20170603224213.7pf3vdltypx3uwom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 3 Jun 2017 19:42:14 -0300
Breno Leitao <leitao@debian.org> wrote:

> Hi Anton,
> 
> On Sat, Jun 03, 2017 at 08:04:11AM +1000, Anton Blanchard wrote:
> > Hi Breno,
> >   
> > > Currently tsk->thread->load_vec and load_fp are not initialized
> > > during a task creation, which set garbage to these variables
> > > (non-zero value).  
> > 
> > Nice catch! It seems like we should zero load_tm too though?  
> 
> Yes, it seems we need to zero load_tm also, since it does not seem to
> be zeroed anywhere else.
> 
> But I did some tests, and load_tm is always zero after start_thread()
> is being called.
> 
> In fact, start_thread() is being called and pt_regs->load_tm is
> already zero since the function start.
> 
> I also wrote a SystemTap script[1] to investigate it better, and I've
> never seen a single load_tm != 0 in a my machine. I tested on both
> POWER8 bare metal and KVM guests. (load_vec and load_fp happened to
> have garbage all the time)
> 
> Any idea if this is just occasional event, or, if there is someone
> zeroing it in an obscure code?

Quite likely no one uses TM :) Try:

#include <unistd.h>

int main(void)
{
        __builtin_tbegin(0);
        execlp("/bin/true", "/bin/true", NULL);
}

Anton
