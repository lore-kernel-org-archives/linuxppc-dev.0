Return-Path: <linuxppc-dev+bounces-21768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450CCD6E52
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 15:26:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gT1Cg0ky7z2xld;
	Mon, 01 Jun 2026 01:26:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780241199;
	cv=none; b=WnnK/5n1FdsomRdpUtKRl809wJBIk2G83d7loh24uYOP/fP85Jt3imra842AE1gUBiMV7s8iq+x+Wi0lyZtbR8KOodzrzA3oo3OKL9bl4cRnI+Xr9FuyIIifrr/M4b4hzscDy0ITMhw5KzLzqjNMJHz0xoBtuRnw1TTGmeJPt3hj6+5ncqMSYwtR2dAnDe8IU8e9rwlsVztO+dhEweyyH71bVdNVs8NcK7ii7RoqH4MOFFoyMP6MNZEBz+LfqB9cc1ObvQtmO6BM1B/3HI7W9g56fMrgQverzg85NqBzjOKT/5z0sxm941oAtbT0GFvhyoWNE7xgaSJEHqARpV3P1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780241199; c=relaxed/relaxed;
	bh=z704NJZDS6mAj4oNh35dy4uyshG7Q7lM1eefKHZO5B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKmz7a1ytjULgy2c7PDvJHDLuRYBhAePQp0KcZ5Cn4MpR7UCeBVPYTXMATNAbK94a18K6O/3T4oAGGaiWu3QcqSawPqkz4aidhtHXysxWIn2rGlba/VYi1G6zXO2UfHCH9zvNRP+vgiqqLF/FQbwaVgZBgeoqKayQbgWoRnlLe2uc5YQKbunzmRStGlDae7wRa6SqkVyAfHM0lFSLIEfqke0ezDMbSN+VjdcafZWmmUuYL+ypUbYSgx0hIxanD0H9Wkt9lmaIWfx60WtxKeZ4mxGwb+QWQ/TnVWN0P7ddaTrmxjIjiqDBkv0GSfXED4o5e86NiMCahtyq/G7VmwH5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nhbaX4Nw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nhbaX4Nw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gT1CZ2NQ2z2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 01:26:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 86A51418C7;
	Sun, 31 May 2026 15:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D681F00893;
	Sun, 31 May 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780241190;
	bh=z704NJZDS6mAj4oNh35dy4uyshG7Q7lM1eefKHZO5B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nhbaX4NwOU06t8ZNdaIO0VxywgUqso+21KIvjTGnO/dDzWyLgFVlSnXu1SKqAqAWa
	 Gc1/Yty+0S8fbXvIQuX+5nSVl2Uvi931nBhBaIjTwOqIyFQLmWZnUHbcsWnPUXJrMN
	 5QhiO+JCfjEQ+85odRPaGugXyv2V2ueo+g7uQJfY=
Date: Sun, 31 May 2026 17:25:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, harshpb@linux.ibm.com,
	zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
	maddy@linux.ibm.com, npiggin@gmail.com,
	sashiko-reviews@lists.linux.dev, seanjc@google.com,
	pbonzini@redhat.com, kvm@vger.kernel.org, stable@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	caixiangfeng@bytedance.com, fangying.tommy@bytedance.com
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
Message-ID: <2026053122-splashed-supernova-90c3@gregkh>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
 <2026053158-cussed-outweigh-6f0f@gregkh>
 <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>
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
In-Reply-To: <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>

On Sun, May 31, 2026 at 10:36:27PM +0800, Yanfei Xu wrote:
> 
> On 2026/5/31 22:15, Greg KH wrote:
> > > -- 
> > > 2.20.1
> > > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Thanks for pointing out the correct process. I saw
> that PPC maintainer added "Cc: stable@vger.kernel.org"
> on v1, so I mistakenly thought v2 should cc...

That's great, then take a look at the file above to show you how to do
that :)

