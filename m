Return-Path: <linuxppc-dev+bounces-5756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CBEC0218F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2025 17:05:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl2MK3Xk5z30VL;
	Sat,  1 Feb 2025 04:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738343117;
	cv=none; b=TyXuDyXxVA2+dfs93MTBaFHinLP5u3LjPi8MnSbwjKhgK7V2qIxjZdFezLEsc2W5P48DsfsvQLfEa9l+sZpebzn9Ud3UPWPtZi/Ox4b+3pk46cVFmwR5QKadApMJoDYGZIeMhG9uBTU7rYzikruoDtom5AQx0MCPrmL7xeoyjiSqfN47VPq1CjLJMr5RZRa2a/vRTBHLXsETOiVk+YM5wtiE8WsolSzGUVH5TECSDpTh4UPUP0wyqR07nCCI/kYeOTwW2rE6+0uZKmg/4kjIgcjSI2NNy+L2V+BtRNiupdoyJmwWAS/JX6AuTxwkZJl08jM/7io46GdfE2Y4EvSOug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738343117; c=relaxed/relaxed;
	bh=e3aVNQtrbvPz9rlcALubmaXzYx+tR9iSXoM9KvTdR1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5BsrJ3nrWqLL+fWbrmKFDKc/DcpCb/uMg7h78t3n0m5C0OfHbj1LB1DAVs8kEMH5yE7pwtyzAgtsVJKl+21JEoAOXT+E7TZAmpsvejLz+0AUnxtCXOj9qfDs8gv7wuITtyP/ViFBAVCmjm0kRoXtCiUy0i1B+PkC8TSb8wR4YeGlpRZG6SMRZ2PMZU9saOop+RAdCh55pldSRXZ3s7nlThiIorDZ7Pgi+eBCBnzDwwkiJA336DW94WYXfK6RiQN6CbWiylGAEU1cP90cY7w5ara+aQhiqND5OZMwDdYZxrDqLDHcOOwt/aXJXpQ9muuzcwtZqhBxtDH7lNJZRQCjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl2MJ3RcQz30Tc
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 04:05:16 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50VH3ChB029263;
	Fri, 31 Jan 2025 11:03:12 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 50VH3CTh029262;
	Fri, 31 Jan 2025 11:03:12 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 31 Jan 2025 11:03:12 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/microwatt: Device-tree updates
Message-ID: <20250131170312.GE20626@gate.crashing.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org> <Z5lfmZtfHD7t2IvK@thinks.paulus.ozlabs.org> <D7ECKPNWAU7O.39PRDJ4PIG0P9@gmail.com> <Z5nWXtdCokYuVbXo@thinks.paulus.ozlabs.org> <D7EESJRZLTRN.37Y8R25CUSCY6@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7EESJRZLTRN.37Y8R25CUSCY6@gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Jan 29, 2025 at 06:20:31PM +1000, Nicholas Piggin wrote:
> Perfectly reasonable to not add broadcast tlbie in microwatt.

If you call "the easy way out" reasonable, then sure.  This pretty
trivial hardware addition causes so many software headaches whenn
missing, it isn't funny.  "Friends don't let friends skimp on minimal
system support features", etc. :-)


Segher

