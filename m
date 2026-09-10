Return-Path: <linuxppc-dev+bounces-27022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B818C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 11:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgb6r4fFjz2xRs;
	Thu, 10 Sep 2026 21:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789039764;
	cv=none; b=LEX5HKfzIClvduVzFzL6Lvq0D/JhIrHB2zqtUq8GGsPLXvtvkr41gWBeCqCKuvrHloowCHn024R3LTT8jYGjKKhPOalnmlroIlLDiTAzknJDruTw6XlqkG83GUWueDQNQqS4UYTYzGYD0OH92IknHyg7OYsMkRCR5wxUu5FUkByp3H3vKE/ZQS0M+7tQ4SbCwz/Ph26ucLLFFZia+525qvBU9FFTj49iBI35BNmaIa84fc5zSIxU6Q47YNWgGpMo3C6ktMR8p8/aU41v8ZiA6Ddhw0VC1zybkeXmasKnFOdEGUnmAjbsBBfOhXm4FtmsAN64EWtp3IjNdSc6S18c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789039764; c=relaxed/relaxed;
	bh=TB1Msx42niLh89X5y6oKDaWdnQu8YGTJo8HxEY7I+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvhC/+wiRyOqpkgvHEB7TUGctY1lONBmbUbG3EMf5g544sJibf4MrRfAEBufRo5T4fXn/3+EMlEGJ1HfnK2GvhY27XXwKCP0GDto+Mey4uVc1ERDRF692qtpHJ/yb1WQXNJcMmBPqmAgtN+eNLih/RxXkKmJ4i9L+o3zIZsYmgpXw/nNY68+dryrEDWc/7B2Sn+QioiOI4choiGuYc83xFd8irgdNOI+Ewj+khnzEqx0Nb3ZRpYjsQhKKdY4e4uAiba27TsPKWNeABCkkbPp0P2RIc1/rTKImV93y73auOl7jRTkbQf0BT6QSUiqR/WkZYo0ykOVDxRbdmAfSbiF4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=03WuqvQK; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a8qo0Erz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sn0GYRO6; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yd/QHcl6; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=03WuqvQK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a8qo0Erz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Sn0GYRO6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yd/QHcl6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgb6p6TfXz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:29:22 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8C3C21C42;
	Thu, 10 Sep 2026 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789039754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB1Msx42niLh89X5y6oKDaWdnQu8YGTJo8HxEY7I+Rw=;
	b=03WuqvQKOGbSPP8ZIx0xkkkAz2XLLDq5q0q79NTjREVFAKSFuz01982JSrDwWVWf6F7hR5
	JPEDR0DsoT8iBxqquReDTulmNM32bjWh11lrOZnxXNhgktxweWFNJ9Fvg/o6uGc1Wl4OA1
	EfHiuArg9dKUSTOqPlCxhsKI/0Ltox8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789039754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB1Msx42niLh89X5y6oKDaWdnQu8YGTJo8HxEY7I+Rw=;
	b=a8qo0Erzfbb/0UgJ6J7YAlpUHvhHFuWXPwBvoyAj74+ONkisrJCLS5fXkzqts972zwC1sy
	YIEsLUVoiM3Es9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sn0GYRO6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Yd/QHcl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789039750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB1Msx42niLh89X5y6oKDaWdnQu8YGTJo8HxEY7I+Rw=;
	b=Sn0GYRO6iqNFNEOgXYv7/u++ck2MuKo+ovtdTx0hraIHLoZkDn25sEqd/Ws4DSaTROfHuQ
	Oc4Jfs1AN/+LG78juEGMgZYogRPNkrvLHRYMcq68kjEZN1KArt4slSejnnSoLevvLYQmNi
	C46ZKg74FNh6HnOjbb3RFG0bXXzCXtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789039750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB1Msx42niLh89X5y6oKDaWdnQu8YGTJo8HxEY7I+Rw=;
	b=Yd/QHcl6I7LVquLURBzxJsLcoRyG6fpwtAbPm7GuFZQP/UR+X2xM/uD0lFnx1JGn1liVbp
	tW1y6xp2JGapsjBA==
Date: Thu, 10 Sep 2026 13:29:08 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: harshpb@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
	amachhiw@linux.ibm.com,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>, nnmlinux@linux.ibm.com
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqKUhHb9UTfVq4As@kunlun.suse.cz>
References: <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
 <app0zGv9bvtL4nHm@kunlun.suse.cz>
 <4eef1f0b-0c02-4377-b950-43c3b120865a@linux.ibm.com>
 <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
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
In-Reply-To: <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: E8C3C21C42
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
	NEURAL_HAM_SHORT(-0.12)[-0.607];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Thu, Sep 10, 2026 at 04:11:20PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 9/10/26 2:29 PM, Michal Suchánek wrote:
> > On Fri, Sep 04, 2026 at 02:34:21PM +0530, Shrikanth Hegde wrote:
> > > 
> > > 
> > > On 9/4/26 1:05 PM, Michal Suchánek wrote:
> > > > On Thu, Sep 03, 2026 at 10:52:59PM +0530, Shrikanth Hegde wrote:
> > > > > 
> > > > > > > If possible run against current upstream and share the results.
> > > > > > 
> > > > > > https://github.com/openSUSE/kernel-source/blob/6824496d1801f73def615dca8794202eeb7b0d86/config/ppc64le/default
> > > > > > 
> > > > > > [  472.091531][ T6181] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > > > [  472.091598][ T6181] CPU: 29 UID: 107 PID: 6181 Comm: CPU 112/KVM Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > > > > > [  472.091612][ T6181] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > > > > > [  472.091624][ T6181] Call Trace:
> > > > > > [  472.091630][ T6181] [c00000000fdfb680] [c00000000134ce90] dump_stack_lvl+0x84/0xc0 (unreliable)
> > > > > > [  472.091653][ T6181] [c00000000fdfb6b0] [c00000000022e7c8] vpanic+0x324/0x5e4
> > > > > > [  472.091666][ T6181] [c00000000fdfb760] [c00000000022eac4] do_panic_on_target_cpu+0x0/0x2c
> > > > > > [  472.091677][ T6181] [c00000000fdfb780] [c0000000013c1ff8] __stack_chk_fail+0x48/0x60
> > > > > > [  472.091689][ T6181] [c00000000fdfb7f0] [c00800001aae219c] kvmhv_run_single_vcpu+0x19d4/0x1b50 [kvm_hv]
> > > > > > [  472.091712][ T6181] [c00000000fdfb940] [c00800001aae24b4] kvmppc_vcpu_run_hv+0x19c/0x12f0 [kvm_hv]
> > > > > > [  472.091732][ T6181] [c00000000fdfba10] [c00800001aeeed18] kvmppc_vcpu_run+0x30/0x48 [kvm]
> > > > > > [  472.091779][ T6181] [c00000000fdfba30] [c00800001aee9ef4] kvm_arch_vcpu_ioctl_run+0x35c/0x4a0 [kvm]
> > > > > > [  472.091813][ T6181] [c00000000fdfbac0] [c00800001aedaac4] kvm_vcpu_ioctl+0x1ac/0xad8 [kvm]
> > > > > > [  472.091844][ T6181] [c00000000fdfbca0] [c0000000007f1244] sys_ioctl+0x374/0x1060
> > > > > > [  472.091857][ T6181] [c00000000fdfbdb0] [c00000000002f7f8] system_call_exception+0x188/0x430
> > > > > > [  472.091871][ T6181] [c00000000fdfbe50] [c00000000000cfdc] system_call_vectored_common+0x15c/0x2ec
> > > > > > [  472.091886][ T6181] ---- interrupt: 3000 at 0x7fffb5565fac
> > > > > > [  472.091896][ T6181] NIP:  00007fffb5565fac LR: 00007fffb5565fac CTR: 0000000000000000
> > > > > > [  472.091904][ T6181] REGS: c00000000fdfbe80 TRAP: 3000   Not tainted  (7.2.2-5.g6824496-default)
> > > > > > [  472.091911][ T6181] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42044402  XER: 00000000
> > > > > > [  472.091938][ T6181] IRQMASK: 0
> > > > > > [  472.091938][ T6181] GPR00: 0000000000000036 00007fbfa77ed7a0 00007fffb5677100 00000000000000fa
> > > > > > [  472.091938][ T6181] GPR04: 000000002000ae80 0000000000000000 0000000000000000 0000000000000000
> > > > > > [  472.091938][ T6181] GPR08: 00000000000000fa 0000000000000000 0000000000000000 0000000000000000
> > > > > > [  472.091938][ T6181] GPR12: 0000000000000000 00007fbfa77f5ec0 000000014676f000 00007fbfa77ee7c0
> > > > > > [  472.091938][ T6181] GPR16: 000000014674e8d0 00007fbfa77eeec0 00007fbfa77eeec0 fffffffffffffff7
> > > > > > [  472.091938][ T6181] GPR20: 00007fffb71210d0 0000000000000001 00007fbfa77eeec0 0000000000000000
> > > > > > [  472.091938][ T6181] GPR24: 00007fbfa77ed8e8 0000000105971428 000000002000ae80 0000000105f77a70
> > > > > > [  472.091938][ T6181] GPR28: 0000000000000000 0000000000000000 000000002000ae80 000000014674f000
> > > > > > [  472.092020][ T6181] NIP [00007fffb5565fac] 0x7fffb5565fac
> > > > > > [  472.092027][ T6181] LR [00007fffb5565fac] 0x7fffb5565fac
> > > > > > [  472.092033][ T6181] ---- interrupt: 3000
> > > > > > [  472.098256][ T6181] pstore: backend (nvram) writing error (-1)
> > > > > > 
> > > > > > This is the host, cannot run the kernel as guest because it fails to boot most
> > > > > > of the time inside KVM.
> > > > > > 
> > > > > > > 
> > > > > > > > Nonethless, there are quite a few platforms. Originally no preemption
> > > > > > > > was the only option, and that's the reason why many people run that.
> > > > > > > > It's the conservative, known working option. And that's the reason a lot
> > > > > > > > of platfrom code does not get tested with more aggressive preemtion
> > > > > > > > models, and never gets fixed to work with them.
> > > > > > > > 
> > > > > > > 
> > > > > > > Full preemption has been there for many years!.
> > > > > > 
> > > > > > Possible for years, forced only recently.
> > > > > > 
> > > > > > > Lazy is not that aggressive compared to that.
> > > > > > > 
> > > > > > > > Simply disabling the no preemtion option does not make the platform code
> > > > > > > > ready.
> > > > > > > > 
> > > > > > > 
> > > > > > > Let's understand your crash case. Let's see where it is going wrong. I am suspecting
> > > > > > > it is some wrong usage of preemption api rather than arch can't support preemption.
> > > > > > 
> > > > > > Very likely some wrong use of the preemption API by the arch code, or no
> > > > > > use where it should have been used. It did not matter so long as people
> > > > > > could run their no preempt configs and ignore the problem.
> > > > > > 
> > > > > > Thanks
> > > > > 
> > > > > 
> > > > > Friendly LLM analysis says preemption is enabled too early and before
> > > > > completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
> > > > > 
> > > > > Below is ONLY a speculation and completely UNTESTED.
> > > > > Maybe worth a try.
> > > > 
> > > > The patch is munged by the e-mail client, and it causes immediate
> > > > voluntary preemprion in rcu critical section and hard lockup on starting
> > > > a KVM VM.
> > > > 
> > > > Also it would be sort of bad news if it worked because that would be
> > > > specific to book3s KVM HV and would not help with the KVM HV from the
> > > > original report which likely is not book3s, nor with KVM PR.
> > > > 
> > > 
> > > Thanks for trying. We will try a local repro and look into it why stack is
> > > getting corrupted.
> > 
> > There is also stack corruption when idling. At this point the machine is
> > stuck half-dead and would not go through with the panic, it requires
> > dump from the hyprvisor side to capture this.
> > 
> > Thanks
> > 
> > Michal
> > 
> 
> 
> is this on host with kvm running or this is without kvm running anything?

Difficult to say after the fact. Given running KVM VMs is crashing with
this kernel most likely no VM was running.

> 
> Do you see corruption if you don't have kvm module loaded?

Difficult to say, this takes hours to days to reproduce, and the module
is normally loaded by default. I can blacklist it to make sure it does
not get loaded.

> 
> These maybe two independent issue.
> Our KVM team is trying local repro for the kvm issue you have reported.
> 
> If possible, could you try vmcore capture (maybe with fadump)?

I have the vmcore, this dmesg is from the vmcore. I would not get
displayed otherwise, or maybe some content from the console is lost.

Unfortunately, this is a kernel from a rolling distribution, and may be
difficult to analyze bacause new kernel build is used by now.

Thanks

Michal

> 
> > [542489.550547] [      T0] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __sprint_symbol+0x1e4/0x1f0
> > [542489.557809] [      T0] ------------[ cut here ]------------
> > [542489.557814] [      T0] Voluntary context switch within RCU read-side critical section!
> > [542489.557822] [      T0] WARNING: [] kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0x6a0/0x7b0, CPU#59: swapper/59/0
> > [542489.557837] [      T0] Modules linked in: vhost_net vhost vhost_iotlb tap rpadlpar_io rpaphp kvm_hv kvm mptcp_diag xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag xt_conntrack xt_MASQUERADE xfrm_user xt_set ip_set xt_addrtype nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bonding tls nft_chain_nat nf_nat nf_conntrack tun nf_defrag_ipv6 nf_defrag_ipv4 rfkill af_packet binfmt_misc xfs aes_gcm_p10_crypto crypto_simd ibmveth cryptd xts vmx_crypto rtc_generic fuse nvme_fabrics ip_tables x_tables ibmvscsi scsi_transport_srp sd_mod scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common nvme nvme_core nvme_keyring nvme_auth pseries_wdt btrfs xor libblake2b raid6_pq dm_mirror dm_region_hash dm_log dm_mod br_netfilter bridge stp llc nf_tables
> > [542489.557944] [      T0] CPU: 59 UID: 0 PID: 0 Comm: swapper/59 Tainted: G      D W           7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > [542489.557957] [      T0] Tainted: [D]=DIE, [W]=WARN
> > [542489.557961] [      T0] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > [542489.557967] [      T0] NIP:  c00000000035d700 LR: c00000000035d6fc CTR: 0000000000000000
> > [542489.557974] [      T0] REGS: c000001de047f990 TRAP: 0700   Tainted: G      D W            (7.2.2-5.g6824496-default)
> > [542489.557980] [      T0] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44002284  XER: 0000000e
> > [542489.557999] [      T0] CFAR: c00000000022d7a8 IRQMASK: 1
> >                             GPR00: c00000000035d6fc c000001de047fc30 c00000000205ad00 000000000000003f
> >                             GPR04: 3ffffffffffc02ef c000001de047f950 c000001de047f910 0000003ff0e20000
> >                             GPR08: 0000000000000027 0000000000000001 c000001de0191300 0000000044002284
> >                             GPR12: c000003ff1614890 c000003fffff9f00 0000000000000000 000000002eef9860
> >                             GPR16: 0000000000000000 c000003ff40dcc80 0000003ff0e20000 c000000000058010
> >                             GPR20: c000000000058160 c0000000032bcc80 c0000000032bcc80 c000000000057f80
> >                             GPR24: ffffffffffffffff 000000000000003b c000001de0191300 c000000003bea6e0
> >                             GPR28: c000000000058010 ffffffffffffffff 0000000000000000 c000003ff40de100
> > [542489.558066] [      T0] NIP [c00000000035d700] rcu_note_context_switch+0x6a0/0x7b0
> > [542489.558072] [      T0] LR [c00000000035d6fc] rcu_note_context_switch+0x69c/0x7b0
> > [542489.558078] [      T0] Call Trace:
> > [542489.558082] [      T0] [c000001de047fc30] [c00000000035d6fc] rcu_note_context_switch+0x69c/0x7b0 (unreliable)
> > [542489.558092] [      T0] [c000001de047fcd0] [c0000000013c4fc0] __schedule+0xf0/0x1d10
> > [542489.558108] [      T0] [c000001de047fe20] [c0000000013c6eb0] schedule_idle+0x30/0x60
> > [542489.558121] [      T0] [c000001de047fe40] [c0000000002caed8] do_idle+0x258/0x470
> > [542489.558133] [      T0] [c000001de047feb0] [c0000000002cb3b4] cpu_startup_entry+0x54/0x60
> > [542489.558145] [      T0] [c000001de047fee0] [c00000000005a720] start_secondary+0x860/0xd70
> > [542489.558154] [      T0] [c000001de047ffe0] [c00000000000e158] start_secondary_prolog+0x10/0x14
> > [542489.558162] [      T0] Code: f8c900a8 4bfffe6c 60000000 60420000 3c62ff87 39200001 f9410068 3d4201b2 386329d8 992aa087 4becff91 60000000 <0fe00000> e9410068 4bfff9c4 60420000
> > [542489.558184] [      T0] ---[ end trace 0000000000000000 ]---
> > [542521.228724] [     C59] watchdog: CPU 59 Hard LOCKUP
> > [542521.228726] [     C59] watchdog: CPU 59 TB:3697937465165330, last heartbeat TB:3697921085812082 (31990ms ago)
> > [542521.228728] [     C59] Modules linked in: vhost_net vhost vhost_iotlb tap rpadlpar_io rpaphp kvm_hv kvm mptcp_diag xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag xt_conntrack xt_MASQUERADE xfrm_user xt_set ip_set xt_addrtype nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bonding tls nft_chain_nat nf_nat nf_conntrack tun nf_defrag_ipv6 nf_defrag_ipv4 rfkill af_packet binfmt_misc xfs aes_gcm_p10_crypto crypto_simd ibmveth cryptd xts vmx_crypto rtc_generic fuse nvme_fabrics ip_tables x_tables ibmvscsi scsi_transport_srp sd_mod scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common nvme nvme_core nvme_keyring nvme_auth pseries_wdt btrfs xor libblake2b raid6_pq dm_mirror dm_region_hash dm_log dm_mod br_netfilter bridge stp llc nf_tables
> > [542521.228776] [     C59] CPU: 59 UID: 0 PID: 0 Comm: swapper/59 Tainted: G      D W           7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
> > [542521.228780] [     C59] Tainted: [D]=DIE, [W]=WARN
> > [542521.228781] [     C59] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
> > [542521.228783] [     C59] NIP:  c0000000013d2c94 LR: c0000000013d5330 CTR: c000000003812be8
> > [542521.228785] [     C59] REGS: c000003ffed2bd60 TRAP: 0100   Tainted: G      D W            (7.2.2-5.g6824496-default)
> > [542521.228788] [     C59] MSR:  8000000000081033 <SF,ME,IR,DR,RI,LE>  CR: 42002282  XER: 2004000e
> > [542521.228794] [     C59] CFAR: 000000000000011c IRQMASK: 3
> >                             GPR00: c000000000260a58 c000003ffef2fb60 c00000000205ad00 c000001deaab3c00
> >                             GPR04: 00000000000001f8 0000000000000000 fffffffffffe0000 0000000000010000
> >                             GPR08: 0000000000000001 0000000000000001 000000001c82ef77 fffffffffffffffd
> >                             GPR12: c000000003812be0 c000003fffff9f00 0000000000000000 0000000000000000
> >                             GPR16: 0000000000000000 0000000000000000 0000000000000001 c000000003bc2b00
> >                             GPR20: c000003ff40c8de8 0000000000000001 c000003ff40c8da8 c000003ffef2fe08
> >                             GPR24: 0000000000000000 c000000003bea6e0 000000000000003b 0000003ff0e20000
> >                             GPR28: 0000000000780000 c0000000032bbe80 c000003ff40dbe80 c000001deaab3c00
> > [542521.228820] [     C59] NIP [c0000000013d2c94] queued_spin_lock_slowpath+0x164/0x19a0
> > [542521.228824] [     C59] LR [c0000000013d5330] _raw_spin_lock+0x80/0xa0
> > [542521.228827] [     C59] Call Trace:
> > [542521.228827] [     C59] [c000003ffef2fb60] [0000000000001000] 0x1000 (unreliable)
> > [542521.228833] [     C59] [c000003ffef2fc60] [c000001de0191300] 0xc000001de0191300
> > [542521.228836] [     C59] [c000003ffef2fc80] [c000000000260a58] __queue_work+0x2f8/0x740
> > [542521.228841] [     C59] [c000003ffef2fd50] [c00000000038ceac] call_timer_fn+0x4c/0x260
> > [542521.228845] [     C59] [c000003ffef2fde0] [c00000000038d308] __run_timers+0x248/0x410
> > [542521.228849] [     C59] [c000003ffef2fec0] [c00000000038d56c] run_timer_softirq+0x9c/0x130
> > [542521.228852] [     C59] [c000003ffef2fef0] [c00000000023ab0c] handle_softirqs+0x14c/0x4a0
> > [542521.228855] [     C59] [c000003ffef2ffe0] [c000000000018418] do_softirq_own_stack+0x38/0x50
> > [542521.228860] [     C59] [c000001de047f910] [c00000000023a238] __irq_exit_rcu+0x198/0x1c0
> > [542521.228862] [     C59] [c000001de047f940] [c000000000026acc] timer_interrupt+0x1cc/0x4f0
> > [542521.228866] [     C59] [c000001de047f9b0] [c000000000009fdc] decrementer_common_virt+0x28c/0x290
> > [542521.228871] [     C59] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
> > [542521.228876] [     C59] NIP:  c0000000001b7634 LR: c0000000013c4898 CTR: 0000000000000000
> > [542521.228877] [     C59] REGS: c000001de047f9e0 TRAP: 0900   Tainted: G      D W            (7.2.2-5.g6824496-default)
> > [542521.228879] [     C59] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22000282  XER: 2004000e
> > [542521.228886] [     C59] CFAR: 0000000000000000 IRQMASK: 0
> >                             GPR00: 0000000000000000 c000001de047fc80 c00000000205ad00 0000000000000000
> >                             GPR04: 0000000000000000 0000000000000039 0000000000000000 0000000000000000
> >                             GPR08: ffffffffffffff7f 0000000000000000 ffffffffffffffff 0000000000000000
> >                             GPR12: 0000000000000000 c000003fffff9f00 0000000000000000 000000002eef9860
> >                             GPR16: 0000000000000000 0000000000000001 0000000000000001 c000000000058010
> >                             GPR20: c000000000058160 0000000000000002 c000000000057fb0 c000000000057f80
> >                             GPR24: ffffffffffffffff 0001ed6431fbb852 0000000000000000 0000000000000001
> >                             GPR28: 0000000000000000 0000000000000000 c0000000032a1878 c0000000032a1870
> > [542521.228911] [     C59] NIP [c0000000001b7634] plpar_hcall_norets_notrace+0x18/0x2c
> > [542521.228915] [     C59] LR [c0000000013c4898] check_and_cede_processor+0x48/0x60
> > [542521.228918] [     C59] ---- interrupt: 900
> > [542521.228919] [     C59] [c000001de047fc80] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
> > [542521.228922] [     C59] [c000001de047fce0] [c0000000013c4944] dedicated_cede_loop+0x94/0x1a0
> > [542521.228926] [     C59] [c000001de047fd30] [c0000000013c3f00] cpuidle_enter_state+0x300/0x748
> > [542521.228930] [     C59] [c000001de047fde0] [c000000000f5ff10] cpuidle_enter+0x50/0x80
> > [542521.228935] [     C59] [c000001de047fe20] [c0000000002ba358] call_cpuidle+0x48/0x90
> > [542521.228939] [     C59] [c000001de047fe40] [c0000000002caf5c] do_idle+0x2dc/0x470
> > [542521.228942] [     C59] [c000001de047feb0] [c0000000002cb3b8] cpu_startup_entry+0x58/0x60
> > [542521.228945] [     C59] [c000001de047fee0] [c00000000005a720] start_secondary+0x860/0xd70
> > [542521.228948] [     C59] [c000001de047ffe0] [c00000000000e158] start_secondary_prolog+0x10/0x14
> > [542521.228951] [     C59] Code: 41810e8c 39400000 39000000 3cc0fffe 60000000 813f0000 71290001 41820050 3ce00001 60000000 60420000 7c40003c <71090001> 394a0001 40820028 3d2201ba
> > [568119.679467] [     C59] pstore: dump skipped in NMI path because of concurrent dump
> > 
> 

