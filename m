Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24AC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 23:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A518220675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 23:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A518220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43g3qQ43LtzDqkg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 10:50:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.15.19; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43g3nQ1KtCzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 10:48:41 +1100 (AEDT)
Received: from longitude ([89.0.34.110]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lymoh-1hLRBr0TZ9-0168bR; Thu, 17
 Jan 2019 00:48:20 +0100
Date: Thu, 17 Jan 2019 00:48:16 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
Message-ID: <20190116234816.GG22334@latitude>
References: <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <20190116003535.GE22334@latitude>
 <f434aafc-7e5f-dfa2-4cfa-03119c27463a@c-s.fr>
 <20190116131637.GF22334@latitude>
 <5051e5cb-89ea-b857-1288-1ac6bfe67872@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5051e5cb-89ea-b857-1288-1ac6bfe67872@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:f4WhRHRfBK7irSH0np6l6iYlgX0fD16gk4O0MAFAs5b8rykTadh
 TLKkYyRRIKk/XXp5kHZqyT+gFGidAvaDEh19icBhTcvzY8SnmPocA5Aok/R6vin9DMSiuCb
 goc//2CzEHzE7pPTym9z2RGXGHS6eCTmgxB8VieWNJCpEmPP2njHQMoLjHbnSxa486mXWte
 CANdSNLt5/HkkYZhFvasg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bhWBjvVB4Ko=:Kwq6yeh0OK4dwtKJ6VJoPy
 xqatNBzMkZvqD6eKJJH4cUnKYgDKM3VxGtAYKwDR+3dUlaFVuqQHTqjvhB+amK9mDdzvmo40T
 pulbTnbads1eSalmZBoFjXGiv062aX98legIk8FqoVE6bJzzd0ffUNzlTkAKcm0UtbkvzhG53
 AulX4EK/jFA/8MRx7Hdl0bzUad/w74mfSdSXzmapfbPdiFV0wHV2I8dtqakBrUaT8Ci8S0hO1
 UUJ4ThkJ5uzykvHhdWV4EnfUjf/s11zNPc47rOLmv/2j9FNML41xB/i1NfCYmCvj0MqVVJk/n
 2fmaqmpg2BFefMt3sGWg8FfkxnAzhRw8p8yoeFlSO5D7FQqcTROXW0mTJh6SOargHYSxu/M8o
 ulPWE71Rv8OkabSsw8aA2t/iWIZWTJXv0iUz1bBKyjlWDsrqbXucW/Sg3TjfTVWlHCxdMhnOv
 CnGiQcvg6fYjmT0CXtnIb+SLu9Q6SoXrmDj6KK1AxqAWc1/ivA/1uHxGtdLIWOwD6vNjJb99y
 2TS7aV+bQDuIEIQRGt7v4j3dzjN46uHp3uqIzjrHYERsifhlGlbtvOZlnPbjnX5PLqLbATWZA
 kZ8mqIcMXhis87H7Vd+CZZfK60xEu3FPcJB5be38qIJfhaL9CPocEK+xgpnIpPLIfrPr3xasR
 vf243N+9+wur7qrCUH/+ZyXeuK/PzIfENQ/vkE9TXWnKCZvNepYlNks35jVyF7zToj2XawfxY
 jsBaqWJlXQxUMs+QL7ccZ8yxq6uzeXaqAt0tggl3Dd/qL1MdosubFlK87syKRMUbXlaJaz8ZF
 g10LOlUZxRxwku9/4JCDOSGnKUa1x5BEIWBBVraPO4XOVipgiGtjBUYG9lb3gAoO9elKc/rPq
 BfEVddbosW7WufyKKjf7Eu8E7Y1zTn0Su/5tq7lYKHep/Kxjn/jVC0QHdsVov5
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 02:34:53PM +0100, Christophe Leroy wrote:
> Le 16/01/2019 à 14:16, Jonathan Neuschäfer a écrit :
> > On Wed, Jan 16, 2019 at 07:55:29AM +0100, Christophe Leroy wrote:
> > > Le 16/01/2019 à 01:35, Jonathan Neuschäfer a écrit :
> > > > Thinning the kernel down a bit actually makes it boot again. Ooops...!
> > > > Maybe enabling CONFIG_STRICT_KERNEL_RWX has made it just large enough to
> > > > fail the hash table allocation, but there may have been other factors
> > > > involved (I'm not sure exactly).  Sorry for the confusion!
> > > 
> > > Ok, that must be the reason. Thanks for testing.
> > > 
> > > What about the following modification which maps a second 256Mb BAT, does it
> > > helps ?
> > > 
> > > 
> > > 
> > > diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> > > index c2f564690778..ea574596de37 100644
> > > --- a/arch/powerpc/kernel/head_32.S
> > > +++ b/arch/powerpc/kernel/head_32.S
> > > @@ -1160,6 +1160,14 @@ initial_bats:
> > >   	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
> > >   	mtspr	SPRN_IBAT0L,r8
> > >   	mtspr	SPRN_IBAT0U,r11
> > > +#ifdef CONFIG_WII
> > > +	addis	r11,r11,0x10000000@h
> > > +	addis	r8,r8,0x10000000@h
> > > +	mtspr	SPRN_DBAT2L,r8
> > > +	mtspr	SPRN_DBAT2U,r11
> > > +	mtspr	SPRN_IBAT2L,r8
> > > +	mtspr	SPRN_IBAT2U,r11
> > > +#endif
> > >   	isync
> > >   	blr
> > > 
> > > diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> > > index 3f4193201ee7..a334fd5210a8 100644
> > > --- a/arch/powerpc/mm/ppc_mmu_32.c
> > > +++ b/arch/powerpc/mm/ppc_mmu_32.c
> > > @@ -259,6 +259,8 @@ void setup_initial_memory_limit(phys_addr_t
> > > first_memblock_base,
> > >   	/* 601 can only access 16MB at the moment */
> > >   	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
> > >   		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000));
> > > +	else if (IS_ENABLED(CONFIG_WII))
> > > +		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x20000000));
> > >   	else /* Anything else has 256M mapped */
> > >   		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
> > >   }
> > 
> > I haven't tested it, but this patch won't be enough, because we're only
> > looking at the first memblock, and the additional memory in the Wii
> > (MEM2) is the second memblock.
> > 
> 
> Yes right.
> 
> 
> Would the following work instead ?
> 
> memblock_set_current_limit(0x20000000);

With the config at https://gist.githubusercontent.com/neuschaefer/12ccc87ff8aeff543fad558e8742cd2b/raw/d49d321709cac364779e6893bbd91ff5a80bcb03/config
it still doesn't boot, but with a different error:

top of MEM2 @ 13F00000

zImage starting: loaded at 0x01000000 (sp: 0x0178afa0)
Allocating 0x166b2c8 bytes for kernel...
Decompressing (0x00000000 <- 0x01011000:0x01788799)...
Done! Decompressed 0xf421f4 bytes

Linux/PowerPC load: root=/dev/mmcblk0p2 rootwait console=usbgecko1
Finalizing device tree... flat tree at 0x178b7a0
[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] __memblock_find_range_top_down(1000:20000000, 100000:100000, ffffffff, 0)
[    0.000000] __memblock_find_range_top_down: in loop, 10000000:13f00000
[    0.000000] Total memory = 319MB; using 1024kB for hash table (at d3e00000)
[    0.000000] __memblock_find_range_top_down(1000:20000000, 1000:1000, ffffffff, 0)
[    0.000000] __memblock_find_range_top_down: in loop, 10000000:13e00000
[    0.000000] __memblock_find_range_top_down(1000:20000000, 1000:1000, ffffffff, 0)
[    0.000000] __memblock_find_range_top_down: in loop, 10000000:13dff000
[    0.000000] BUG: Unable to handle kernel data access at 0xc106a434
[    0.000000] Faulting instruction address: 0xc0071bf4
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] BE PREEMPT
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00038-gc34b70d591b6-dirty #1337
[    0.000000] NIP:  c0071bf4 LR: c00727d8 CTR: 00000000
[    0.000000] REGS: c0f1fd30 TRAP: 0300   Not tainted  (5.0.0-rc1-wii-00038-gc34b70d591b6-dirty)
[    0.000000] MSR:  00001032 <ME,IR,DR,RI>  CR: 44002842  XER: 00000000
[    0.000000] DAR: c106a434 DSISR: 40000000
[    0.000000] GPR00: c0074a98 c0f1fde0 c0ead4a0 c0ead4a0 c0ead9c8 00000008 00000000 00000000
[    0.000000] GPR08: 00000003 c106a418 00000258 00000001 24000444 fb43ef5b c0f30000 7561f327
[    0.000000] GPR16: c0f40000 691cfd11 38afe359 f161e513 00000000 c0ead9c8 00000001 00000000
[    0.000000] GPR24: 00000000 c0f46288 00000000 c0ead4a0 c0ead9c8 00000008 c0ead4a0 00000100
[    0.000000] NIP [c0071bf4] mark_lock+0x64/0x858
[    0.000000] LR [c00727d8] __lock_acquire+0x334/0x1a40
[    0.000000] Call Trace:
[    0.000000] [c0f1fe20] [00000006] 0x6
[    0.000000] [c0f1fed0] [c0074a98] lock_acquire+0x110/0x20c
[    0.000000] [c0f1ff10] [c085e8cc] _raw_spin_lock+0x44/0x60
[    0.000000] [c0f1ff30] [c007f220] vprintk_emit+0xa0/0x328
[    0.000000] [c0f1ff70] [c007fc48] printk+0x5c/0x84
[    0.000000] [c0f1ffb0] [c0c00854] start_kernel+0x64/0x460
[    0.000000] [c0f1fff0] [00003438] 0x3438
[    0.000000] Instruction dump:
[    0.000000] 41820170 55086cfe 550a083c 7d4a4214 554a1838 3d20c0f4 7d4a4214 39296288
[    0.000000] 554a1838 3d290012 7d295214 39293f38 <8129001c> 7fe94839 41820028 3bc00001
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x34/0x6c with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000]
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

Not sure what's wrong. It does work with wii_defconfig, though.
I think for now I'm happy without this patch, as it doesn't seem to be
really necessary.


Jonathan
