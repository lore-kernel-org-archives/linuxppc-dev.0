Return-Path: <linuxppc-dev+bounces-19258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF39D6AAFA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn1Lb3H0rz2ygT;
	Fri, 03 Apr 2026 12:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179671;
	cv=none; b=Q5ZI+qkC9YYRltT8znS6stLzcdpYp4TFlBTQN9XCGP9v13HIwLnYmQc9fYhJcHOlqELCAgoeADyFw2IdkGXxN0TFz77zMwARqbn0EKkU/O+Y6bw7QKyWDm9OYtbm8ELR50LrV81k5o3uzvM6N1ZLhyyV118mvNaXlSxMh7m9Rn+CmDVMMhPYb4tApuEDrz+/FQaGhEg97RwG+15U029x00zIn4wq3m2ZUmD5j13WWe5Vwk1gza8lABIy7U/3vQchA9+IRq+zGUfKEDAVyTiECGmk1hFiNU3aaCKvUisof8FWZXZU6slpKFk7aq2B/iNq7rY9PsCGgUxw1jVX7tfZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179671; c=relaxed/relaxed;
	bh=vXg9hIvMP9Xj0iSaJ1TazSOYTkoqaQsnAjPOALJoxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezj5j+y1t7qJjO+Bx0mh9e+Tk2g7Y7NzwHstVD4RdwA2+F1qUJAkMgoGprYHWff+UIYiwkSg1XPwXdKlY7XH/oEh3hE+OlW4TPKW6qshaYwOgTO/kVJU9U9Q3TMHfx1PT9rEs39LP6na8SuhZvq1Z4Yq6OP0xLG5CLbBGhSawiMmhqgl0NyZUA4rwF+Ci6VOh4tG6N8TPCtoI6gVcFiHzzrWYOQNFUek9aFK/ukGncEgoxJJTSiW7JQjyBuCAa5NO5SESBt7chUH6i9W7SUeRoxmA5FDNam3K5vVCfvN8Y2m0WgvwRX2k4e32G5hC9O9sfsBX61odu6CX/3K7p+ROg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J+3qCKwA; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J+3qCKwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn1LZ5wggz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:27:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 94D8960008;
	Fri,  3 Apr 2026 01:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20AC2BCAF;
	Fri,  3 Apr 2026 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179668;
	bh=H3J9EZr3tvvevdBAgqVrRb4AziVG1y905B7abbKP/HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+3qCKwA0hQ54jmAI7omw55knguLR6cX010JRKDRMcNtrlGQ3CT3uJXcXf7qh3n9w
	 6QXdS6RqEH91dJYN3vrmMylJ+RK8308zzRoIZxv7durYNzXPLLOZMya6QGXqC9Soff
	 1QrsJn1MXWNN6vCVkGujarq1nWm66AClyPIo+zoZY16ncGWtVjf9nUtaII4AQW2Yfa
	 FXzucd1itI57Xg1vCA/hsnqVhcFQFCFnJw+ev8FvbjOjaW+drY/KQ+FGwW+wWPUUjA
	 FMej6obO34XfbJ0somonTlM/mmBOPUEpdJ7kQ3SUeI+XRzSjYwQECY2lSL98zo6aid
	 xRz/qt0JQcKcw==
Date: Thu, 2 Apr 2026 18:27:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Venkat <venkat88@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Message-ID: <ac8Xkty-lqrIbFsP@google.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ac2uvTXI1iknXwyV@google.com>
 <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
 <A33EEA7D-DB03-4FA9-A0A8-D10115FEF423@linux.ibm.com>
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
In-Reply-To: <A33EEA7D-DB03-4FA9-A0A8-D10115FEF423@linux.ibm.com>

On Thu, Apr 02, 2026 at 09:15:54PM +0530, Athira Rajeev wrote:
> If the addition of “-a” can cause regression ( like intel one if its not suppose to be run system wide ), 
> how about adding a case like this:
> - Look for "enable system wide with '-a’ “ in the error logs
> 	- If logs matches this message and if user is root, attempt with -a next.
>        - With “-a”, If the logs has "Operation not supported” , test can continue to next event.

Sounds good, you can check perf_event_paranoid as well as root.  Then
you don't need to check the result of "-a" for -EOPNOTSUP.

Thanks,
Namhyung


