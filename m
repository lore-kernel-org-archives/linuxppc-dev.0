Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJzgr2RCkzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 17:38:32 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id vy10so686830pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 00:38:32 -0700 (PDT)
Date: Wed, 24 Aug 2016 15:38:27 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
Message-ID: <20160824073826.GA16442@simonLocalRHEL7.x64>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
 <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,
On Wed, Aug 24, 2016 at 12:21:23PM +1000, Daniel Axtens wrote:
> Hi Simon,
> 
> > The ckpt_regs usage in gpr32_set_common/gpr32_get_common()
> > will lead to cppcheck error.
> >
> > [arch/powerpc/kernel/ptrace.c:2062]: (error) Uninitialized variable: ckpt_regs
> > [arch/powerpc/kernel/ptrace.c:2130]: (error) Uninitialized variable: ckpt_regs
> >
> > A straightforward fix to clean it.
> 
> I'm always happy to see cppcheck warnings fixed :)
Thanks for raising this issue :)

> 
> >  static int gpr32_get_common(struct task_struct *target,
> >  		     const struct user_regset *regset,
> >  		     unsigned int pos, unsigned int count,
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >  			    void *kbuf, void __user *ubuf, bool tm_active)
> > +#else
> > +			    void *kbuf, void __user *ubuf)
> > +#endif
> 
> I wonder if it might be possible to avoid some of the ifdefs and general
> churn by making the tm_active argument __maybe_unused rather than
> ifdefing around it?
> 
> In particular, it would mean the two hunks in the function definitions
> and these these two hunks at the call site would be unnecessary:
I think keeping tm_active argument for "ifndef CONFIG_PPC_TRANSACTIONAL_MEM" 
case (with __maybe_unused prefix) will be somehow strange -- Whatever
value is provided in the caller function for tm_active, programmer might be 
puzzled and cost sometime to think about it.  I don't like to use 
"__maybe_unused" to bypass this warning.

Thanks,
- Simon
