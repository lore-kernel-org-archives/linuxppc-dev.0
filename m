Return-Path: <linuxppc-dev+bounces-2373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9926CD30011
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2024 15:20:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XVT0Y0qMMz3bZs;
	Sat, 19 Oct 2024 02:20:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729264813;
	cv=none; b=JDGADwxKLmsvvbT0RGo1kQKz9RQwciAmOmJnWdJgIkKzD8fxExbgqywrzACBaKiLWdNKdX0SsUx6uevtB7BwSrWwcHUqRPOWR5BSXWbStbv7BBpFwglavzpkTr8i/yH7Aoauyis1EULtJcfGrcyM/r5dE92lCFoPNURf0BcOQRiCavhzuQkgjAInzth1F303mxBZPhfEQy8cfP6qRgvJG3MU7Pik+hRVlRsK+IK7uknNsoImMaZYzjfbBrpRpfP1kUD+RhHyGwnc/V1WZBWgxfMUUAMtzKBo8h9qClpZaU32a32mZ/6kRiCBHlxoX6RnWwXUIj2FHWOJjtBW2rewlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729264813; c=relaxed/relaxed;
	bh=lV42bYtWbNfI/HBeAg5JKgc40oxcnI4hhCxS5HmSKpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MyCO0RlFVndIEyGqmPyRF2kRz8BoPTCuTOFQvnONAJAUl5PE+sFBSNssg3xHuuNkK2Fv7vtmvimdwj5LfluDbY0txnkOi7ZMWUJBcJZqKWme553zlM+4HNtVhXM0Fn5772Baw4Lnhd1briNiuXHnIEPur/NWR6jHoQFdkFsHe03tdvKZs4jjdOrqJ0a9Rs2xwxbY8hnWeCEwkiQtSxquHAH2m0QWvuUUXiPNm7HCuM6fxOTe6qZH2RQK2KcReC7uN+HzoQFfnz8EjdrsghP6eZqDhLK9mrEvF6F6MNIgR+HrBTupgQCpPFeAKoumOVm8hJNMmdDXNY2Ic8u6gJdbXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rPEIufVF; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rPEIufVF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XVT0X1D3Cz2ydW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2024 02:20:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3846AA40186;
	Fri, 18 Oct 2024 15:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CDC4CEC3;
	Fri, 18 Oct 2024 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264808;
	bh=dYgNxH1KAZzJc6ZxlPcZAP/+GEwZCh9Os7i+9GyR4d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rPEIufVFvVle4/hC2CotZ+UlZBgPEYWocFgsbfUR8kAoE5OvZ7o7IDFQj23hLpBmR
	 jHfUUfSOqhhSlOvRMNCl6yf/yXEOebgbLyhubypDljvYJd7Yj0Vo0UgZUMHa2Xub4c
	 8KL3dnkKcBSq1JYM/R+dfoWGIMp1MoKAm0wPQjSYWIvtikr1OJJvWXWagXDethSbI1
	 jzF3e6p6ABhjkQZQNN++aEhDwixxl9VATp+0Icx45+DCL5NWRFGvkRp2lXE+Ylryc6
	 0gTehoePjWHfYi7sw8Fbu53zQYVGJkcp2NadIBa8AG35Emcem3TOvVUystVxkjltcy
	 IODv7J7Lvg/CQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, hbathini@linux.ibm.com, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
In-Reply-To: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] tools/perf/pmu-events/powerpc: Add support for
 compat events in json
Message-Id: <172926480855.1381973.17233939395641584642.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:08 -0700
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 10 Oct 2024 20:21:06 +0530, Athira Rajeev wrote:

> perf list picks the events supported for specific platform
> from pmu-events/arch/powerpc/<platform>. Example power10 events
> are in pmu-events/arch/powerpc/power10, power9 events are part
> of pmu-events/arch/powerpc/power9. The decision of which
> platform to pick is determined based on PVR value in powerpc.
> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


