Return-Path: <linuxppc-dev+bounces-26490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23EBC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:25:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbJj82LY4z2y2Q;
	Thu, 03 Sep 2026 22:25:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788438348;
	cv=none; b=U1y34/m2BNyvKI6VJpb3dtAcZpq9WcZvLS6pY7HXMn89FrYYMHNEo+bsaKdpINj+3yGeW4eSfTWtbQbfARzDzR0oiDYY/A745p4ewn8IwR2d1IB38+8j13QdavkcrFuwnJx9sC0ZUzwWxWL51pTeipp6pzTZK8U35Gx1Dg9PT2TefTVfCN4C38v9OA/Nloh57X14f0yKWgRf1EmEv5oNxdFzKB7D91/BrbGkOPSxOpdyAfFVP+x94yCcLE6h47b66BkihFqKDEZJ63JBLf7hUkOjQKoDi8oOHABFUDiBKyYzd0hTISY3EBx4F4eMoWImr4OPP8t0+NDxv6GUksOjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788438348; c=relaxed/relaxed;
	bh=3mGkiaH37VyeUy5oSy8sMez1ITMsV8JYC9vPfppaFFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5IzgxNb0iKnkWsCG+iSCiOhtsm+LwkFyyKL1koKIyqv8I8Kbn07fQr44E39dEMmZ+8swpxCtXG96fuChXua15qMgeH/NbY59YKsuiaaGxJCjysbUwF8PJGCBu3xotpJVcUKDEqWO4R7pKq0xi417Ho4F4NFYxLnSh7kEjWwXWNtTOfMx3knbfDG9REW9xz47UvpqRd/06OswxMGFsn/AcKZNbEz0IQ/8AwhFolV4BBMKJCSJTqw7SUEcSDjy2JMD2TiEE8l0OjJJBp2/9EVatKTc86WZ8N9y/q6njFla2Ej1y3RP9j6vet/W5iaIUiiKnb69/eB6SOEk7CjzK7D8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Oat0sOKv; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a3TplHt4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MZXOKz2D; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hv3Y/fYg; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Oat0sOKv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a3TplHt4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MZXOKz2D;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hv3Y/fYg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbJj73MsFz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 22:25:47 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8345421E98;
	Thu,  3 Sep 2026 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788438339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mGkiaH37VyeUy5oSy8sMez1ITMsV8JYC9vPfppaFFM=;
	b=Oat0sOKvv+VnNmky7ZxtqRwhQ7njBtF7LyQxRuf2uKc2fL8wg/t6bbzHq/Sh2neTCiclU/
	zSi3yGJPBGTHZaZZExjfYK7e2//Kqh95dIV+OA+1PT1AK3NpUdC8wMy8RLF5/RaDqZlw/V
	wPe4ECyKEwUZJG/Mb05TpcwhDJGk4mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788438339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mGkiaH37VyeUy5oSy8sMez1ITMsV8JYC9vPfppaFFM=;
	b=a3TplHt4TwotTd23zdYVxS59lr+ZrT7HGfuxckG9eDq/HVYUr53jEIEpjamBcAYTij8d8u
	hPeR2kTZTvTYaUCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MZXOKz2D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Hv3Y/fYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788438335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mGkiaH37VyeUy5oSy8sMez1ITMsV8JYC9vPfppaFFM=;
	b=MZXOKz2DL5R187dq9kCD1luZQ8wbHJ8hdCKQuApH64OhlDZrmRU46EWoOGirP5Rm/IHKTP
	1f7rQn2g6fH3Fzr6ZEnrhejSfdEau8sbN2ZARm9QQ06Q0DCVAvA+hDAPrvDuEhLQ6TphLp
	Stlt1npARnSVLtmoL7IBsfPPZBHr6Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788438335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mGkiaH37VyeUy5oSy8sMez1ITMsV8JYC9vPfppaFFM=;
	b=Hv3Y/fYgnHOxfKA7dJyiutiiu8SdSpfrazcQPiKfEnpWM9z4O6zjEk50Bh1To0sKW+fuOx
	nmAIepGS6SdZ7uBw==
Date: Thu, 3 Sep 2026 14:25:34 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: harshpb@linux.ibm.com,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aplnPuVk4LWgpu3n@kunlun.suse.cz>
References: <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
 <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: 8345421E98
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [12.68 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.63)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.14)[-0.677];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:helo,kunlun.suse.cz:mid]
X-Spam: Yes

On Thu, Sep 03, 2026 at 05:34:31PM +0530, Shrikanth Hegde wrote:
> Hi Michal.
> 
> On 9/3/26 5:10 PM, Michal Suchánek wrote:
> > On Thu, Sep 03, 2026 at 05:01:13PM +0530, Shrikanth Hegde wrote:
> > 
> > > 
> > > > > 
> > > > > > This is not the latest kernel so it might have been fixed in the
> > > > > > meantime for the platform in question. Will need to check that.
> > > > > > 
> > > > > 
> > > > > If possible run against current upstream and share the results.
> > > > 
> > > > https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
> > > > 
> > > > [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > > > [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > > > [  472.091624][ T6181] Call Trace:
> > > > [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
> > > > [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
> > > > [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
> > > > [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
> > > > [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
> > > > [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
> > > > [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
> > > > [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
> > > > [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
> > > > [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
> > > > [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
> > > > [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
> > > > [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
> > > > [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
> > > > [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
> > > > [  472.091938][ T6181] IRQMASK: 0
> > > > [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
> > > > [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
> > > > [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
> > > > [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
> > > > [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
> > > > [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
> > > > [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
> > > > [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
> > > > [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
> > > > [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
> > > > [  472.092033][ T6181] ---- interrupt: 3000
> > > > [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
> > > > 
> > > > This is the host, cannot run the kernel as guest because it fails to boot most
> > > > of the time inside KVM.
> > > > 
> > > 
> > > Will look into. btw the patch shared i.e below patch fixes the boot hanf issue?
> > > 
> > > https://lore.kernel.org/all/1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com/
> > 
> 
> I see code has changed a bit. So this patch is not correct anymore.
> Sorry, i should have checked.
> 
> > I would not bet on that. It looks like host side patch, and the problem
> > is with booting 7.2.2 as guest. Some 6.12 frankenkernel can be booted on
> > the same host, and used to produce the crash above by running a kernel
> > build inside the guest.
> > 
> 
> I didn't get what you are saying. Could you see if it regression only in 7.2?
> Does 7.1 works fine? If it is regression could you see if it is bisectable?
> Also, could you share the repro steps?

The repro steps are: on a mid-size LPAR (120 CPU threads, 256G RAM)
create a KVM VM that uses all host resources. Run kernel build inside
KVM VM, using all CPUs. In about a minute the host crashes with the
above a or similar trace. I don't have any kernel version with aggressive
preemption enabled that does not suffer from this problem.

There is another problem that Linux 7.2.2 often locks up on boot inside
the guest, and as a result a different kernel is needed in the guest to
reproduce the host crash. This is more recent, linux 6.12 does not have
this problem. Will try some different kernel combinations to see if I
can narrow this down. For this the repro is merely booting the kernel in
the VM, it typically fails early before userspace produces any messages.

Thanks

Michal

