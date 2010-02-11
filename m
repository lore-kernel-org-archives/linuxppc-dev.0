Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Restrict initial stack space expansion to rlimit
In-reply-to: <4B7481A6.7080300@gmx.de>
References: <10733.1265752289@neuling.org> <4B71E13C.2050905@gmx.de>
	<20100210141016.4D18.A69D9226@jp.fujitsu.com>
	<17323.1265779867@neuling.org> <4B7481A6.7080300@gmx.de>
Date: Fri, 12 Feb 2010 09:22:33 +1100
Message-ID: <17278.1265926953@neuling.org>
Cc: linux-parisc@vger.kernel.org, stable@kernel.org, aeb@cwi.nl,
	Oleg Nesterov <oleg@redhat.com>, miltonm@bga.com,
	James Morris <jmorris@namei.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Serge Hallyn <serue@us.ibm.com>, linux-fsdevel@vger.kernel.org,
	Americo Wang <xiyou.wangcong@gmail.com>,
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

In message <4B7481A6.7080300@gmx.de> you wrote:
> On 02/10/2010 06:31 AM, Michael Neuling wrote:
> > In message<20100210141016.4D18.A69D9226@jp.fujitsu.com>  you wrote:
> >>> On 02/09/2010 10:51 PM, Michael Neuling wrote:
> >>>>>> I'd still like someone with a CONFIG_STACK_GROWSUP arch to test/ACK it
> >>>>>> as well.
> >>>>>
> >>>>> There's only one CONFIG_GROWSUP arch - parisc.
> >>>>> Could someone please test it on parisc?
> >>>
> >>> I did.
> >>>
> >>>> How about doing:
> >>>>     'ulimit -s 15; ls'
> >>>> before and after the patch is applied.  Before it's applied, 'ls' should
> >>>> be killed.  After the patch is applied, 'ls' should no longer be killed.
> >>>>
> >>>> I'm suggesting a stack limit of 15KB since it's small enough to trigger
> >>>> 20*PAGE_SIZE.  Also 15KB not a multiple of PAGE_SIZE, which is a trickie
r
> >>>> case to handle correctly with this code.
> >>>>
> >>>> 4K pages on parisc should be fine to test with.
> >>>
> >>> Mikey, thanks for the suggested test plan.
> >>>
> >>> I'm not sure if your patch does it correct for parisc/stack-grows-up-case
.
> >>>
> >>> I tested your patch on  a 4k pages kernel:
> >>> root@c3000:~# uname -a
> >>> Linux c3000 2.6.33-rc7-32bit #221 Tue Feb 9 23:17:06 CET 2010 parisc GNU/
Li
> > nux
> >>>
> >>> Without your patch:
> >>> root@c3000:~# ulimit -s 15; ls
> >>> Killed
> >>> ->  correct.
> >>>
> >>> With your patch:
> >>> root@c3000:~# ulimit -s 15; ls
> >>> Killed
> >>> _or_:
> >>> root@c3000:~# ulimit -s 15; ls
> >>> Segmentation fault
> >>> ->  ??
> >>>
> >>> Any idea?
> >>
> >> My x86_64 box also makes segmentation fault. I think "ulimit -s 15" is too
 sm
> > all stack for ls.
> >> "ulimit -s 27; ls "  wroks perfectly fine.
> >
> > Arrh.  I asked Helge offline earlier to check what use to work on parisc
> > on 2.6.31.
> >
> > I guess PPC has a nice clean non-bloated ABI :-D
> 
> Hi Mikey,
> 
> I tested again, and it works for me with "ulimit -s 27" as well (on a
> 4k, 32bit kernel).
> Still, I'm not 100%  sure if your patch is correct.

Thanks for retesting

Did "ulimit -s 27" fail before you applied?

> Anyway, it seems to work.
> 
> But what makes me wonder is, why EXTRA_STACK_VM_PAGES is defined in pages at 
all.
> You wrote in your patch description:
> > This bug means that when limiting the stack to less the 20*PAGE_SIZE (eg.
> > 80K on 4K pages or 'ulimit -s 79') all processes will be killed before
> > they start.  This is particularly bad with 64K pages, where a ulimit below
> > 1280K will kill every process.
> 
> Wouldn't it make sense to define and use EXTRA_STACK_VM_SIZE instead
> (e.g. as 20*4096 = 80k)?  This extra stack reservation should IMHO be
> independend of the actual kernel page size.

If you look back through this thread, that has already been noted but
it's a separate issue to this bug, so that change will be deferred till
2.6.34.

Mikey
