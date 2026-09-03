Return-Path: <linuxppc-dev+bounces-26493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E9C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbKMT0Y8Zz2y2Q;
	Thu, 03 Sep 2026 22:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788440132;
	cv=none; b=VIvFEQZg1R/2PBi/cP/d7p0I5CZ3GpoP1jXnEY/ZFbVVzEVYcNxM4uCXaCkYyBF2bMf7r1zSLObmrKg6koH5kS4/GEh4XlNGBaZUmDV+n2iLN4Vy1U1zX5IrX6oyugLQZTTVo0kYn6qP2pmNhMfiWjPZ86eXDd6z584ReUwBYPtP/OwVqrlWw7+D3d31krky01jdBgWDN1euMIYzVFcUKyjTkG9iDonyv5mcOqsC4VYyZUNj60RFi14C6Ks4haXnc6Fm0gSHvZ8f70EhdJd8xTlnT86JhCOutApS2J8sdRwLdNoIKjy8Z+q6PkXos2ZJAOsip2NsixBvTtncAiUKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788440132; c=relaxed/relaxed;
	bh=+GESfE5Q3/UL7GKchlOPBuB23BDDa/xreTR02cE2ves=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHgl74426BqaTeElJeHvkBypHBEYb3BrzxU24oVaYUxPkpWV1FWrI7vXZuH8/1NORbJUWl8xOG3U/rKjNLRTNIapqsj7ej0+++rG/pqi0IsBK+XsZOrD61WuwBquwZD+94QllMgbgJ97CvMNS4TuX1YNoZ3bz4sC7Fjk7ahp8vrZeGuB+2sYRplXZiabewKlaj73ZvnH1LG6rPJn7c+7WWcefJEFTIuQkvwuojVX8XXHRFmxk77uNgM2ej0WTZYXdtZCkTtK7nxcQPtB+Nm7vJAjxMzTzfw4qI/wzADtB55dc1yMdTyBkAadOx1L+2exLBDscLr7UrKvkJVCIILDnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=otWoSbGI; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mD0MFca+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SiSOJQ3q; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tA6EmBVQ; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=otWoSbGI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mD0MFca+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SiSOJQ3q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tA6EmBVQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbKMR4Yllz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 22:55:31 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C59921AB9;
	Thu,  3 Sep 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788440118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GESfE5Q3/UL7GKchlOPBuB23BDDa/xreTR02cE2ves=;
	b=otWoSbGIsCJ0OlKelB8EpwzB38f6YYKT1axd2FnHLjC/JsmMBcfSRZV9K2myAqg26tHQN3
	hb4OuGHmugl5U0zXWROP746wRZT6Il/33IQhY3iYnu91cMIm+zUELD00QP74mTcpaTJwev
	QOvXXCjnxwQrsO4S1A1HgMogvKuaYmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788440118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GESfE5Q3/UL7GKchlOPBuB23BDDa/xreTR02cE2ves=;
	b=mD0MFca+yuijAWFZGM569KY26xDfQK9gI5MMfjO9JyMSf09qfoCUER8uY1mI2Dnr7jDG9s
	e6Hisx5FBX7Rr3AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SiSOJQ3q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tA6EmBVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788440114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GESfE5Q3/UL7GKchlOPBuB23BDDa/xreTR02cE2ves=;
	b=SiSOJQ3q79z4Gs7LAvQuAqNnnUv5KHDSWxZogffa7jpxCjZIX0kRp1P35EzOqS8onK7f9R
	bnAU3fEeMCXgY9EA3G4CrFqWe+UVC//kuf3S8UUwPV3826iPkQEYbKcmPnSG5lIObzX27D
	TCElnJgsnS3PKTuz057h1UmsT414pzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788440114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GESfE5Q3/UL7GKchlOPBuB23BDDa/xreTR02cE2ves=;
	b=tA6EmBVQZv3xP3fsTgARFi6IqdoziL17mKz5BOZ4o+8gazKkBaIG5RLEjL7bLP697NcwaS
	B+nKp9Zg1DGlVVAg==
Date: Thu, 3 Sep 2026 14:55:13 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <apluMTONwd6vUNT7@kunlun.suse.cz>
References: <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
 <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
 <aplnPuVk4LWgpu3n@kunlun.suse.cz>
 <e211e1fd-0923-4ab4-9e01-e9151807cf26@linux.ibm.com>
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
In-Reply-To: <e211e1fd-0923-4ab4-9e01-e9151807cf26@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 8C59921AB9
X-Spamd-Result: default: False [12.67 / 50.00];
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
	NEURAL_HAM_SHORT(-0.15)[-0.730];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.de:dkim]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Thu, Sep 03, 2026 at 06:06:16PM +0530, Harsh Prateek Bora wrote:
> + Amit, Gautam - since they recently came across a similar regression which
> is seen with non KVM workload as well.
> + Venkat - for CI improvement suggestion below.
> 
> Hi Michal,
> 
> On 03/09/26 5:55 pm, Michal Suchánek wrote:
> > On Thu, Sep 03, 2026 at 05:34:31PM +0530, Shrikanth Hegde wrote:
> > > Hi Michal.
> > > 
> > > On 9/3/26 5:10 PM, Michal Suchánek wrote:
> > > > On Thu, Sep 03, 2026 at 05:01:13PM +0530, Shrikanth Hegde wrote:
> > > > 
> > > > > 
> > > > > > > 
> > > > > > > > This is not the latest kernel so it might have been fixed in the
> > > > > > > > meantime for the platform in question. Will need to check that.
> > > > > > > > 
> > > > > > > 
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
> > > > > 
> > > > > Will look into. btw the patch shared i.e below patch fixes the boot hanf issue?
> > > > > 
> > > > > https://lore.kernel.org/all/1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com/
> > > > 
> > > 
> > > I see code has changed a bit. So this patch is not correct anymore.
> > > Sorry, i should have checked.
> > > 
> > > > I would not bet on that. It looks like host side patch, and the problem
> > > > is with booting 7.2.2 as guest. Some 6.12 frankenkernel can be booted on
> > > > the same host, and used to produce the crash above by running a kernel
> > > > build inside the guest.
> > > > 
> > > 
> > > I didn't get what you are saying. Could you see if it regression only in 7.2?
> > > Does 7.1 works fine? If it is regression could you see if it is bisectable?
> > > Also, could you share the repro steps?
> > 
> > The repro steps are: on a mid-size LPAR (120 CPU threads, 256G RAM)
> > create a KVM VM that uses all host resources. Run kernel build inside
> > KVM VM, using all CPUs. In about a minute the host crashes with the
> > above a or similar trace. I don't have any kernel version with aggressive
> > preemption enabled that does not suffer from this problem.
> 
> Looks like seen under heavy workloads when you say "KVM VM that uses all
> host rsources". Could you please confirm if the issue is seen with any other
> heavy workload also which consumes all host resources? I do not think we
> recently had any PPC KVM specific changes which would cause this. Also, if
> it's a regression, git bisect should point out the real culprit.

It's a regression from switching to PREEMPT_LAZY (from
PREEMPT_VOLUNTARY). Very likely the code was buggy to start with but
because less aggressive preemption model was used the bug was never
triggered. I cannot reproduce this under load without KVM. The other
problem that is much harder to reproduce is machine locking up while
idling. A dump then also shows stack corruption with completely
but different stack trace, no KVM involved in that one. Did not see this
with recent mainline yet.

I do get a problem with 7.2.2 building a kernel outside of kVM but
that's probably because it's missing some of the recent entry fixes:

[ 5451.821931] [  T77619] as[77619]: segfault (11) at 3abd0 nip 7fff8fe56434 lr 7fff8fe55348 code 1 in ld64.so.2[36434,7fff8fe20000+60000]
[ 5451.821967] [  T77619] as[77619]: code: 60000000 60000000 60000000 f9490008 f9490010 39290020 f949fff8 f9490000 
[ 5451.821973] [  T77619] as[77619]: code: 4200ffec 89210376 3d42ffff 394a7ea0 <e9028000> 7d081050 f9410030 f9010020 
[ 5454.239768] [  T78922] awk[78922]: segfault (11) at 3abd0 nip 7fff8c386434 lr 7fff8c385348 code 1 in ld64.so.2[36434,7fff8c350000+60000]
[ 5454.239809] [  T78922] awk[78922]: code: 60000000 60000000 60000000 f9490008 f9490010 39290020 f949fff8 f9490000 
[ 5454.239815] [  T78922] awk[78922]: code: 4200ffec 89210376 3d42ffff 394a7ea0 <e9028000> 7d081050 f9410030 f9010020 
[ 5465.056566] [  T85518] sh[85518]: segfault (11) at 3abd0 nip 7fffb79a6434 lr 7fffb79a5348 code 1 in ld64.so.2[36434,7fffb7970000+60000]
[ 5465.056611] [  T85518] sh[85518]: code: 60000000 60000000 60000000 f9490008 f9490010 39290020 f949fff8 f9490000 
[ 5465.056616] [  T85518] sh[85518]: code: 4200ffec 89210376 3d42ffff 394a7ea0 <e9028000> 7d081050 f9410030 f9010020 
[ 5474.995476] [  T91034] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: sys_ioctl+0xfe0/0x1060
[ 5474.995495] [  T91037] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_store+0x6a4/0x6c0
[ 5474.995508] [  T91037] ------------[ cut here ]------------
[ 5474.995513] [  T91037] kernel BUG at [regs_irqs_disabled(regs)] arch/powerpc/include/asm/entry-common.h:401!
[ 5474.995521] [  T91037] Oops: Exception in kernel mode, sig: 5 [#1]
[ 5474.995524] [  T91037] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 5474.995528] [  T91037] Modules linked in: rpadlpar_io rpaphp kvm_hv kvm mptcp_diag xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag xt_conntrack xt_MASQUERADE xfrm_user xt_set ip_set xt_addrtype nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bonding tls nft_chain_nat nf_nat nf_conntrack tun nf_defrag_ipv6 nf_defrag_ipv4 rfkill af_packet binfmt_misc xfs aes_gcm_p10_crypto ibmveth crypto_simd cryptd xts vmx_crypto rtc_generic fuse nvme_fabrics ip_tables x_tables ibmvscsi scsi_transport_srp sd_mod scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common nvme nvme_core nvme_keyring pseries_wdt nvme_auth btrfs xor libblake2b raid6_pq dm_mirror dm_region_hash dm_log dm_mod br_netfilter bridge stp llc nf_tables
[ 5474.995641] [  T91037] CPU: 110 UID: 399 PID: 91037 Comm: cc1 Not tainted 7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
[ 5474.995649] [  T91037] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
[ 5474.995653] [  T91037] NIP:  c0000000013c2114 LR: c000000000148c88 CTR: c000000000008e40
[ 5474.995656] [  T91037] REGS: c000001f965d3b50 TRAP: 0700   Not tainted  (7.2.2-5.g6824496-default)
[ 5474.995660] [  T91037] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 42004208  XER: 20040145
[ 5474.995670] [  T91037] CFAR: c0000000013c20b4 IRQMASK: 3 
                          GPR00: c00000000000904c c000001f965d3df0 c00000000205ad00 c000001f965d3e80 
                          GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR08: 0000000000000000 0000000000000001 0000000000004000 0000000053474552 
                          GPR12: 0000000000000000 c000003ffef56300 0000000000000000 0000000000000000 
                          GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR28: 0000000000000000 0000000000000000 0000000000000000 c000001f965d3e80 
[ 5474.995708] [  T91037] NIP [c0000000013c2114] irqentry_enter+0x74/0x1a0
[ 5474.995719] [  T91037] LR [c000000000148c88] do_page_fault+0x68/0x140
[ 5474.995727] [  T91037] Call Trace:
[ 5474.995731] [  T91037] [c000001f965d3e10] [c000001f965d3e50] 0xc000001f965d3e50
[ 5474.995739] [  T91037] [c000001f965d3e50] [c00000000000904c] instruction_access_common_virt+0x20c/0x210
[ 5474.995751] [  T91037] ---- interrupt: 400 at 0x1043f158
[ 5474.995754] [  T91037] NIP:  000000001043f158 LR: 00000000101218e0 CTR: 00007fff7aef4f00
[ 5474.995756] [  T91037] REGS: c000001f965d3e80 TRAP: 0400   Not tainted  (7.2.2-5.g6824496-default)
[ 5474.995759] [  T91037] MSR:  800000004280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 82004208  XER: 20040145
[ 5474.995770] [  T91037] CFAR: 00000000101218dc IRQMASK: 1 
                          GPR00: 00000000101218cc 00007ffffd284ce0 0000000011de7a00 0000000012c2c370 
                          GPR04: 0000000000000001 0000000000000000 0000000000000001 0000000000000000 
                          GPR08: 00007fff7b070d60 0000000000000000 0000000012c2c380 0000000000004000 
                          GPR12: 00007fff7aef4f00 00007fff7ba8da00 0000000000000000 0000000000000000 
                          GPR16: 0000000000000000 00007ffffd28c2ac 0000000000000000 0000000000000001 
                          GPR20: 0000000000000197 0000000000c03cff 0000000011e0d210 0000000000000008 
                          GPR24: 0000000000000000 00007ffffd284f58 0000000000000000 0000000000000000 
                          GPR28: 0000000000000001 00007ffffd28c2ac 0000000000000000 0000000000000197 
[ 5474.995809] [  T91037] NIP [000000001043f158] 0x1043f158
[ 5474.995812] [  T91037] LR [00000000101218e0] 0x101218e0
[ 5474.995814] [  T91037] ---- interrupt: 400
[ 5474.995816] [  T91037] Code: f8010030 4af8b211 60000000 e8010030 7c0803a6 4bffffd4 60420000 7929ffe2 69290001 0b090000 e9230138 792907e0 <0b090000> 4800001c e9230140 792907a4 
[ 5474.995835] [  T91037] ---[ end trace 0000000000000000 ]---
[ 5492.821144] [    C110] watchdog: CPU 110 Hard LOCKUP
[ 5492.821159] [    C110] watchdog: CPU 110 TB:3408898268781396, last heartbeat TB:3408888039246087 (19979ms ago)
[ 5492.821162] [    C110] Modules linked in: rpadlpar_io rpaphp kvm_hv kvm mptcp_diag xsk_diag tcp_diag udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag xt_conntrack xt_MASQUERADE xfrm_user xt_set ip_set xt_addrtype nft_compat nf_conntrack_netbios_ns nf_conntrack_broadcast nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bonding tls nft_chain_nat nf_nat nf_conntrack tun nf_defrag_ipv6 nf_defrag_ipv4 rfkill af_packet binfmt_misc xfs aes_gcm_p10_crypto ibmveth crypto_simd cryptd xts vmx_crypto rtc_generic fuse nvme_fabrics ip_tables x_tables ibmvscsi scsi_transport_srp sd_mod scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common nvme nvme_core nvme_keyring pseries_wdt nvme_auth btrfs xor libblake2b raid6_pq dm_mirror dm_region_hash dm_log dm_mod br_netfilter bridge stp llc nf_tables
[ 5492.821225] [    C110] CPU: 110 UID: 399 PID: 91037 Comm: cc1 Tainted: G      D             7.2.2-5.g6824496-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  61871a5f06863b4006f5ef27cd9f18e8a7a2edad
[ 5492.821234] [    C110] Tainted: [D]=DIE
[ 5492.821235] [    C110] Hardware name: IBM,9824-42A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.20 (OB1110_130) hv:phyp pSeries
[ 5492.821237] [    C110] NIP:  c0000000013d2c90 LR: c0000000013d4564 CTR: c000000000919460
[ 5492.821241] [    C110] REGS: c000003ffeb93d60 TRAP: 0100   Tainted: G      D              (7.2.2-5.g6824496-default)
[ 5492.821244] [    C110] MSR:  8000000000081033 <SF,ME,IR,DR,RI,LE>  CR: 44004204  XER: 20040145
[ 5492.821252] [    C110] CFAR: 000000000000011c IRQMASK: 3 
                          GPR00: c0000000009194f0 c000001f965d3730 c00000000205ad00 c0000000037b6510 
                          GPR04: c000001f965d39d8 00000000000000dd fffffffffffe0000 0000000000010000 
                          GPR08: 0000000000000001 0000000000000001 000000000fe67ee1 0000000000004000 
                          GPR12: c000000000919460 c000003ffef56300 0000000000000000 0000000000000000 
                          GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR24: 0000000000002800 c0000000018c5670 c000001f965d39d8 0000003ff1ae0000 
                          GPR28: 0000000000de0000 c0000000032bbe80 c000003ff4d9be80 c0000000037b6510 
[ 5492.821283] [    C110] NIP [c0000000013d2c90] queued_spin_lock_slowpath+0x160/0x19a0
[ 5492.821296] [    C110] LR [c0000000013d4564] _raw_spin_lock_irqsave+0x94/0xc0
[ 5492.821299] [    C110] Call Trace:
[ 5492.821302] [    C110] [c000001f965d3830] [0000000000000263] 0x263
[ 5492.821309] [    C110] [c000001f965d3860] [c0000000009194f0] pstore_dump+0x90/0x430
[ 5492.821317] [    C110] [c000001f965d39b0] [c00000000031ff40] kmsg_dump_desc+0xb0/0x100
[ 5492.821325] [    C110] [c000001f965d3a10] [c00000000022e2a4] oops_exit+0x54/0x70
[ 5492.821331] [    C110] [c000001f965d3a70] [c00000000002760c] oops_end+0x6c/0x1a0
[ 5492.821340] [    C110] [c000001f965d3af0] [c00000000002a61c] program_check_exception+0x7c/0xe0
[ 5492.821344] [    C110] [c000001f965d3b20] [c000000000009b2c] program_check_common_virt+0x3bc/0x3c0
[ 5492.821352] [    C110] ---- interrupt: 700 at irqentry_enter+0x74/0x1a0
[ 5492.821358] [    C110] NIP:  c0000000013c2114 LR: c000000000148c88 CTR: c000000000008e40
[ 5492.821361] [    C110] REGS: c000001f965d3b50 TRAP: 0700   Tainted: G      D              (7.2.2-5.g6824496-default)
[ 5492.821363] [    C110] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 42004208  XER: 20040145
[ 5492.821370] [    C110] CFAR: c0000000013c20b4 IRQMASK: 3 
                          GPR00: c00000000000904c c000001f965d3df0 c00000000205ad00 c000001f965d3e80 
                          GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR08: 0000000000000000 0000000000000001 0000000000004000 0000000053474552 
                          GPR12: 0000000000000000 c000003ffef56300 0000000000000000 0000000000000000 
                          GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
                          GPR28: 0000000000000000 0000000000000000 0000000000000000 c000001f965d3e80 
[ 5492.821399] [    C110] NIP [c0000000013c2114] irqentry_enter+0x74/0x1a0
[ 5492.821403] [    C110] LR [c000000000148c88] do_page_fault+0x68/0x140
[ 5492.821409] [    C110] ---- interrupt: 700
[ 5492.821410] [    C110] [c000001f965d3df0] [0000000000000000] 0x0 (unreliable)
[ 5492.821414] [    C110] [c000001f965d3e10] [c000001f965d3e50] 0xc000001f965d3e50
[ 5492.821416] [    C110] [c000001f965d3e50] [c00000000000904c] instruction_access_common_virt+0x20c/0x210
[ 5492.821421] [    C110] ---- interrupt: 400 at 0x1043f158
[ 5492.821423] [    C110] NIP:  000000001043f158 LR: 00000000101218e0 CTR: 00007fff7aef4f00
[ 5492.821425] [    C110] REGS: c000001f965d3e80 TRAP: 0400   Tainted: G      D              (7.2.2-5.g6824496-default)
[ 5492.821428] [    C110] MSR:  800000004000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 82004208  XER: 20040145
[ 5492.821436] [    C110] CFAR: 00000000101218dc IRQMASK: 1 
                          GPR00: 00000000101218cc 00007ffffd284ce0 0000000011de7a00 0000000012c2c370 
                          GPR04: 0000000000000001 0000000000000000 0000000000000001 0000000000000000 
                          GPR08: 00007fff7b070d60 0000000000000000 0000000012c2c380 0000000000004000 
                          GPR12: 00007fff7aef4f00 00007fff7ba8da00 0000000000000000 0000000000000000 
                          GPR16: 0000000000000000 00007ffffd28c2ac 0000000000000000 0000000000000001 
                          GPR20: 0000000000000197 0000000000c03cff 0000000011e0d210 0000000000000008 
                          GPR24: 0000000000000000 00007ffffd284f58 0000000000000000 0000000000000000 
                          GPR28: 0000000000000001 00007ffffd28c2ac 0000000000000000 0000000000000197 
[ 5492.821464] [    C110] NIP [000000001043f158] 0x1043f158
[ 5492.821466] [    C110] LR [00000000101218e0] 0x101218e0
[ 5492.821468] [    C110] ---- interrupt: 400
[ 5492.821470] [    C110] Code: 7c085040 41810e8c 39400000 39000000 3cc0fffe 60000000 813f0000 71290001 41820050 3ce00001 60000000 60420000 <7c40003c> 71090001 394a0001 40820028 

Thanks

Michal

