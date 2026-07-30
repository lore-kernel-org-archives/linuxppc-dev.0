Return-Path: <linuxppc-dev+bounces-25126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6AC55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 16:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9vjb50wHz2y8c;
	Fri, 31 Jul 2026 02:26:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785428819;
	cv=none; b=PMq7QuxEA25vLH781XZjILjEpbqR4ktItwURT0P8bZSRXzgYOP05a3WDysZahHjbnWkFl2LaufEf1/am3wCm0+696GqBcOW6poYUIdzQ/jp3GtJXXhmFmOjlxd3OtpPIQrPz91QwGvtnwsxn4rSl8vpOy+wArxbMFTxcBLZvRS7uRfE4zPOdyo336JpXw0tWJjD82L/1d9DQuLfzowM93nVODTbsh1EwXcKA1NuMjKqm4c6SeNm2jdko2Xl7kqzxOHUDOepxXgJjG4FaHr4X6OEb3dEG4QOcckTIJ1PYQfc9G9vVhuU7aFbMwHOAmYDBoorzaj1seUjoIdmyVWKJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785428819; c=relaxed/relaxed;
	bh=sbfA2juAt/98XOG9rpncjItrUCEGNu2+yqfa8Dn6dmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FElTbqb5yy/nKdYPWxKO/cE2Eb5op6oSeTHVns98Z12Da4YXEaNVWZ7WNiYs/l5uoovkfZTA2ewtro/KGplVfuyW71LgEzOYpT38nuMUYJfoKD7rBimT7QYDbehEF4MGYCDxJOVHlfkbWVfwEPoJWPVSXnXSXZXJ46lFIXtkAwgCF7Xhs/krWWLE4N8YdbwJKtIa14PYIN1Ods9xBVscvIJC4HDlNCoeuPPKrLeLvqF484HglV16XixZrnKLVC0fFuXkOsJ4OmixcdSRBxvieq8XBP94rU17MaiOA4Kw2zbXiHquCDqGkNMr2jQKXMhJ8QAfOVAdfUlFuczcei3c+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0rvhXgw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0rvhXgw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9vjZ6qLgz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 02:26:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 870E543B65;
	Thu, 30 Jul 2026 16:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E4B1F000E9;
	Thu, 30 Jul 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785428816;
	bh=sbfA2juAt/98XOG9rpncjItrUCEGNu2+yqfa8Dn6dmU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=o0rvhXgwtf8NU5bj8YBa9sxkeXHs1WhIhW7kBa2+VmQ4ZKqKkgdXJxkZXmJbJmYMP
	 mXeU4FCZQvJD5m20oCuFHkj36bDsc8ixHdBigQmLki57titkKM+5sqrq/MrcrJCH1o
	 9f+moa65WDjDgQtzAImUv6dpCvCb/LedQLUBAzARgVtPmdEL8bp8fy2oK4jrTMnNP+
	 NeYpq1CaTmn3DGsRpMfh0W6si9qRc6I1APzWfQ/mPNhgWzMitsvIDQ8VMCO7T0mDPV
	 vEkqmnbrtoh8jMnA5LHOLTMTdHBd15auYeeEDfPMYHRG5nXfqm4fkPurUKmgzYK8Or
	 p+XnrqkTaHjOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35913CE0B67; Thu, 30 Jul 2026 09:26:56 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:26:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <663e8e58-19ea-472f-8c24-13a8b417e441@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
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
In-Reply-To: <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>

On Thu, Jul 30, 2026 at 05:08:13PM +0200, Jirka Hladky wrote:
> On Thu, Jul 30, 2026 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > But is this really a fundamental RISC cost?  For example, does arm64
> > see the same performance issues?
> 
> We tested arm64 (Ampere Altra Max) with the same controlled
> experiment -- two 6.18 kernels, both voluntary, differing only in
> PREEMPT_DYNAMIC:
> 
> Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
> -------  ---------------   -----------------   -----
> ppc64le  off               108,836
> ppc64le  on                 68,197             -37.3%
> aarch64  off                 5,538
> aarch64  on                  5,082              -8.2%
> 
> arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
> much less severely.

That is more like I would expect.  Yes, there is added overhead, but it
should not be excessively expensive.  Though I suspect that arm64 could
also do better.  Easy for me to say, I know!  ;-)

							Thanx, Paul

> > In particular, I can see why the preempt_count() operations need to be
> > interrupt-safe, but I don't see why you would need barriers.  And
> > doesn't powerpc still use software interrupt disabling?  If so, why
> > not use that to simply software-disable interrupts around the
> > preempt_count() operations?
> >
> > What am I missing here?
> 
> That's a good question -- I don't know enough about the powerpc
> preempt_count implementation to answer this. Shrikanth, could you
> comment on whether removing the barriers or using software interrupt
> disabling around preempt_count is feasible?
> 
> Thank you
> Jirka
> 

