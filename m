Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC7FF2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 02:47:55 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 2 Jul 2012 10:47:49 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5BF473E4006D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 16:46:34 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q62Gk2oR087428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2012 10:46:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q62GjkgP028083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2012 10:45:47 -0600
Date: Mon, 2 Jul 2012 09:45:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 3.5.0-rc5: BUG: soft lockup - CPU#0 stuck for 22s
Message-ID: <20120702164544.GJ2508@linux.vnet.ibm.com>
References: <alpine.DEB.2.01.1207010009270.5568@trent.utfs.org>
 <1341204649.2588.29.camel@pasglop>
 <alpine.DEB.2.01.1207012326110.5568@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.01.1207012326110.5568@trent.utfs.org>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 01, 2012 at 11:30:40PM -0700, Christian Kujau wrote:
> On Mon, 2 Jul 2012 at 14:50, Benjamin Herrenschmidt wrote:
> > Interesting... I observed something roughly similar on a dual G4
> > the other day associated with a 30s to 1mn pause during boot. RCU
> > was complaining loudly.
> > 
> > In my case, it did continue booting normally, is that the case for you ?
> 
> No, in my case it stopped booting, though there was no "panic" message.
> 
> > Also if I compile the kernel without CONFIG_SMP, it did go away as well,
> > do you observe that too ?
> 
> This PoweBook G4 is UP anyway and I'm always building w/o CONFIG_SMP.
> 
> > I don't have a spare cycle to investigate this problem this week I'm
> > afraid, it might help if you could try a bisection though.
> 
> Yes, I've started a bisection already and will report back.
> 
> FYI, I've put a netconsole-log below from another boot (in the 
> middle of a bisection), the instruction dump is slightly more complete.

Li Zhong posted a patch to fix this (async_synchronize_full() below):

	https://lkml.org/lkml/2012/7/2/32

This gets rid of this problem on my UP testing.  If it works for you,
please give Li Zhong a Tested-by.

							Thanx, Paul

> Thanks!
> Christian.
> 
> [   40.345973] BUG: soft lockup - CPU#0 stuck for 22s! [modprobe:691]
> [   40.347737] Modules linked in: sd_mod arc4 firewire_sbp2 scsi_mod b43 mac80211 cfg80211
> [   40.349443] irq event stamp: 65779272
> [   40.351156] hardirqs last  enabled at (65779271): [<c052fae8>] _raw_spin_unlock_irqrestore+0x40/0x9c
> [   40.352911] hardirqs last disabled at (65779272): [<c0011648>] reenable_mmu+0x40/0x98
> [   40.354649] softirqs last  enabled at (65769864): [<c000f3c0>] call_do_softirq+0x14/0x24
> [   40.356386] softirqs last disabled at (65769857): [<c000f3c0>] call_do_softirq+0x14/0x24
> [   40.358098] NIP: c005ee64 LR: c005ee54 CTR: c009c578
> [   40.359788] REGS: eece3d70 TRAP: 0901   Not tainted  (3.4.0-05609-gc80ddb5)
> [   40.361517] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 24042482  XER: 00000000
> [   40.363261] TASK = eec30b80[691] 'modprobe' THREAD: eece2000#012
> [   40.363261] GPR00: c005ee54 eece3e20 eec30b80 00000000 00000002 c005edd0 00000000 00000000 #012
> [   40.363261] GPR08: 00000000 eece2000 00000000 00000001 24042488 
> [   40.368310] NIP [c005ee64] async_synchronize_cookie_domain+0x70/0x1f4
> [   40.369978] LR [c005ee54] async_synchronize_cookie_domain+0x60/0x1f4
> [   40.371614] Call Trace:
> [   40.373226] [eece3e20] [c005ee54] async_synchronize_cookie_domain+0x60/0x1f4 (unreliable)
> [   40.374884] [eece3e70] [c005f034] async_synchronize_full+0x3c/0x74
> [   40.376524] [eece3e90] [c0082790] sys_init_module+0x178/0x1164
> [   40.378151] [eece3f40] [c00117a8] ret_from_syscall+0x0/0x38
> [   40.379783] --- Exception: c01 at 0xff5d694#012[   40.379783]     LR = 0x100041c0
> [   40.382928] Instruction dump:
> [   40.384489] 93a10044 419e0014 3d20c06f 8009d020 2f800000 419e017c 7fc3f378 4bfffed9 
> [   40.386081] 7f9f1840 419d0060 7f9f1800 419e0050 <881bf008> 2f800000 419e0014 3d20c06f
> 
> 
> -- 
> BOFH excuse #241:
> 
> _Rosin_ core solder? But...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
