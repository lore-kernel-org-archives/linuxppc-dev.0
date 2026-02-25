Return-Path: <linuxppc-dev+bounces-17189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5F3FCEE8A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:37:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLXch230pz3f1g;
	Wed, 25 Feb 2026 22:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772019428;
	cv=none; b=S/ZDSZ4Vo4BWToVQPl5mzH3f2dtIoGx0CNB1TPOIwl6UJXfXSAWIk8dFygAxcqdveOX+8f5CbLeb7l5TX2RjJvLR8C6YYY2IMQzq9wsQRqrEzOcafjrH80UZLcg4jbR6On/I1d+ZIqU7JGubwZnyJ7Y1hNaYJaDKwLStME0iKExrnGUWU+JCyElmMLkaFAxNAwum5QUAzuGKxYwONcaQ1fj5HxTNo+M3koMgrdj+IkZOpPJin4r5+G1+WEZ+M4TiQK7yhkB05sF0F1D/TzHXXgBey3bMFjJR5Utnz/q3KaiIw3SzhCuDw6t2ChbBFX/PiSrPQyq66Fwn37r18lm9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772019428; c=relaxed/relaxed;
	bh=SW71WeRbACuk909swxb2Z8jt9/wXsC+QTFSAi0G1Dq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIfi6SWdGY16baGlGGyaGAA2+E1KZYY3Pl43HbcskLJcQNqE0rp/r6QFWRWqiXMaTb9En9HVhwfclSjKfDgOVO0tM0OAqHJCO+/BE4ZRUN9qzbFNDUc39FuoZ0IXtQ6GVyvO3hLcIM6NBl0Tq3zXh75H5hlWU/Ls1C8Vcpp0UPCPEF2OdmXtYvCeK3mV63GZWW+K+JUGCoSuWecvCieSvojIcRoK3Hu9DhYs+E+aQx84F1qvXLQXEMieL5I0S9CSoUf0pIRP29+rn1mSzGtP3BXbWxlAON/piy4FHqFNce9o86urmXtesU2X793BZLap3hoJOvjx/Ut5UlthzDpU9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=YYutkN2I; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=YYutkN2I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLXcZ4WwTz3f1Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 22:36:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SW71WeRbACuk909swxb2Z8jt9/wXsC+QTFSAi0G1Dq0=; b=YYutkN2IT/62sokZoK2c9Y2kqm
	aWfdP9DRYQN6LFXXLAEhiNn40eiz9nh27ym7Nc30EmCCkg0Hokev8d6dPFMS2jRH95Ho3wkFaZ+Nv
	eth02CdFQRcFOaGBz4IDiWI4PYzfAR3gG/3oB8y74gJIntkvuZZfbea9qYqYdBtqnPA9KjhEzyPs/
	ltgpckD47DrT4eqYjv13HFehyrWkR5XLr/1/hUqfrW+XJSyydu4p1cgxsEvJZ9HfmdO59W3/PwFxA
	+JSIBOlpjqn7mhVMNICNJoIj1JZgaSdoDCtv0aD2BtheYVDZD5BFmY9lmAnoc02xhyHhxJo8ao8NP
	CIb+Og1Q==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvDCI-00000008u6b-3rjR;
	Wed, 25 Feb 2026 11:36:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E2F730331B; Wed, 25 Feb 2026 12:36:53 +0100 (CET)
Date: Wed, 25 Feb 2026 12:36:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <20260225113653.GM3016024@noisy.programming.kicks-ass.net>
References: <b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de>
 <185d7a42-f7b4-44e1-a129-f5989d211c74@linux.ibm.com>
 <40154f6a-39da-959d-e039-5ab9ff62db3c@xenosoft.de>
 <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
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
In-Reply-To: <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>

On Wed, Feb 25, 2026 at 08:16:46AM +0100, Christophe Leroy (CS GROUP) wrote:
> +Peter
> 
> Hi Christian,
> 
> Le 25/02/2026 à 06:54, Christian Zigotzky a écrit :
> > Hello,
> > 
> > We were previously able to disable PREEMPT in the kernel configuration,
> > but the latest kernels now enable it by default and it is no longer
> > possible to disable it.
> > 
> > Is it possible to let us decide whether to activate PREEMPT or not?
> 
> Can you give more details on why you want to be able to deactivate PREEMPT ?
> 
> Read https://github.com/torvalds/linux/commit/7dadeaa6e851e

Right. So to recap, there are and will be more cases where relying on
preemption is mandatory. 

The typical example is huge page memset/memcpy. Currently that is done
in single page chunks with cond_resched() in between, but it is much
better (and faster) to do a full huge page in one go.

Combine this with the endless stream of mostly random cond_resched()
placements due to $reason, and it is all a bit of a maintenance
nightmare.

I suppose the question is; why do you think you require non-preempt
kernels?


