Return-Path: <linuxppc-dev+bounces-25122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6DAC55164
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:51:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sbH4Y77z2yhb;
	Fri, 31 Jul 2026 00:51:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785423083;
	cv=none; b=OI3w+X3auleEjIvtHJ7BQgI2IXafXN4EY5l9Zkqv/H8Zs81IpAhqOjJSvBVrS3MMba5sWUiz/5GpizL2+z38HiDw8DT3p57+ticlnBu4koNaeA7+FKjfI07293y8qYIXt15W/VB5IouaSFJSZZKN51ybX0yH5HB8D3ZLeF1xQq/oasE2IQPyLd+zCEVGn5NRVuIuQaB+QggWXtl9lVvzGFccKmgDPr1EVnRIwQyv+vXIAkpP0+ZCJfFbNnnuo4mIbmQ1Ani4CReEOBHeir5QA0LvTgYeyY0UrazUitppdgYLjyTrvAbXB/URom3xc15QADx7v2wmfqY5AY7yxE38yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785423083; c=relaxed/relaxed;
	bh=DVwG/1qnnTWdBy+aAKhElTBYiZFfFoArANzLHRXjAII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNaFhyvk3cCVnQ8sVactZxR+Uyy3tJ9wfP4YdmbarssI5/N/EPzdpblqkjsukVf2R6IU2uasTrmLqTN3wUGKMTTuC7IvHw/AvqVDyx6RYNKkH7HozpmpF7t/kCwP3SYyjW76DFDbqnx+GFkDKIX7EowZJUQRbEALKnKKRYKddpiVxrXiKcTR8Xzf356Db2CiTQuCss0ffLQyRWG3+OTJT6AP83CoV7PEGoylwz77QdgzhNM/iMGs83AqlZ9Wkxq0xG05N2R8PXM4V+m58SytSqBaYUWSC2sFmynBOynFFdopqF8hyCNr+zZgnPfLJPMCdCjZD27MpMSW5/VZ0OZPMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwFhrNXj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwFhrNXj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sbG44vWz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:51:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C0D6043CF6;
	Thu, 30 Jul 2026 14:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25261F00A3D;
	Thu, 30 Jul 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785423080;
	bh=DVwG/1qnnTWdBy+aAKhElTBYiZFfFoArANzLHRXjAII=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WwFhrNXjQ5HevYtkOEf1VfpbmPvFF/eVWEhDxy1MZJPJuvHwuubdT/ue+jjLONS05
	 5mVpP7pvTiwm0lx+81zAExiQ4Wt4/E886xcXJUkz3JhvEGlmQ2XQrK+OgxHnt23kFF
	 er3r7upxoWRp35YBYv21Qvy8412KKYqCkpWzULNjd86iH96AHXuKJGfFIBIRaf6UQ/
	 E9CFZQG4f1DWuWu35cLd+oj8M1LUl5KRUZQZx1wnHE0MgpvzBoTHSeAdY8MppJUx/V
	 CnY10x5rQHR700JG1wpP7xTVfc3c6sDJzium2eY7JQCg4YGUnkPii2OnE4oqoGwpMS
	 7xm2sk7is0X0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72EB6CE0B67; Thu, 30 Jul 2026 07:51:20 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:51:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <9bfd0674-1bcc-472e-a177-8659f9b9e6a8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
 <82752e9b-ed94-4253-ac5f-83cd3c91d569@linux.ibm.com>
 <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>
 <0152cea9-cce4-4b68-8684-d82fb1c22233@linux.ibm.com>
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
In-Reply-To: <0152cea9-cce4-4b68-8684-d82fb1c22233@linux.ibm.com>

On Thu, Jul 30, 2026 at 06:31:12PM +0530, Shrikanth Hegde wrote:
> Hi Paul. Thanks for taking time looking into this.
> 
> > > In current upstream, lazy is a preemption mode with preempt_enable being a preemptible point,
> > > 
> > > 1. If PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n, then PREEMPT_RCU=n. That seems wrong. It is supposed to
> > >     do the preemption checks, since preempt_count is actual count with lazy preemption.
> > 
> > Sorry, but no, not wrong at all.  This is the way that it is supposed
> > to be.  In this configuration, RCU readers explicitly disable preemption.
> > This gets us minimal RCU overhead on architectures such as x86 and arm64
> > that have prohibited CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY.
> 
> This is after 7.0 only right? Before that one could choose even on x86 and arm64 IIUC.
> After 7.0, even on powerpc, one cannot choose them anymore.

Yes, until quite recently, you could select CONFIG_PREEMPT_NONE and
CONFIG_PREEMPT_VOLUNTARY.  Now you can do so only for architectures that
don't support preemption, if I recall correctly.

> > Not zero overhead, but minimal overhead given the constraints imposed by
> > CONFIG_PREEMPT_LAZY.  This also prevents preemption of RCU readers, which
> > is extremely important on datacenter servers that have good and sufficient
> > quantities of memory, but which are not well-endowed with memory.
> > 
> > > 2. PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y are supposed
> > >     to be similar w.r.t to performance.
> > 
> > RCU never made that promise.  ;-)
> > 
> > With PREMPT_DYNAMIC=y, RCU has no choice but to be preemptible, at
> > least unless and until someone decides to make RCU's preemptibility be
> > changeable at runtime (which I do not recommend).  And we really do need
> > non-preemptible RCU for server workloads.
> 
> most of the distros i see set PREMPT_DYNAMIC=y.
> I checked in SLES, RHEL. (I could be wrong here)

I believe that to be the case.  But there are those of us who build our
own kernels and deploy them through large numbers of large datacenters.

> > So it is not just that RCU never made that promise, it is that RCU cannot
> > reasonably make that promise.
> > 
> > >                                         Promise of PREEMPT_DYNAMIC was the ability to
> > >     switch at runtime based on the user workload and his/her preference.
> > >     But with  PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y, there is additional cost due to PREEMPT_RCU.
> > >     lazy being the middle ground w.r.t for decent performance, either PREEMPT_RCU should either kick in
> > >     for both cases or bail out for both.
> > 
> > Absolutely not!!!  Please see above.
> > 
> > > Before 7.0
> > > 3. the same concerns would be true to PREEMPT_VOLUNTARY and PREEMPT_NONE with PREEMPT_DYNAMIC=y.
> > >     Those model never wanted a preemption, but PREEMPT_RCU could have forced a need_resched to be
> > >     set. Which is also likely wrong. No?
> > 
> > You lost me on this one.  Please give me an explicit sequence of events
> > that would cause things to go wrong in this case.
> 
> You are right. PREEMPT_RCU may set need_resched. But even then on none/voluntary
> schedule will not be called since static keys it cannot.

Whew!!!  ;-)

							Thanx, Paul

