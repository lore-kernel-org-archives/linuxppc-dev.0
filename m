Return-Path: <linuxppc-dev+bounces-26533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0254C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbpDC5f9Dz2y2K;
	Fri, 04 Sep 2026 17:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788507355;
	cv=none; b=XR2KCNXD/WLpKPKicjRMs4arPwqqkznsRH/GUTtogWd3oB/cQus8OgqbK+wi0608C6W3+frwfciIlZl5TOagWTdd4EJU/rLv7HjwNBqQ+TmShqnZ8vU9Je0amU0RDZEcYlTMOjnkQpjqjVKnTOOIOfMhNQ2x/Mw50gF9zqWS1u92UWS5Q8QvHcwFe4iK8h8mwj3p2vt/hQzGc+Z1o0FK1U5zCjnB+h6g3YdTXRaAYztJSJf0MQ6jVHcrzEsVGex8k0MZM7au1m+/m8idhrX40e+Kz+VN0QFTVHzDUydVvBfKLm9uC/CPMQlQka3n1r+txnyRYHXbrO5iMWwdkbhTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788507355; c=relaxed/relaxed;
	bh=jlo8glu3d8tCDMtMiX1PBDSYttsHIoBQEwFiVzMGTGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVgPvj+u5CZzVKL9CNufGIjVybyD1G1N5LcyaC6C7G4lxnnBmyIsRreKtn+YaBkPIpFApUvoCvalwYlkwy3TIdsuMFVAH+n8FzN8RSN9+HmAGBwIgz6bLl2dPWzl2j1hEMN7sKFP3PzgG8dFmMy19OCkL+0KI6u9Pd4rXonilx0GEQsn3cxj1ox0Qydz5SRRJKukIErcAYPs1+JhaZeNfcqJGd+IzbvSiPuTcfqg+KZWtZZWW0GgXVdy3yd5Sp5gABBfKdchY25CiJgf1K7d8u7vLNudmJ7UqOY6VpHWzS/deooquuL46Bg2lEXSILgrIIG2/OVHdkdmMC+gZCnsAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K374NweJ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t6P6y4Cy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wr0d46WO; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XbHYql2H; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K374NweJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t6P6y4Cy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wr0d46WO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XbHYql2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbpDB0cSBz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 17:35:53 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8813D22989;
	Fri,  4 Sep 2026 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788507345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlo8glu3d8tCDMtMiX1PBDSYttsHIoBQEwFiVzMGTGE=;
	b=K374NweJ5G7lZ79RZcP+dh+43Hnd810AkinlxZN52WQZ0XvboY1nVYhrwYOnGiAvxZDit2
	z39AwwM6nTPlPomkqIeZ7q69t3bBLm2NTAUDUT2Bi8bXsG8HNc8rQswi3bMhrDHKT56EA1
	+pHCNawijH0SsxbOrOXQLld/u7lWxYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788507345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlo8glu3d8tCDMtMiX1PBDSYttsHIoBQEwFiVzMGTGE=;
	b=t6P6y4CyIKvWkWkfp0vzAl2K0UTUmLueg80cL1MJzfWa62+u5t5uACxFQ2urO4QcbMPEHO
	nSEFzXSY48QPYACw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wr0d46WO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XbHYql2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788507341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlo8glu3d8tCDMtMiX1PBDSYttsHIoBQEwFiVzMGTGE=;
	b=wr0d46WOI1EnqsvXiK1FfoWP3xl5p8cjjfVyiXmjGddyQ5jFdWLtA6jBO0lf0upPROcUvX
	p+FBkPDwEmN3k4bc7XsPkRjldfAfkQtPSueIlXHSeTvGmhIjp1TrPxVtuH9HjM2GMS6bhm
	5gPXCk5nsQfgNDHnrk+Q5vi2xA5WFTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788507341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlo8glu3d8tCDMtMiX1PBDSYttsHIoBQEwFiVzMGTGE=;
	b=XbHYql2H4ogHqa7CNwiw/qkdWzeFKtXySXOSMQUYby0X1FRi8w6/oMw9JhaCdU63uYFZRF
	DkHMrVMi+yH24pDw==
Date: Fri, 4 Sep 2026 09:35:40 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <app0zGv9bvtL4nHm@kunlun.suse.cz>
References: <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 8813D22989
X-Spamd-Result: default: False [12.70 / 50.00];
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
	NEURAL_HAM_SHORT(-0.12)[-0.584];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,xenosoft.de,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
> 
> > > If possible run against current upstream and share the results.
> > 
> > https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
> > 
> > [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > [  472.091624][ T6181] Call Trace:
> > [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
> > [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
> > [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
> > [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
> > [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
> > [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
> > [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
> > [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
> > [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
> > [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
> > [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
> > [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
> > [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
> > [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
> > [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
> > [  472.091938][ T6181] IRQMASK: 0
> > [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
> > [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
> > [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
> > [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
> > [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
> > [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
> > [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
> > [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
> > [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
> > [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
> > [  472.092033][ T6181] ---- interrupt: 3000
> > [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
> > 
> > This is the host, cannot run the kernel as guest because it fails to boot most
> > of the time inside KVM.
> > 
> > > 
> > > > Nonethless, there are quite a few platforms. Originally no preemption
> > > > was the only option, and that's the reason why many people run that.
> > > > It's the conservative, known working option. And that's the reason a lot
> > > > of platfrom code does not get tested with more aggressive preemtion
> > > > models, and never gets fixed to work with them.
> > > > 
> > > 
> > > Full preemption has been there for many years!.
> > 
> > Possible for years, forced only recently.
> > 
> > > Lazy is not that aggressive compared to that.
> > > 
> > > > Simply disabling the no preemtion option does not make the platform code
> > > > ready.
> > > > 
> > > 
> > > Let's understand your crash case. Let's see where it is going wrong. I am suspecting
> > > it is some wrong usage of preemption api rather than arch can't support preemption.
> > 
> > Very likely some wrong use of the preemption API by the arch code, or no
> > use where it should have been used. It did not matter so long as people
> > could run their no preempt configs and ignore the problem.
> > 
> > Thanks
> 
> 
> Friendly LLM analysis says preemption is enabled too early and before
> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
> 
> Below is ONLY a speculation and completely UNTESTED.
> Maybe worth a try.

The patch is munged by the e-mail client, and it causes immediate
voluntary preemprion in rcu critical section and hard lockup on starting
a KVM VM.

Also it would be sort of bad news if it worked because that would be
specific to book3s KVM HV and would not help with the KVM HV from the
original report which likely is not book3s, nor with KVM PR.

Thanks

Michal

