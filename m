Return-Path: <linuxppc-dev+bounces-27218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B9C88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:58:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk2FZ2GcPz2yjw;
	Mon, 14 Sep 2026 20:58:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789383522;
	cv=none; b=FRZkatKctGSERTbJwxTK/YqzjEdA27tTmjFWg4fXoGizTj++/k/aTTXm4ZPM6wa3rW3HJhXUyQIMu32tHNjDQUYsVXTt2KafS23WpGj6A7PvrtE5SyMM/K0jsOGrPD+uKdg0ZKyb5XNoQ8w5xjvtiXOrMJU3miXZO0ZcZnB/ZeA28nT7tMh7KLtLY5PSlqaYcZh6YjMnISU0baV9X7O9MG48keWkimA7AIEnxwhSWh2sx9hj/vsH2pUC/Re4Y4OqEvrDdF8WblVRVmPbROeqxMuNaB/EJd/7ayuKF7zkqPHSTaSU/3XWooMHmhArcimfYXnYLTf2A9GANGNr+lIYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789383522; c=relaxed/relaxed;
	bh=+nE3UQjTdih4qBRdU4Jt0Vi/lTboRPWOL+q3kD4S5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kam9acsFt9xC5Ahx8etLfWlygq4qr2+JeVEANJIrB9Hm6KFMmDvyRc7Q4dhQMExPMoCQRjPgvUoWqqCPoFnY+QLwhGS42duuKoeR+IciehlqA0APhyrZXNE/pHcpKZfbnUNKatzz9g6r5wl9axBJ8A3H3PvW6fgFVtWV9W2KDz3WOsXu/8eg9dZZ7DVzl/4yaYMD/0or2PvP4GINFEajX3j0BsarmRSIUpklX1vHM/h5Kpigco2ae2LLOxhxYK075dEUylKbOFVG01qvXcV0ggqk+Feryo+dmU1Gd7SwaAcjsieWA2VqWoQfd4MW4vU+kM2G3AxK7li3SPFiN97h7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ygWKacFp; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rQ/lNG7n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PicNJzO9; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HeQxAp4K; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ygWKacFp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rQ/lNG7n;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PicNJzO9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HeQxAp4K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk2FX4d7gz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 20:58:40 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 968B121BBF;
	Mon, 14 Sep 2026 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789383512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nE3UQjTdih4qBRdU4Jt0Vi/lTboRPWOL+q3kD4S5KA=;
	b=ygWKacFpcY+o2V5zlMKMjeCbDARj8vbHB8txwzoYUvk91w/8dfzcXcQkS04uhAOVb2qUFi
	2wAZhtH8io3DCpdv+kj1cFkNJAn8PJizIU9+3ob5WW0Xl0KoAF9WNaWSdcrZHAU1BGk8nx
	R84ZYx5OlCFAkDIZ3gJqrEuLHVO/JwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789383512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nE3UQjTdih4qBRdU4Jt0Vi/lTboRPWOL+q3kD4S5KA=;
	b=rQ/lNG7nd/Jp1R0IdinHqBpHyE6BdnX92ckDVHTNP8BfPc7bNe2/qNS1IVrGvdaLTisZ+p
	1wMJRqzahk9EiBAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PicNJzO9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HeQxAp4K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789383508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nE3UQjTdih4qBRdU4Jt0Vi/lTboRPWOL+q3kD4S5KA=;
	b=PicNJzO9kvwysr5r9Fb4Ce7OWu3G9/cDYh4BtzH87gDUjcn3M/K/KvD0ddrNnGPgqK6yrz
	xxy+draQxHOXuxZD//oxgt+w7ncmOXiqBcoLp7+S0Kiw+FjudJ8xXX10neB8xAM+7UEs5O
	ArAfzqHH4ZyMLpf/aQJQTbBKAA/YIFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789383508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nE3UQjTdih4qBRdU4Jt0Vi/lTboRPWOL+q3kD4S5KA=;
	b=HeQxAp4KUS9MZIP583kkP10Z8ovyFTytJfItol8cQkjoIGvjrixOL3Hs4iCNqGyOqsWfdQ
	VQ/WUzxpFH0gg6Cw==
Date: Mon, 14 Sep 2026 12:58:27 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
	Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>, nnmlinux@linux.ibm.com,
	Samir M <samir@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
References: <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
 <app0zGv9bvtL4nHm@kunlun.suse.cz>
 <4eef1f0b-0c02-4377-b950-43c3b120865a@linux.ibm.com>
 <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
 <aqKUhHb9UTfVq4As@kunlun.suse.cz>
 <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
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
In-Reply-To: <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 968B121BBF
X-Spamd-Result: default: False [12.69 / 50.00];
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
	NEURAL_HAM_SHORT(-0.13)[-0.642];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ellerman.id.au,linux.ibm.com,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Fri, Sep 11, 2026 at 10:39:10PM +0530, Shrikanth Hegde wrote:
> Hi Michal,
> 
> On 9/10/26 5:46 PM, Michal Suchánek wrote:
> > On Thu, Sep 10, 2026 at 01:29:08PM +0200, Michal Suchánek wrote:
> > > On Thu, Sep 10, 2026 at 04:11:20PM +0530, Shrikanth Hegde wrote:
> > > > 
> > > > 
> > > > On 9/10/26 2:29 PM, Michal Suchánek wrote:
> > > > > On Fri, Sep 04, 2026 at 02:34:21PM +0530, Shrikanth Hegde wrote:
> > > > > > 
> > > > > > 
> > > > > > On 9/4/26 1:05 PM, Michal Suchánek wrote:
> > > > > > > On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
> > > > > > > > 
> > > > > > > > > > If possible run against current upstream and share the results.
> > > > > > > > > 
> > > > > > > > > https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
> > > > > > > > > 
> > > > > > > > > [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > > > > > > [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > > > > > > > > [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > > > > > > > > [  472.091624][ T6181] Call Trace:
> > > > > > > > > [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
> > > > > > > > > [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
> > > > > > > > > [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
> > > > > > > > > [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
> > > > > > > > > [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > > > > > > [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
> > > > > > > > > [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
> > > > > > > > > [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
> > > > > > > > > [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
> > > > > > > > > [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
> > > > > > > > > [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
> > > > > > > > > [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
> > > > > > > > > [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
> > > > > > > > > [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
> > > > > > > > > [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
> > > > > > > > > [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
> > > > > > > > > [  472.091938][ T6181] IRQMASK: 0
> > > > > > > > > [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
> > > > > > > > > [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > > [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > > [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
> > > > > > > > > [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
> > > > > > > > > [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
> > > > > > > > > [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
> > > > > > > > > [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
> > > > > > > > > [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
> > > > > > > > > [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
> > > > > > > > > [  472.092033][ T6181] ---- interrupt: 3000
> > > > > > > > > [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
> > > > > > > > > 
> > > > > > > > > This is the host, cannot run the kernel as guest because it fails to boot most
> > > > > > > > > of the time inside KVM.
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > Nonethless, there are quite a few platforms. Originally no preemption
> > > > > > > > > > > was the only option, and that's the reason why many people run that.
> > > > > > > > > > > It's the conservative, known working option. And that's the reason a lot
> > > > > > > > > > > of platfrom code does not get tested with more aggressive preemtion
> > > > > > > > > > > models, and never gets fixed to work with them.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Full preemption has been there for many years!.
> > > > > > > > > 
> > > > > > > > > Possible for years, forced only recently.
> > > > > > > > > 
> > > > > > > > > > Lazy is not that aggressive compared to that.
> > > > > > > > > > 
> > > > > > > > > > > Simply disabling the no preemtion option does not make the platform code
> > > > > > > > > > > ready.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Let's understand your crash case. Let's see where it is going wrong. I am suspecting
> > > > > > > > > > it is some wrong usage of preemption api rather than arch can't support preemption.
> > > > > > > > > 
> > > > > > > > > Very likely some wrong use of the preemption API by the arch code, or no
> > > > > > > > > use where it should have been used. It did not matter so long as people
> > > > > > > > > could run their no preempt configs and ignore the problem.
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Friendly LLM analysis says preemption is enabled too early and before
> > > > > > > > completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
> > > > > > > > 
> > > > > > > > Below is ONLY a speculation and completely UNTESTED.
> > > > > > > > Maybe worth a try.
> > > > > > > 
> > > > > > > The patch is munged by the e-mail client, and it causes immediate
> > > > > > > voluntary preemprion in rcu critical section and hard lockup on starting
> > > > > > > a KVM VM.
> > > > > > > 
> > > > > > > Also it would be sort of bad news if it worked because that would be
> > > > > > > specific to book3s KVM HV and would not help with the KVM HV from the
> > > > > > > original report which likely is not book3s, nor with KVM PR.
> > > > > > > 
> > > > > > 
> > > > > > Thanks for trying. We will try a local repro and look into it why stack is
> > > > > > getting corrupted.
> > > > > 
> 
> As we discussed offlist, samir helped to run a similar test on his machine, and he didn't
> run into issue so far. we will try more.
> 
> I am just wondering what different in your case?
> By any chance we are running into below one? Can you check your gcc version?
> 
> https://lore.kernel.org/all/CAABZP2z=xu+07-y5fqFLidZz1VpSgrSwXa1mFHPb=b3Ezr3OtA@mail.gmail.com/
> 
> Maybe CONFIG_DEBUG_PREEMPT worth a try to if it shows up anything.

Does not change anything, the kernel crashes all the same.

Nonetheless, I noticed that a tool that does some BPF tracing is
running, and without it the problem is not reproducible.

Thanks

Michal

