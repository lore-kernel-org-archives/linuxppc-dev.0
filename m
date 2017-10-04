Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6Q7D4M8XzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 16:53:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>,
 Don Zickus <dzickus@redhat.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make watchdog_nmi_reconfigure()
 two stage
In-Reply-To: <alpine.DEB.2.20.1710032124320.2278@nanos>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
 <87o9pocvjq.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710031411440.2281@nanos>
 <alpine.DEB.2.20.1710031451590.2281@nanos>
 <alpine.DEB.2.20.1710032124320.2278@nanos>
Date: Wed, 04 Oct 2017 16:53:25 +1100
Message-ID: <877ewbqx0q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 3 Oct 2017, Thomas Gleixner wrote:
>> On Tue, 3 Oct 2017, Thomas Gleixner wrote:
>> > On Tue, 3 Oct 2017, Michael Ellerman wrote:
>> > > Hmm, I tried that patch, it makes the warning go away. But then I
>> > > triggered a deliberate hard lockup and got nothing.
>> > > 
>> > > Then I went back to the existing code (in linux-next), and I still get
>> > > no warning from a deliberate hard lockup.
>> > > 
>> > > So seems there may be some more gremlins. Will test more in the morning.
>> > 
>> > Hrm. That's weird. I'll have a look and send a proper patch series on top
>> > of next.
>> 
>> The major difference is that the reworked code utilizes
>> watchdog_nmi_reconfigure() for both init and the sysctl updates, but I
>> can't for my life figure out why that doesn't work.
>
> I collected the changes which Linus requested along with the nmi_probe()
> one and pushed them into:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/urgent
>
> That's based on 4.13 final so it neither contains 4.14 nor -next material.

Thanks. I tested that here and it seems fine. The warning at boot is
gone and it is correctly catching a hard lockup triggered via LKDTM, eg:

  # mount -t debugfs none /sys/kernel/debug
  # echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
  lkdtm: Performing direct entry HARDLOCKUP
  Watchdog CPU:0 Hard LOCKUP
  Modules linked in:
  CPU: 0 PID: 1215 Comm: sh Not tainted 4.13.0-gcc6-11846-g86be5ee #162
  task: c0000000f1fc4c00 task.stack: c0000000ee3ac000
  NIP:  c0000000007205a4 LR: c00000000071f950 CTR: c000000000720570
  REGS: c00000003ffffd80 TRAP: 0900   Not tainted  (4.13.0-gcc6-11846-g86be5ee)
  MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28002228  XER: 00000000
  CFAR: c0000000007205a8 SOFTE: 0 
  GPR00: c00000000071f950 c0000000ee3afbb0 c00000000107cf00 c0000000010604f0 
  GPR04: c0000000ffa05d90 c0000000ffa1c968 0000000000000000 0000000000000000 
  GPR08: 0000000000000007 0000000000000001 0000000000000000 9000000030001003 
  GPR12: c000000000720570 c00000000fd40000 0000000000000000 0000000000000000 
  GPR16: 0000000000000000 0000000000000000 0000000000000000 00000000100b8fd0 
  GPR20: 000001002f5a3485 00000000100b8f90 0000000000000000 0000000000000000 
  GPR24: c000000001060778 c0000000ee3afe00 c0000000ee3afe00 c0000000010603b0 
  GPR28: 000000000000000b c0000000f1fe0000 0000000000000140 c0000000010604f0 
  NIP [c0000000007205a4] lkdtm_HARDLOCKUP+0x34/0x40
  LR [c00000000071f950] lkdtm_do_action+0x50/0x70
  Call Trace:
  [c0000000ee3afbb0] [0000000000000140] 0x140 (unreliable)
  [c0000000ee3afbd0] [c00000000071f950] lkdtm_do_action+0x50/0x70
  [c0000000ee3afc00] [c00000000071fdc0] direct_entry+0x110/0x1b0
  [c0000000ee3afc90] [c00000000050141c] full_proxy_write+0x9c/0x110
  [c0000000ee3afcf0] [c000000000336a3c] __vfs_write+0x6c/0x210
  [c0000000ee3afd90] [c000000000338960] vfs_write+0xd0/0x270
  [c0000000ee3afde0] [c00000000033a93c] SyS_write+0x6c/0x110
  [c0000000ee3afe30] [c00000000000b220] system_call+0x58/0x6c
  Instruction dump:
  3842c990 7c0802a6 f8010010 f821ffe1 60000000 60000000 39400000 892d027a 
  994d027a 60000000 60420000 7c210b78 <7c421378> 4bfffff8 60420000 3c4c0096 
  Kernel panic - not syncing: Hard LOCKUP

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
