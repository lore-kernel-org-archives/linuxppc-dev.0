Return-Path: <linuxppc-dev+bounces-23301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3DAC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqyvv2Kbzz2xKh;
	Wed, 01 Jul 2026 21:48:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::bc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782906523;
	cv=none; b=ZJdoOD6ZH609ShXQZD3KUxVqgQO2m5smuVlP96/dp0Uysx4qYMdcwEtQqZCCATpz174CU3/vjqKSc2nPezClZKHsMIAmsd3GNmnVQAwAcjYzpxueB7aAEENqVoBEvFfpopivtpboESkcuQhMJlJlUP9xhKtTZXv3umTCq0C5WPN3hT30JGCCexf+Zl/QhX72Fc5KPcLJSXyVeyzsRskHv+HoKyOjRSzc23QuaNSrwe9yWFE2ZQyRCffQpfGW2F80W+MzCJ3n2cqolrEpKsLszvMq3UvtLzbifmZB/42n50xBGrM5tiI0Rh9+YYmve9SHY8vS7a62hXiTNJkf35AS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782906523; c=relaxed/relaxed;
	bh=fsn8xJw2RfhnuoUr+P1qk0Nf9Ixprgz1x0gAk3OjnmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8UlwG5wlQoPCAaDfBJ6FDqvMNUAyub34fZ2mLaB7LVjhFugVSShMvybReVIvtuh1HaWK0+7C9zujArX6idKy7xW55ec5xK6R+2z0BrUD5lBdrjWGRLLl7k32lI6Mio6AuXnHVcmpFVpJbHM+fArgk0RyLZw8Q3bkejg1cFknorSEaZm/D1fFMoEIpaR1E2lW2FVvpq7YUMGoDffhQwbXa33GONxIBdlfwthnm4Lm7ldFrNzph+rax+RKGxunObp3k3ibsYUjODbcoyys83SSjLzPMSHYv7XzRYqF/bOYiBo0wN7fomQW1U6WfO+Mxqn54eBWRLt8o2LsJFmcoX7jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=to89oPCv; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::bc; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=to89oPCv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::bc; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqyvr1jkJz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 21:48:39 +1000 (AEST)
Date: Wed, 1 Jul 2026 13:48:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782906500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsn8xJw2RfhnuoUr+P1qk0Nf9Ixprgz1x0gAk3OjnmM=;
	b=to89oPCvTs9b+J06ANvzqIuW7/8gu2XKrpHMvgUYauEd4/CQeeXh827Yj9ELIA8RRcI9vf
	oUt9E9vMauYFkDhD7lv/h0dsn8Cs96qrc9FUu+LAHzbJOu/Vwogl4wtv6zMZ6FMjDllJqq
	+gtdNEKBpS3GrKXO+X6lTkgQqWMcc3k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Avoid separate strlen() in
 scan_callback()
Message-ID: <akT-e264aGvJRh3o@linux.dev>
References: <20260630154657.693088-2-thorsten.blum@linux.dev>
 <20260630183810.3287d10d@pumpkin>
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
In-Reply-To: <20260630183810.3287d10d@pumpkin>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 30, 2026 at 06:38:10PM +0100, David Laight wrote:
> On Tue, 30 Jun 2026 17:46:56 +0200
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Use the return value of strscpy() when copying the display name instead
> > of checking the source string length with strlen() first.
> > 
> > Keep dt_cpu_name static but move it into dt_cpu_ftrs_scan_callback(),
> > where it is assigned.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  arch/powerpc/kernel/dt_cpu_ftrs.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index 3af6c06af02f..8d8e94e4d2bc 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -90,8 +90,6 @@ static void __restore_cpu_cpufeatures(void)
> >  		init_pmu_registers();
> >  }
> >  
> > -static char dt_cpu_name[64];
> > -
> >  static struct cpu_spec __initdata base_cpu_spec = {
> >  	.cpu_name		= NULL,
> >  	.cpu_features		= CPU_FTRS_DT_CPU_BASE,
> > @@ -1069,6 +1067,7 @@ static int __init count_cpufeatures_subnodes(unsigned long node,
> >  static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
> >  					    *uname, int depth, void *data)
> >  {
> > +	static char dt_cpu_name[64];
> >  	const __be32 *prop;
> >  	int count, i;
> >  	u32 isa;
> > @@ -1106,10 +1105,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
> >  	}
> >  
> >  	prop = of_get_flat_dt_prop(node, "display-name", NULL);
> > -	if (prop && strlen((char *)prop) != 0) {
> > -		strscpy(dt_cpu_name, (char *)prop, sizeof(dt_cpu_name));
> > +	if (prop && strscpy(dt_cpu_name, (char *)prop) != 0)
> 
> That is different code.
> The old code only did the copy if the new string was non-empty.

Good catch, thanks!

I just sent a v2:
https://lore.kernel.org/lkml/20260701114428.818748-3-thorsten.blum@linux.dev/

