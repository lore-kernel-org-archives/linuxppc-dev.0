Return-Path: <linuxppc-dev+bounces-24863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0247EC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:27:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7tXt27k2z2yhD;
	Mon, 27 Jul 2026 19:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785144446;
	cv=none; b=jOW1qbdyBbnBWqf2mo7+6vR5eNMrNYVvi4cHZk5h30408sP0D93LFSW9mM80gHrNZYNaLHzm2HOmRlp40HyshEFKxXUJX+BeJ6O576MD7t8zA4RhwB4blFQ39yL0r1gYHCHvay8B/ZPTVf6/dsaJe9YrE12/DYkncni10SHbwl8ySD3/uDTI7Wbgc8oFcOMoskzg97R1QkRHL1MAiBK7ngxMSnhFn7qBvd8O98BglsgYZmVW/ChhaAMzbEZVTiab+4iDyOBopTYWWnG/1xbWN0/VmFlBx5KMu4pHQ1LBpOG7CKdEvrmF8E7BQhlYalvqHqpca0ecVgJ21c1OpCrt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785144446; c=relaxed/relaxed;
	bh=QpGR12kjHsK2yqdrOyP0hwg/xZsn1HaED3s0TW47fLc=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:References:To:
	 In-Reply-To:Content-Type; b=nxDmVnXfIHN50kqbIE6LjdnzpObwArZHtbrDmMZHTj/lkY6EdjNCbBuwGSbkMigYtfdLeiYt33J/OAgXTFyhxu0wd0Df1Ym2lyLf192dvnv+kE0Zneq0iIcX0I7/IUn+dOXmtS74I6AOiYnXIIS3yvinwphI31G5x1WfVwV6Qd+5VCv5riKCD3G7Nv0CQM639vfs/d63IQ6cAi7C7vde9ft9cpNRKtfYqruLpWl5UP7jX9Q7dyNQDHeqyhekrJULlqx8Y14KQggVGJK7jdWo/ImQpzpjF8UzM9mjZor5IAMhCGrnY39/kiw9XxIqVXGxgl5MvY1iKjhxythlTHHa9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi4b517J; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi4b517J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7tXr570Lz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:27:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 317AF435F4;
	Mon, 27 Jul 2026 09:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4738B1F000E9;
	Mon, 27 Jul 2026 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785144441;
	bh=QpGR12kjHsK2yqdrOyP0hwg/xZsn1HaED3s0TW47fLc=;
	h=Date:From:Subject:Cc:References:To:In-Reply-To;
	b=Zi4b517JRsjxemt12ANlpJGDKSvGL0DM6W5ocge6ZUBhE0WLvrYFA2Tpnk4zREhIJ
	 gfjEKC9oeZriNdLCfGrWBvvO98FqseXNoV/zbmWnyTsjajzAIoZi02Uh78DbKu7t79
	 hb9PRiD11SxYJXuU+3X8Ham6MIqMv7rORKUMi9hkUruUZpV+zDxtAbCrkqTVoJ+6Pt
	 4BimW7s2bIyQ8mMImJHKxT56axMetgVnASGetZ69nAGtfn7tsATsFptIP6IL0NBgHh
	 QZ3YiqI6eNP+cD3P/HlcPNx1ZE1ed+CeAMroReSIfPt5Z8zKjqX2yXjNUKvP5GEfjG
	 lwSYWc4VMuABw==
Message-ID: <13ad3474-77c1-4edf-9d35-5af102bf7d43@kernel.org>
Date: Mon, 27 Jul 2026 11:27:18 +0200
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
User-Agent: Mozilla Thunderbird
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Ozlabs patchwork very very slow very often
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
References: <8f6e5825-9468-4499-9bbd-4588a1eccc94@cs-soprasteria.com>
Content-Language: fr-FR
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <8f6e5825-9468-4499-9bbd-4588a1eccc94@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen, Jeremy,

Since some time now, I regularly observe very slow response from 
patchwork, to the point that my browser times out before getting a 
response from the server.

This is really annoying. Are you aware of any problem with the server ?

Thanks
Christophe

