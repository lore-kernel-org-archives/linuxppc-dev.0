Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D89FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Apr 2022 15:28:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KbJtL3x58z3bp2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Apr 2022 01:28:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XuZzvDcj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=acme@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XuZzvDcj; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KbJsg2skjz2ynF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2022 01:28:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6EA60AD1;
 Sat,  9 Apr 2022 15:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93EC385A5;
 Sat,  9 Apr 2022 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649518083;
 bh=fH6R5XI0+0MFwVlPvp4WGTQEHHbOqX/unKqNw5JN0fo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XuZzvDcjwzt33GApdo4mT8wyKTeHEbtZzEUxNitkFJbRjt9HdqKu72e8XXr4+P5ro
 HbzPfDVzTHfF9mh2gk45gdBJ6BoMTMP8mN7MBQN5WQpoA6HqXYKpMahvWYhVR9q3YZ
 uzUuAmPT+PuPzmevLpFjaBgCjyBsRdAPPzKV9+nlBv10EDD1OQJS+rkyUEZYcRNi8U
 spOkAiXFKcHxLmdX4ALNmYs7FLKveYOh88TRGVraNYFRWwTPd4zbGngas6OSmyEPA1
 Lwjc4z6nD0SOxycooll8D9EV9ROi+bh/eDUcdBwMS3p3KuOgLsoe3349dTevmxmkTy
 ERRcuypNQIinA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 0E06F40407; Sat,  9 Apr 2022 12:28:01 -0300 (-03)
Date: Sat, 9 Apr 2022 12:28:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix perf bench numa, futex and epoll to work with
 machines having #CPUs > 1K
Message-ID: <YlGmAd3LEh9He6Pg@kernel.org>
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: irogers@google.com, maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, jolsa@kernel.org, kjain@linux.ibm.com,
 disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, Apr 06, 2022 at 11:21:09PM +0530, Athira Rajeev escreveu:
> The perf benchmark for collections: numa, futex and epoll
> hits failure in system configuration with CPU's more than 1024.
> These benchmarks uses "sched_getaffinity" and "sched_setaffinity"
> in the code to work with affinity.

Applied 1-3, 4 needs some reworking and can wait for v5.19, the first 3
are fixes, so can go now.

- Arnaldo
