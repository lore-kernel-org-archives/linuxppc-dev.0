Return-Path: <linuxppc-dev+bounces-27023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33103C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 11:31:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgb9X4j28z2xWR;
	Thu, 10 Sep 2026 21:31:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789039904;
	cv=none; b=U/3BaYv6eVPasWjg76mbrwZ5PhqLehcmgmeWTBpLWFtxhkL+ArhqqK4PQB+FJkrwRXhiQPhteIE6NrNYV8JbgraJKgUA/uxkckXwVml/mZkDzQXMJq6ajCPvH5lMjVszfCltSCWV3UJws3Fg0mp9SXjLxIyJXPQgBDYTybqiVOdnGfDP0eHid4lAQ3bmkmzyuq7AtsaVz3ejg2dCMGhiPmMnCBKSEn9ZDRrhrQY256pRWniEMBdNJzFXv/3NLKf5BHqSmqIt4oYD1jI9VtNdUxLNWbDZyACD6sqSIYvR603FVW7lzM8xM3ut8u+j3/d6vwImEq5AndmF/OZ/MRrajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789039904; c=relaxed/relaxed;
	bh=z8zQ3DV6kVdH1EBgGF8C9Gj7Mc7Ct1Jy360SzFGTF10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyg9ya/GpXYJfZiAwgOdoA0VJp8jerE7XLsr3yEhQwnVncwhDuIt3ekOPi4gry1u4NDwhI/GfG+K37UoMwcNNAotfXA4/B4R1MAD5kH2y933AEv5oNHEAWWooNjnfQdzGWkUww0nHiJJo5KBiUh662xWXKAvxwue63YnWBgLzC/ipPe7FHwEG71gOvN3/vjINV+5OTNlpY5k5EKWrq7TlTdVOFHD/QgzdhLfhNpL5pggz5tP1NwtcNnXE38Zu4j8pw5Ef9mNPsGg8T7gjazeHKYmqQFM3+fG8MPHzTZIEJ4WbOmeS7SQ11EHBis/dz8P3dmSm/EOJ25Tr/1OL3YIgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HRQY3dvx; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LIP7ywa4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C12SEQPp; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=i8+bC40h; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HRQY3dvx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LIP7ywa4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C12SEQPp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=i8+bC40h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgb9W4B0cz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:31:43 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2806021B58;
	Thu, 10 Sep 2026 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789039896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zQ3DV6kVdH1EBgGF8C9Gj7Mc7Ct1Jy360SzFGTF10=;
	b=HRQY3dvx4on1sOkz2uEFq8YpB1izKh0VFWyFrxW+WGcUHE4OMU2t8z4WtRy5iYOgUBOh3v
	3ELffIdSZ/5TPkf0RARz7fT353Zg0SGmJ5Q5e/28yiRutNFuQvtlzpqpQ1dNr39fq40qoH
	7dsctGvVFvHfhkw9fK+AKPxWLmO4UQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789039896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zQ3DV6kVdH1EBgGF8C9Gj7Mc7Ct1Jy360SzFGTF10=;
	b=LIP7ywa4llg3j6Clx327TLYtVhKJ/vxgZhUIGI3UeTBR39PJdW7D8a/iIgPRgkxsyR+Qx4
	g6VZqE+bie4mWxDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C12SEQPp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i8+bC40h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789039892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zQ3DV6kVdH1EBgGF8C9Gj7Mc7Ct1Jy360SzFGTF10=;
	b=C12SEQPp3M4biYn0gnAjftxkvRaBX+31fRu5n2bfwuKs6xRXIwuS7PkEsXz9BzBOWXN6J2
	P6EXbUaDCEUAH3AhwC2EwXcRCNvCaP8gXY9znHU7ADxEUUx1vbUsAfGaTZVagxcnurneRx
	UWfscsipRwU2rbiuk6yw2wVYJCL9Oj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789039892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zQ3DV6kVdH1EBgGF8C9Gj7Mc7Ct1Jy360SzFGTF10=;
	b=i8+bC40hRj+KcYL9q977/CeHCyafG6ZlRxynqEdts7Y1yVTqlg1kQdHAXqHQG1MFtvXehI
	dMdigYx5BoEg0+CQ==
Date: Thu, 10 Sep 2026 13:31:31 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqKVE5s92tk0S97u@kunlun.suse.cz>
References: <ap568I8bQAmSKWj5@kunlun.suse.cz>
 <1D6F66F5-E181-4814-A7E5-E52A678D37A2@xenosoft.de>
 <aqJwL4N9h3cOWLIW@kunlun.suse.cz>
 <aqKG7dPFeytFLOjX@kunlun.suse.cz>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqKG7dPFeytFLOjX@kunlun.suse.cz>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2806021B58
X-Spamd-Result: default: False [11.71 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.63)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.11)[-0.543];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spamd-Bar: +++++++++++

On Thu, Sep 10, 2026 at 12:31:09PM +0200, Michal Suchánek wrote:
> On Thu, Sep 10, 2026 at 10:54:07AM +0200, Michal Suchánek wrote:
> > On Mon, Sep 07, 2026 at 01:32:18PM +0200, Christian Zigotzky wrote:
> > > On 07 September 2026 at 10:51 am, Michal Suchánek <msuchanek@suse.de> wrote:
> > > 
> > > There is the obvious question which I did not notice answered in this
> > > thread: Did you set up sysrq and/or kdump and find out where the kernel
> > > is stuck?
> > > 
> > > Thanks
> > > 
> > > Michal
> > > 
> > > - - -
> > > 
> > > I think I need kexec for kdump due to the system freezing after activating of KVM HV. Unfortunately kexec doesn’t work on my machines.
> > > 
> > > Further information: https://github.com/chzigotzky/kernels/releases/tag/Kexec
> > 
> > So there is some bug with kexec initialization on your platform.
> 
> Right, you are missing this part:
> https://github.com/torvalds/linux/blob/50d05c7c76c96b90462f24debacca971d2e86713/arch/powerpc/kexec/core.c#L205
> 
> Maybe it needs to be called from your platform code or something.

Lookig at the code it likely runs always but if your device tree does
not have a /chosen node it does not add the property that kexec needs to
load the kernel. Can you try adding a /chosen node to your device tree?

Thanks

Michal

> 
> Thanks
> 
> Michal
> 
> > 
> > Sysrg for dumping stacks to console might still work.
> > 
> > Thanks
> > 
> > Michal
> > 
> 

