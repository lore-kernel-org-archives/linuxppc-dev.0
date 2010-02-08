Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 4DBF2B7CF7
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 18:11:50 +1100 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o187Bno8005388 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 16:11:49 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 5CF5E45DE56
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:11:49 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 3579E45DE4F
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:11:49 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1415A1DB8044
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:11:49 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id BDEFE1DB803A
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:11:48 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Americo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
In-Reply-To: <2375c9f91002072307h4af1ba6dw1b7a598582991dc4@mail.gmail.com>
References: <20100208145240.FB58.A69D9226@jp.fujitsu.com>
	<2375c9f91002072307h4af1ba6dw1b7a598582991dc4@mail.gmail.com>
Message-Id: <20100208161014.7C6D.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Date: Mon,  8 Feb 2010 16:11:47 +0900 (JST)
Cc: Michael Neuling <mikey@neuling.org>, stable@kernel.org, aeb@cwi.nl,
	Oleg Nesterov <oleg@redhat.com>, miltonm@bga.com,
	James Morris <jmorris@namei.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	kosaki.motohiro@jp.fujitsu.com, linux-fsdevel@vger.kernel.org,
	Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mon, Feb 8, 2010 at 2:05 PM, KOSAKI Motohiro
> <kosaki.motohiro@jp.fujitsu.com> wrote:
> >> --- linux-2.6-ozlabs.orig/fs/exec.c
> >> +++ linux-2.6-ozlabs/fs/exec.c
> >> @@ -627,10 +627,13 @@ int setup_arg_pages(struct linux_binprm
> >>                       goto out_unlock;
> >>       }
> >>
> >> +     stack_base = min(EXTRA_STACK_VM_PAGES * PAGE_SIZE,
> >> +                      current->signal->rlim[RLIMIT_STACK].rlim_cur -
> >> +                        PAGE_SIZE);
> >
> > This line is a bit unclear why "- PAGE_SIZE" is necessary.
> > personally, I like following likes explicit comments.
> >
> >        stack_expand = EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> >        stack_lim = ACCESS_ONCE(rlim[RLIMIT_STACK].rlim_cur);
> >
> >        /* Initial stack must not cause stack overflow. */
> >        if (stack_expand + PAGE_SIZE > stack_lim)
> >                stack_expand = stack_lim - PAGE_SIZE;
> >
> > note: accessing rlim_cur require ACCESS_ONCE.
> >
> >
> > Thought?
> 
> It's better to use the helper function: rlimit().

AFAIK, stable tree doesn't have rlimit(). but yes, making two patch
(for mainline and for stable) is good opinion.
