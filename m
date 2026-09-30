Return-Path: <linuxppc-dev+bounces-28553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3078CA5FC6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvsD42l3Rz2yjN;
	Wed, 30 Sep 2026 20:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790765188;
	cv=none; b=k3X8GNcSYUJ+mjWPoFwGTSwQkKwSS2XeJVddSXJFqc979MdLtbRkMEF/knIVA0gQZc6hrTNSdzkAR8VWDB93+fls6JqKjMVsHzOj3BONipGkR3Yl2Q4gVw+EFDjMAwGa1yeFr8STVKfyd6/ES7RcoU930sGZkJ4ooAVXOEl/LuikUUx7Ci7FfaOa9phCD6ab/t0zJHyAn7RJk1TA1mOS5HCMORsUTt9o8mzbNYXX2NyNmlPeYJdynP/YWvGqgF7hNvrC4KlctcZpLL23ENdSLPxXjs+BqvfPoswawRYtUS33mhGgPlFd76p9AbgnYsaFFq+iDAMaa7Ap+6EgCBlObw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790765188; c=relaxed/relaxed;
	bh=vha2mZlvsTZ1FRZ5pcOWB5zzgxF3KqYGBexlTZlBrAY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN+xnaK4BPMAb12mosfNKRct91zGRAJwwGEzEe6Wh4EaqxcoC39oBDZVmjpF1A2AKLSYsusqbGytxl49P/xbfkqrNkUTPY77n9jIX3RJu2fna5zdQoT/sg0kiy9r9aVKsZJv/BXcbL+m0NVn7ZH/crMQNNdgTo4EtwJUonxLZvfcqi50OFkGnc57xJBX7VJ4StLM2YlrbegJwdFjmOgCtv/THST429eo2YOfqs2vhRn5sf/tA0MwdcAL1dQQ5e1ycyqTaowMfX5VOqgcwLmQtrYDCAU/3NcjNXLo4Xx4dbIVp9xS330jW9MoZPDDjOUKjmz6mv2oUOa+ou20JR5PBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Xvs+L+u6; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p79WMNiC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=i85jP3Hw; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c5Z7bzRW; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Xvs+L+u6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p79WMNiC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=i85jP3Hw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c5Z7bzRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvsD16Wpcz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 20:46:25 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80A9E1F88D;
	Wed, 30 Sep 2026 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790765176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vha2mZlvsTZ1FRZ5pcOWB5zzgxF3KqYGBexlTZlBrAY=;
	b=Xvs+L+u6ppLUX4ScDGSeBJNLnT/m8Lo0JL4Z5R90pvf9pjMYwjDUUXKp52m59X27cX1WXL
	F04q1CKPoJHXrQBMLTacpGk85Nhv8/zdTOCcXMmArGNwxcpkAehXQvHAuV9XN4wfVuMwTM
	kvbYWbG28fxkTerrHXTWsb5pCnUP0to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790765176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vha2mZlvsTZ1FRZ5pcOWB5zzgxF3KqYGBexlTZlBrAY=;
	b=p79WMNiCKmQJnkhsC4kaNa7RNd89bhn/Sihh67IQhfWTQzH0C+kyWTWQaAfuJ6YfoTe1GG
	+cnXYfwjvKsC2WAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i85jP3Hw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c5Z7bzRW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790765172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vha2mZlvsTZ1FRZ5pcOWB5zzgxF3KqYGBexlTZlBrAY=;
	b=i85jP3HwywaBCIUJICP3abTCce23XzR9JEWjNMSciHJjXGJGjJ8jdonA/U7akkEo0uKOF6
	m0h43WP8HOO0JqUiYbAxWeFZKBzS7ChZL4guNbfyaRWQPjsYxNaVVopnRTIz0D3hUIQD0G
	dNbINm9iA6tQlXaqb7085snJs+kzQ7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790765172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vha2mZlvsTZ1FRZ5pcOWB5zzgxF3KqYGBexlTZlBrAY=;
	b=c5Z7bzRWFzKowjQOsTBuFVYUahA38ibRkjeJD/GB3HMf/BPHI1N8zX+P+v5vd272/L4+pn
	nHIm6tefiOi+RtCg==
Date: Wed, 30 Sep 2026 12:46:11 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <arzoc3etsNPU0JZU@kunlun.suse.cz>
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
 <arubQ77S4mvvykaN@kunlun.suse.cz>
 <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
 <aruso0aJ4lsrERTb@kunlun.suse.cz>
 <20260930010555.da0b1682-03-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260930010555.da0b1682-03-amachhiw@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.74 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.56)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 80A9E1F88D
X-Rspamd-Action: add header
X-Spam: Yes

On Wed, Sep 30, 2026 at 01:19:25AM +0530, Amit Machhiwal wrote:
> Hi Michal,
> 
> Thanks for sharing the host information and the full guest boot log.
> 
> On 2026/09/29 02:18 PM, Michal Suchánek wrote:
> > On Tue, Sep 29, 2026 at 04:39:05PM +0530, Amit Machhiwal wrote:
> > > On 2026/09/29 01:04 PM, Michal Suchánek wrote:
> > > > On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> > > > > On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > > > > > Hi Michal,
> > > > > > 
> > > > > > Thanks for the report.  We have been looking at the crash and have some findings
> > > > > > and follow-up questions.
> > > > > > 
> > > > > > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > There appears to be a regression between
> > > > > 
> > > > > < snip >
> > > > > 
> > > > > > > 
> > > > > > > Linux 7.0.12
> > > > > > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > > > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > > > > 
> > > > > I have been trying to recreate the issue with this kernel and config but I
> > > > > haven't been able to.  The L2 KVM guest boots fine everytime.
> > > > > 
> > > > > In addition to the requested information, could you please also share your qemu
> > > > > cmdline/guest xml you used?
> > > > 
> > > > The XML of the VM is below. What other information do you require?
> > > 
> > > Thanks for sharing the guest XML.  I had requested some more info [1].  Could
> > > you please share that?
> > > 
> > > [1] https://lore.kernel.org/all/20260928111234.faec09f7-8d-amachhiw@linux.ibm.com/
> > 
> > Hello,
> > 
> > full log below.
> > 
> > host:
> > 
> > numactl --hardware
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
> > node 0 size: 122139 MB
> > node 0 free: 103635 MB
> > node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
> > node 1 size: 139516 MB
> > node 1 free: 128483 MB
> > node distances:
> > node     0    1 
> >    0:   10   20 
> >    1:   20   10 
> > 
> > The patch does indeed make it possible to boot when the buffer
> > allocation fails.
> 
> Glad the first fix works.  That fixes the crash (the NULL deref in
> __find_event_file()), but the ring buffer allocation failure itself is a
> separate bug worth fixing too.
> 
> My suspicion is that with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, si_mem_available()
> returns falsely negative during early boot because NR_FREE_PAGES only reflects
> the non-deferred memory pool at that point — the bulk of RAM hasn't been handed
> to the buddy allocator yet.  The check in __rb_allocate_pages() rejects the
> allocation prematurely.
> 
>   [    0.149312][  T743] node 0 deferred pages initialised in 20ms
> 
> Since the issue is not recreating on my environment, could you please give this
> patch a try and see if the actual crash goes away?
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..224cc0e5c066 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2454,7 +2454,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>          * not going to succeed.
>          */
>         i = si_mem_available();
> -       if (i < nr_pages)
> +       if (system_state != SYSTEM_BOOTING && i < nr_pages)
>                 return -ENOMEM;
>  
>         /*

Hello,

this does seem to mitigate the problem with allocating the trace buffer.

Related to reproducing the problem it seems that it is much more likely
to happen on reboot than first boot, and the typical solution for kernel
test automation produces one-off VMs that never reboot. With the VM XML
as posted earlier using a full production OS image testing is not very
efficient. Still with something like

n=1 ; while true ; do echo $n ; n=$(expr $n + 1) ; ssh 192.168.0.2
reboot ; sleep 10 ; ssh 192.168.0.2 dmesg | { grep ERROR: && exit 1 ;
} ; done

the VM can be rebooted a number of times without additional user
interaction.

Thanks

Michal

