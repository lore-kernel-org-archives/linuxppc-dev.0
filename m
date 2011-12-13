Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 262D9B6FF5
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 16:55:14 +1100 (EST)
Message-ID: <1323755709.19891.60.camel@pasglop>
Subject: Re: [PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Tue, 13 Dec 2011 16:55:09 +1100
In-Reply-To: <4EE6DC33.6090409@windriver.com>
References: <1323681035-19350-1-git-send-email-tiejun.chen@windriver.com>
 <4EE6DC33.6090409@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-13 at 13:01 +0800, tiejun.chen wrote:
> Tiejun Chen wrote:
> > In entry_64.S version of ret_from_except_lite, you'll notice that
> > in the !preempt case, after we've checked MSR_PR we test for any
> > TIF flag in _TIF_USER_WORK_MASK to decide whether to go to do_work
> > or not. However, in the preempt case, we do a convoluted trick to
> > test SIGPENDING only if PR was set and always test NEED_RESCHED ...
> > but we forget to test any other bit of _TIF_USER_WORK_MASK !!! So
> > that means that with preempt, we completely fail to test for things
> > like single step, syscall tracing, etc...
> > 
> > This should be fixed as the following path:
> > 
> >  - Test PR. If set, go to test_work_user, else continue.
> > 
> >  - In test_work_user, always test for _TIF_USER_WORK_MASK to decide to
> > go to do_work, maybe call it do_user_work
> > 
> >  - In test_work_kernel, test for _TIF_KERNEL_WORK_MASK which is set to
> > our new flag along with NEED_RESCHED if preempt is enabled and branch to
> > do_kernel_work.
> 
> Ben,
> 
> Any comment for this?

Sorry, I didn't get to review that one yet (nor reply to your newer
responses), I have very sore eyes and basically had to get off the
computer. Hopefully I'll be better tomorrow.

Cheers,
Ben.
