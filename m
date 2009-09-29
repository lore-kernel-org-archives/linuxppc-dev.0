Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 49841B7C0E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 07:03:36 +1000 (EST)
Date: Tue, 29 Sep 2009 14:03:31 -0700
From: Rex Feany <RFeany@mrv.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090929210331.GA25779@laura.chatsunix.int.mrv.com>
References: <20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):

> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 29/09/2009 10:16:38:
> >
> >
> > > hmm, yes. You do get this and mysterious SEGV if you hit the but so does
> > > other bugs too so this is probably due to missing invalidation.
> > >
> > > I suspect that something like below will fix the problem and
> > > is the "correct" fix(untested, not even compiled):
> >
> > Ok but do we also still have to worry about the "unpopulated" TLB
> > entries and invalidate them somehow when populating ?
> 
> Since I am probably the only one that knows about DAR problem I figured
> I should take a stab at it. This is not tested, but I hope Rex and the list
> can do that. Once this works as it should, we can remove all special handling
> for 8xx in copy_tofrom_user() and friends.
> No sign-off yet, want some confirmation first.

It doesn't make a difference. I applied it to the top of the tree,
it got to userspace but it is stuck. Using break I am able to dump the
registers, I'm not sure if this is useful. Oh, well, I finally got to a shell
but it is unusably slow. Is there some test code that would be better to run?
I tried looking through the mailing list archives but I couldn't find anything.

thanks!
/rex.

SysRq : Show Regs
NIP: c00588d0 LR: c000e3c4 CTR: 00001fde
REGS: c3459d90 TRAP: 0501   Not tainted  (2.6.32-rc2-00013-g2d222d9-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44008422  XER: 20006a02
TASK = c3438050[13] 'rc.sysinit' THREAD: c3458000
GPR00: c000e3c4 c3459e40 c3438050 c21a2a60 c345bdf4 0fd81032 00000000 3001e920 
GPR08: 00000000 00000005 c21a2a60 c0210000 03438260 
NIP [c00588d0] handle_mm_fault+0x10/0xacc
LR [c000e3c4] do_page_fault+0x2f0/0x474
Call Trace:
[c3459e40] [c0059328] handle_mm_fault+0xa68/0xacc (unreliable)
[c3459e90] [c000e418] do_page_fault+0x344/0x474
[c3459f40] [c000d520] handle_page_fault+0xc/0x80
Instruction dump:
4bff15f1 39600000 80010014 7d635b78 7c0803a6 bbc10008 38210010 4e800020 
7c0802a6 9421ffb0 3d60c021 be810020 <90010054> 38000000 90020000 396b4bec 

SysRq : Show Regs
NIP: c000e0e0 LR: c000d520 CTR: 00001fde
REGS: c21adde0 TRAP: 0501   Not tainted  (2.6.32-rc2-00013-g2d222d9-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 48008424  XER: 00006a02
TASK = c3438460[18] 'sh' THREAD: c21ac000
GPR00: c000d520 c21ade90 c3438460 c21adf50 0fd76cb8 c0000000 00000004 0fee8c44 
GPR08: 00009f6c c000d788 00009032 c000d514 03438670 
NIP [c000e0e0] do_page_fault+0xc/0x474
LR [c000d520] handle_page_fault+0xc/0x80
Call Trace:
[c21ade90] [c000e418] do_page_fault+0x344/0x474 (unreliable)
[c21adf40] [c000d520] handle_page_fault+0xc/0x80
Instruction dump:
3863f604 7fe4fb78 7fc5f378 4bffcd39 80010014 bbc10008 7c0803a6 38210010 
4e800020 7c0802a6 9421ff50 bf010090 <900100b4> 7c7e1b78 800300a0 7c9d2378 

SysRq : Show Regs
NIP: c005930c LR: c000e3c4 CTR: 00001fde
REGS: c21add90 TRAP: 0501   Not tainted  (2.6.32-rc2-00013-g2d222d9-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24002422  XER: 00006a02
TASK = c3438460[18] 'sh' THREAD: c21ac000
GPR00: c0236000 c21ade40 c3438460 c21a2a60 c3444df4 c3456000 00000000 feff0000 
GPR08: c21ac000 03456000 c0220000 00000001 03438670 
NIP [c005930c] handle_mm_fault+0xa4c/0xacc
LR [c000e3c4] do_page_fault+0x2f0/0x474
Call Trace:
[c21ade40] [c0059328] handle_mm_fault+0xa68/0xacc (unreliable)
[c21ade90] [c000e3c4] do_page_fault+0x2f0/0x474
[c21adf40] [c000d520] handle_page_fault+0xc/0x80
Instruction dump:
4802192d 48000094 2f9f0000 3ba00001 419e0088 7fe3fb78 4bff46a1 48000078 
7fe3fb78 4bff4695 48000070 63390020 <633f0080> 7f45d378 7f63db78 7f04c378 
