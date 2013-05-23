Return-Path: <qcai@redhat.com>
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com [209.132.183.25])
 by ozlabs.org (Postfix) with ESMTP id 044E02C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 14:57:24 +1000 (EST)
Date: Thu, 23 May 2013 00:57:20 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
To: linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <1125086079.5019070.1369285040855.JavaMail.root@redhat.com>
In-Reply-To: <20130523034611.GX24543@dastard>
References: <40971621.4497871.1369211701112.JavaMail.root@redhat.com>
 <1805266998.4499261.1369211998387.JavaMail.root@redhat.com>
 <20130522095300.GK29466@dastard>
 <1483868349.4996990.1369279016162.JavaMail.root@redhat.com>
 <20130523034611.GX24543@dastard>
Subject: 3.9.2/3.9.3: stack overrun on s390x and ppc64 (WAS Re: 3.9.2:
 xfstests triggered panic)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>,
 Steve Best <sbest@redhat.com>, xfs@oss.sgi.com, stable@vger.kernel.org,
 Hendrik Brueckner <bhendrik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Original report:
http://oss.sgi.com/archives/xfs/2013-05/msg00683.html

Also seen on Power7:
http://marc.info/?l=3Dlinux-kernel&m=3D136927904900692&w=3D2

CAI Qian

----- Original Message -----
> From: "Dave Chinner" <david@fromorbit.com>
> To: "CAI Qian" <caiqian@redhat.com>
> Cc: "LKML" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, xfs@os=
s.sgi.com
> Sent: Thursday, May 23, 2013 11:46:11 AM
> Subject: Re: 3.9.2: xfstests triggered panic
>=20
> On Wed, May 22, 2013 at 11:16:56PM -0400, CAI Qian wrote:
> > ----- Original Message -----
> > > From: "Dave Chinner" <david@fromorbit.com>
> > > To: "CAI Qian" <caiqian@redhat.com>
> > > Cc: "LKML" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
> > > xfs@oss.sgi.com
> > > Sent: Wednesday, May 22, 2013 5:53:00 PM
> > > Subject: Re: 3.9.2: xfstests triggered panic
> > >=20
> > > On Wed, May 22, 2013 at 04:39:58AM -0400, CAI Qian wrote:
> > > > Reproduced on almost all s390x guests by running xfstests.
> > > >=20
> > > > 14634.396658=C2=A8 XFS (dm-1): Mounting Filesystem
> > > > 14634.525522=C2=A8 XFS (dm-1): Ending clean mount
> > > > 14640.413007=C2=A8  <000000000017c6d4>=C2=A8 idle_balance+0x1a0/0x3=
40
> > > > 14640.413010=C2=A8  <000000000063303e>=C2=A8 __schedule+0xa22/0xaf0
> > > > 14640.428279=C2=A8  <0000000000630da6>=C2=A8 schedule_timeout+0x186=
/0x2c0
> > > > 14640.428289=C2=A8  <00000000001cf864>=C2=A8 rcu_gp_kthread+0x1bc/0=
x298
> > > > 14640.428300=C2=A8  <0000000000158c5a>=C2=A8 kthread+0xe6/0xec
> > > > 14640.428304=C2=A8  <0000000000634de6>=C2=A8 kernel_thread_starter+=
0x6/0xc
> > > > 14640.428308=C2=A8  <0000000000634de0>=C2=A8 kernel_thread_starter+=
0x0/0xc
> > > > 14640.428311=C2=A8 Last Breaking-Event-Address:
> > > > 14640.428314=C2=A8  <000000000016bd76>=C2=A8 walk_tg_tree_from+0x3a=
/0xf4
> > > > 14640.428319=C2=A8  list_add corruption. next->prev should be prev
> > > > (0000000000000918
> > > > ), but was           (null). (next=3D          (null)).
> > >=20
> > > Where's XFS in this? walk_tg_tree_from() is part of the scheduler
> > > code. This kind of implies a stack corruption....
> > >=20
> > > > Sometimes, this pops up,
> > > > [16907.275002] WARNING: at kernel/rcutree.c:1960
> > > >=20
> > > > or this,
> > > > 15316.154171=C2=A8 XFS (dm-1): Mounting Filesystem
> > > > 15316.255796=C2=A8 XFS (dm-1): Ending clean mount
> > > > 15320.364246=C2=A8            00000000006367a2: e310b0080004       =
 lg
> > > > %r1,8(%r
> > > > 11)
> > > > 15320.364249=C2=A8            00000000006367a8: 41101010           =
 la
> > > > %r1,16(%
> > > > r1)
> > > > 15320.364251=C2=A8            00000000006367ac: e33010000004       =
 lg
> > > > %r3,0(%r
> > > > 1)
> > > > 15320.364252=C2=A8 Call Trace:
> > > > 15320.364252=C2=A8 Last Breaking-Event-Address:
> > > > 15320.364253=C2=A8  =EF=BF=BD <0000000000000000>=C2=A8 Kernel stack=
 overflow.
> > > > 15320.364308=C2=A8 CPU: 0 Tainted: GF       W    3.9.2 #1
> > > > 15320.364309=C2=A8 Process rhts-test-runne (pid: 625, task:
> > > > 000000003dccc890,
> > > > ksp: 0
> > >=20
> > > .... and there you go - a stack overflow. Your kernel stack size is
> > > too small.
> > >=20
> > > I'd suggest that you need 16k stacks on s390 - IIRC every function
> > > call has 128 byte stack frame, and there are call chains 70-80
> > > functions deep in the storage stack...
> > Hmm, I am unsure how to set to 16k stack there
>=20
> Are you build a 64 bit s390 kernel or a 32 bit kernel? 32 bit
> kernels only have an 8k stack size, 64 bit kernels are 16k (see
> arch/s390/Makefile).
>=20
> $ git grep STACK_SIZE arch/s390 |head -2
> arch/s390/Makefile:STACK_SIZE   :=3D 8192
> arch/s390/Makefile:STACK_SIZE   :=3D 16384
>=20
> As it is, the stack frame usage is worse than I thought:
>=20
> $ git grep STACK_FRAME_OVERHEAD arch/s390 |head -2
> arch/s390/include/uapi/asm/ptrace.h:#define STACK_FRAME_OVERHEAD 96      =
/*
> size of minimum stack frame */
> arch/s390/include/uapi/asm/ptrace.h:#define STACK_FRAME_OVERHEAD 160     =
 /*
> size of minimum stack frame */
>=20
> Overhead is 96 bytes for 32 bit and 160 bytes for 64 bit. So 16k
> stack size is going to have big troubles with a 70-80 function deep
> call chain.
>=20
> As for powerpc:
>=20
> arch/powerpc/include/asm/ppc_asm.h:#define STACKFRAMESIZE 256
>=20
> Yeah, same issue.
>=20
> But, seriously, these stack traces are meaningless to anyone not
> familiar with s390 or power7 - they indicate a problem detected
> in the idle loop, not where ever the stack overran.
>=20
> Can you please work with the s390/power7 people to obtain whatever
> stack it was that overflowed, and we can go from there.
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
