Return-Path: <arjan@linux.intel.com>
Received: from fmsmga101.fm.intel.com (mga05.intel.com [192.55.52.89])
	by ozlabs.org (Postfix) with ESMTP id 86AA4DE285
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 23:58:02 +1000 (EST)
Message-ID: <48B55B16.7060804@linux.intel.com>
Date: Wed, 27 Aug 2008 06:48:06 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] linux-next: Tree for August 26 - Badness at
	kernel/notifier.c:25
References: <20080826184008.6be39f19.sfr@canb.auug.org.au>
	<48B44B2D.8070809@linux.vnet.ibm.com>
	<48B46610.1010809@linux.intel.com>
	<48B53695.3020703@linux.vnet.ibm.com>
In-Reply-To: <48B53695.3020703@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> 
> Thanks for reference of the patch, After replacing the patch with the latest 
> one above on the powerpc, the warning still remains
> 
> Badness at kernel/notifier.c:86

sadly you have something going on that doesn't list the modules loaded etc...

is this during boot or way later?
(because if it's the later, you might be hitting a legitimate bug ;-)

> NIP: c000000000081470 LR: c000000000081494 CTR: c00000000005a2d0
> REGS: c0000021ce0bfaf0 TRAP: 0700   Not tainted  (2.6.27-rc4-next-20080826-autotest)
> MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 24008042  XER: 00000005
> TASK = c0000015de080000[1] 'swapper' THREAD: c0000021ce0bc000 CPU: 0
> GPR00: c000000000081494 c0000021ce0bfd70 c00000000081e940 c000000000749c38 
> GPR04: 0000000000000003 0000000000000001 ffffffffffffffff c0000021ce0bfe90 
> GPR08: ffffffffffffffff ffffffffffffffff c0000000004fd9f0 c0000000004fd9f0 
> GPR12: 0000000024000042 c00000000089c300 0000000002307ef0 c0000000006332a0 
> GPR16: c000000000631f28 c000000000633388 00000000018bf8b0 0000000002700000 
> GPR20: c00000000070b07c c000000000707ef0 c000000000708160 c000000000631c58 
> GPR24: 0000000000000003 0000000000000001 c0000021ce0bfe90 0000000000000000 
> GPR28: ffffffffffffffff c000000000749c20 c0000000007bf338 c000000000749c38 
> NIP [c000000000081470] .notifier_call_chain+0x70/0x140
> LR [c000000000081494] .notifier_call_chain+0x94/0x140
> Call Trace:
> [c0000021ce0bfd70] [c000000000081494] .notifier_call_chain+0x94/0x140 (unreliable)
> [c0000021ce0bfe20] [c0000000004fe3fc] .cpu_up+0x10c/0x200
> [c0000021ce0bfee0] [c0000000006cdcc0] .kernel_init+0x1b0/0x440
> [c0000021ce0bff90] [c0000000000299cc] .kernel_thread+0x4c/0x68
> Instruction dump:
> e8630000 2fa30000 419e00f0 2fa60000 419e00e8 2e270000 7c7f1b78 3b600000 
> 48000028 60000000 60000000 60000000 <0fe00000> 2fbd0000 2f3c0000 7fbfeb78 
> 
> 
