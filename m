Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 22F10B7D74
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 16:12:55 +1100 (EST)
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o1A5Cr5J013368 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 10 Feb 2010 14:12:53 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1791E45DE56
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 14:12:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E907745DE52
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 14:12:52 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C5FDAE38006
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 14:12:52 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C01C1DB8040
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 14:12:52 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Restrict initial stack space expansion to rlimit
In-Reply-To: <4B71E13C.2050905@gmx.de>
References: <10733.1265752289@neuling.org> <4B71E13C.2050905@gmx.de>
Message-Id: <20100210141016.4D18.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Wed, 10 Feb 2010 14:12:51 +0900 (JST)
Cc: Michael Neuling <mikey@neuling.org>, linux-parisc@vger.kernel.org,
	stable@kernel.org, aeb@cwi.nl, Oleg Nesterov <oleg@redhat.com>,
	miltonm@bga.com, James Morris <jmorris@namei.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	kosaki.motohiro@jp.fujitsu.com, Serge Hallyn <serue@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Americo Wang <xiyou.wangcong@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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

> On 02/09/2010 10:51 PM, Michael Neuling wrote:
> >>> I'd still like someone with a CONFIG_STACK_GROWSUP arch to test/ACK it
> >>> as well.
> >>
> >> There's only one CONFIG_GROWSUP arch - parisc.
> >> Could someone please test it on parisc?
> 
> I did.
> 
> > How about doing:
> >    'ulimit -s 15; ls'
> > before and after the patch is applied.  Before it's applied, 'ls' should
> > be killed.  After the patch is applied, 'ls' should no longer be killed.
> >
> > I'm suggesting a stack limit of 15KB since it's small enough to trigger
> > 20*PAGE_SIZE.  Also 15KB not a multiple of PAGE_SIZE, which is a trickier
> > case to handle correctly with this code.
> >
> > 4K pages on parisc should be fine to test with.
> 
> Mikey, thanks for the suggested test plan.
> 
> I'm not sure if your patch does it correct for parisc/stack-grows-up-case.
> 
> I tested your patch on  a 4k pages kernel:
> root@c3000:~# uname -a
> Linux c3000 2.6.33-rc7-32bit #221 Tue Feb 9 23:17:06 CET 2010 parisc GNU/Linux
> 
> Without your patch:
> root@c3000:~# ulimit -s 15; ls
> Killed
> -> correct.
> 
> With your patch:
> root@c3000:~# ulimit -s 15; ls
> Killed
> _or_:
> root@c3000:~# ulimit -s 15; ls
> Segmentation fault
> -> ??
> 
> Any idea?

My x86_64 box also makes segmentation fault. I think "ulimit -s 15" is too small stack for ls.
"ulimit -s 27; ls "  wroks perfectly fine.
