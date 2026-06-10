Return-Path: <linuxppc-dev+bounces-22430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C36CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 20:08:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbGzn6pQtz2ysW;
	Thu, 11 Jun 2026 06:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781122085;
	cv=none; b=aAsHiDi0jA6c3nLCtR7BBtOnKWBiu23F7cTGsZk4ROwdIXOPYmrrAUCMmVZNAob5xPbKuE7ZXoX6fQfX0UajR9eG/49I8tqZTZJlRsPHQzGNyRdomPbzt9dyrJVx2a5oYERyfSmccYUgOV9RCIEtqW2E2cZ74hS4pBd/zod6v/27k3AzLErDt3DJ+qV7aRN28E0ocjwCd0loemOdlH59McUBDj+gTrD4D7ruxMwzWwH9XAanJSNigjsd/r1IgFezq5fz2VqL5WVlmoLNXXudtPPSuXqYP+sCGaxpTxe684oRI9b/gxZrCd8C3P4ewg9G76ENv0F2OfwM46iWLL8AKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781122085; c=relaxed/relaxed;
	bh=stOAZYsbgJChIIA8gJ57kl6NPczJg+5VCILKjXJ6Qw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPlMU78ptaCjTGKglFVZbC8BosKA+WOm1wARTdwyIKj8EaCqfXqF0wcvjJIpp7DBVJ4PxX2XQCeA2VHKLdD6Bj2TrhQwwcVBVfX8X5dR5f++pRTtxa5i0GmWPkd0/cqpUkmdZ4wbPgU/I0AZ/94QayvaRGJ1Yfj4XYUuuChyGAOWAvirWSkChKepUKmsoq4v2hyV3+oaq8dDB1cDJC+noT7UJwsQySCvcJzFwzZz6X4JgMimIp+Dv/reGHh5UpVg6hbGj4spv7O4lONtz1Dl7TkTL5I4hIh0RvjE18kIo+fjVBBhjQTCbsI4gQCd16TuWVsHKZbcl04YVZqpkNLQzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TW8obmMS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TW8obmMS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbGzn2DqKz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 06:08:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C08C601DC;
	Wed, 10 Jun 2026 20:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D061F00893;
	Wed, 10 Jun 2026 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122082;
	bh=stOAZYsbgJChIIA8gJ57kl6NPczJg+5VCILKjXJ6Qw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TW8obmMS5PP67mj7wHlY9i1VkMJ/ZI/klOqkJ6ib8iIrdgA/aiL098zlnb3TszHm6
	 5XpmMPkm12zHgD0K9nRR92r41myUHsvQGuKrc3O7aULGC08BryXm/o+PNE6MyHFM1o
	 A3+ceEm+yU1nGIvYJBlNF6+Ht6qMpDMfq1o5I1vng5sQzLtazE30cZCxJRaITruKMl
	 XAkEGV4YsIUEXwYJLUvM5ur1VXbwc4ieqwxUpmTGdVJx9JDcKxej45+cOqSw5GUK+h
	 A2lFkjD/D4a3pW4cnItz/dTah/LsgpHP+Qo55zp3wSCPIGF29t/VKa+G8dZTYrUFB8
	 F6rBQ0Z3bkBcg==
Date: Wed, 10 Jun 2026 17:07:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com, venkat88@linux.ibm.com
Subject: Re: [PATCH V5 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <ainEHlAh0aJ7zSyH@x1>
References: <20260609134332.97954-1-atrajeev@linux.ibm.com>
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
In-Reply-To: <20260609134332.97954-1-atrajeev@linux.ibm.com>

On Tue, Jun 09, 2026 at 07:13:31PM +0530, Athira Rajeev wrote:
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=?" in the alias->terms.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

