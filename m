Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C2FC2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 19:03:46 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 8 Apr 2013 14:28:42 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 60655E004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 14:35:26 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3893Znh6488400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 14:33:35 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3893b23027716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 19:03:38 +1000
Message-ID: <1365411814.2753.74.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH v2 2/6] powerpc: Exception hooks for context
 tracking subsystem
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 08 Apr 2013 17:03:34 +0800
In-Reply-To: <20130405025025.GB22465@drongo>
References: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1364551221-23177-3-git-send-email-zhong@linux.vnet.ibm.com>
 <20130405025025.GB22465@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-05 at 13:50 +1100, Paul Mackerras wrote:
> On Fri, Mar 29, 2013 at 06:00:17PM +0800, Li Zhong wrote:
> > This is the exception hooks for context tracking subsystem, including
> > data access, program check, single step, instruction breakpoint, machine check,
> > alignment, fp unavailable, altivec assist, unknown exception, whose handlers
> > might use RCU.
> > 
> > This patch corresponds to
> > [PATCH] x86: Exception hooks for userspace RCU extended QS
> >   commit 6ba3c97a38803883c2eee489505796cb0a727122
> > 
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>


Hi Paul, 

Thanks for your review! Please check my answers below, and correct me if
any errors.

> Is there a reason why you didn't put the exception_exit() call in
> ret_from_except_lite in entry_64.S, and the exception_entry() call in
> EXCEPTION_PROLOG_COMMON?  That would seem to catch all these cases in
> a more centralized place.

It seems to me that ret_from_except_lite and EXCEPTION_PROLOG_COMMON are
also used by interrupts, where I think we don't need the hooks. So using
this way could help to avoid adding overhead to these code path
(interrupts, and some exit path of syscall). 

And I think adding the hook on higher level code seems a little easier
for reading and checking. It seems that some exceptions don't use
EXCEPTION_PROLOG_COMMON, and some don't go ret_from_except_lite exit
path (like fp unavailable might go directly to fast_exception_return ).
Maybe fast_exception_return is a centralized place for us to return to
user space? But it still adds some overheads which is not necessarily
needed. 

And I think it also makes the implementation here consistent with the
style that x86 uses. 

> Also, I notice that with the exception_exit calls where they are, we
> can still deliver signals (thus possibly taking a page fault) or call
> schedule() for preemption after the exception_exit() call.  Is that
> OK, or is it a potential problem?

If I understand correctly, I guess you are talking about the cases where
we might return to user space without context state correctly being set
as in user?

There is user_enter() called in do_notify_resume() in patch #3, so after
handling the signals we always call user_enter(). 

There are also some changes of the context_tracking code from Frederic,
which might be related: ( they are now in tip tree, and url of the
patches for your convenience https://lkml.org/lkml/2013/3/1/266 )

6c1e0256fad84a843d915414e4b5973b7443d48d
context_tracking: Restore correct previous context state on exception
exit. 

With this patch, if a later exception happened after user_enter(),
before the CPU actually returns to user space, the correct context
state(in user) is saved and restored when handling the later exception. 

Patch #6 converts the code to use these new APIs, which is currently not
available in powerpc tree. 

b22366cd54c6fe05db426f20adb10f461c19ec06
context_tracking: Restore preempted context state after
preempt_schedule_irq

With this patch, the user context state could be correctly restored
after schedule returns. 

Thanks, Zhong

> Paul.
> 
