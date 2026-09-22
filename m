Return-Path: <linuxppc-dev+bounces-27903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14DCC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:22:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptQ510NXz2ygK;
	Tue, 22 Sep 2026 18:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790065373;
	cv=none; b=gwmWSTo2cTGOEU4Zd43iLmZnGmu4ASFzjLj/cN5FGPQg+tZAueF08E4STk504Jh0l8wEUEB3K1JN+Nf3JELBk0ibcvUg1sVO7LoTAyeFYjaN2oFV7993cTasi7ACWTeQ/a2xLD5+oimSaKUm8nKDWlowxIlG4ADKSFXOhHsxfk3MfsEFfCUNEif5el45Bfr+O2F1bEn1aX/oODsJk8VfuN8NrjzVQ6reatsWDikNuf6rhgjEyy4Cov1kxmHHOfkW2VXZWulyQBXI5kmIz3R8ICK21b+xD01AYeuhcpaHAa6IBqIaoBg07d38PGsUv5uFEwlVq07ORelqamg6wCvxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790065373; c=relaxed/relaxed;
	bh=iZzt+RDISbYJoNrIFWcnz0zVtBndVvGifxdAcTj/o8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq8rL8B9tL0G0Vvv4cY4JhX6D7cBPporpwH5gmMIZhI3iV6xyzE0WAZl4i5OTCtUue6kwAU7ivrxk26X8+TzJCf6LZLOKLeKnI8iCkJuHdEdvF4sQJAzyEtaaZRnmwhmYMsG86CI6UxtGm+xiVHU72VFEXfYlx9RjHeftlTbhHuakPaBZWZOsPfdoXO1LttlfapeAQN8cB7z+/g5P1esDfQO+jqYzsYGEqawyKpVJsW/VAxkoHUxR5IHf4O22+qLG74vYYqvGseBwj+H4XoF2YDD9kV6npHDCm95gyu/Nt3Y03QR6yv4TvUUJhLFKjBXtR7oLD4lJXbWK+8UnXvuAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptQ42T2Wz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:22:52 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A758E1F833;
	Tue, 22 Sep 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Tue, 22 Sep 2026 10:22:47 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
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
	Gautam Menghani <gautam@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <arI61xOWOp3am23q@kunlun.suse.cz>
References: <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
 <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
 <aplnPuVk4LWgpu3n@kunlun.suse.cz>
 <e211e1fd-0923-4ab4-9e01-e9151807cf26@linux.ibm.com>
 <apl1-rm_-Hb_ROE4@kunlun.suse.cz>
 <arDlfmpHrN8sbP02@kunlun.suse.cz>
 <arFfc2apYaBuNvmC@kunlun.suse.cz>
 <bebaa831-9d56-4276-9422-9c5da8ab220f@linux.ibm.com>
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
In-Reply-To: <bebaa831-9d56-4276-9422-9c5da8ab220f@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A758E1F833
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]
X-Rspamd-Action: no action

On Mon, Sep 21, 2026 at 10:50:41PM +0530, Shrikanth Hegde wrote:
> Hi Michal,
> 
> On 9/21/26 10:16 PM, Michal Suchánek wrote:
> > On Mon, Sep 21, 2026 at 10:06:22AM +0200, Michal Suchánek wrote:
> > > On Thu, Sep 03, 2026 at 03:28:26PM +0200, Michal Suchánek wrote:
> > > > On Thu, Sep 03, 2026 at 06:06:16PM +0530, Harsh Prateek Bora wrote:
> > > > > + Amit, Gautam - since they recently came across a similar regression which
> > > > > is seen with non KVM workload as well.
> > > > > + Venkat - for CI improvement suggestion below.
> > > > > 
> > > > > Hi Michal,
> > > > > 
> > > > > On 03/09/26 5:55 pm, Michal Suchánek wrote:
> > > > 
> > > > > > 
> > > > > > There is another problem that Linux 7.2.2 often locks up on boot inside
> > > > > > the guest, and as a result a different kernel is needed in the guest to
> > > > > > reproduce the host crash. This is more recent, linux 6.12 does not have
> > > > > > this problem. Will try some different kernel combinations to see if I
> > > > > > can narrow this down. For this the repro is merely booting the kernel in
> > > > > > the VM, it typically fails early before userspace produces any messages.
> > > > 
> > > > This one regressed between 6.19.12
> > > > https://github.com/openSUSE/kernel-source/blob/9f6830f/config/ppc64le/default
> > > > and 7.0.12
> > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > > 
> > > Which is when preempt was enabled.
> > > 
> > > Very likely preexisting problem that was exposed by enabling preemption
> > > again.
> > > 
> > > @@ -121,9 +122,7 @@ CONFIG_BPF_LSM=y
> > >   CONFIG_PREEMPT_BUILD=y
> > >   CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> > > -# CONFIG_PREEMPT_NONE is not set
> > > -CONFIG_PREEMPT_VOLUNTARY=y
> > > -# CONFIG_PREEMPT is not set
> > > +CONFIG_PREEMPT=y
> > >   # CONFIG_PREEMPT_LAZY is not set
> > >   CONFIG_PREEMPT_COUNT=y
> > >   CONFIG_PREEMPTION=y
> > 
> > Looking more into this the problem is not reproducible with 6.19 with
> > full preempt, and can be reproduced with 7.0 with full preempt where
> > preemtion is mandatory. It only so happens that 1.19 was last kernel
> > where preemption was not mandatory and where this problem also happened
> > to not manifest with the Tumbleweed config.
> > 
> 
> I am bit confused. Is it different problem than the kprobe/bpf issue
> which was observed on host?

Yes, it appears to be different, a crash very early during boot with a
different stack trace.

> 
> Is this kvm/guest specific problem you are observing? Is it still seen
> even with that kprobe/bpf fix?

Yes, even with the fix this can be observed.

> 
> > It is not deterministic enough to bisect. It's probably some kind of
> > race condition or code generation problem that can surface and go away
> > or become too difficult to reproduce with seemingly unrelated changes.
> > 
> 
> Can you try latest kernel?

How much latest?

I tried with 7.2.6 with the kprobe fix as guest, and some earlier 7.2.x
as host already, and the problem is reproducible.

Thanks

Michal

> 
> There was change recently to move to use
> generic transfer to guest mode work. i.e VIRT_XFER_TO_GUEST_WORK.

> 
> > Crash happens very early but it's eemu so the memory can be saved
> > regardelss. The problem is that the crash tool refuses to load the core
> > bacause it detects the core as SMP and vmlinux as non-SMP or the other
> > way around.
> > 
> > Thanks
> > 
> > Michal
> > 

