Return-Path: <linuxppc-dev+bounces-23763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A89C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:05:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw6yf6DMvz2y7r;
	Wed, 08 Jul 2026 16:05:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783490730;
	cv=none; b=eJ6hoOsK0E8BfrZFejcw/zRI/83aFDrnGXGG4lK211qNPlFnJNsBTY2cJiTt3d0lUzDtq1NgpfcX79aclX5Y5HoDjOcxjU00tLo88tKsGpdccfJ2w2AUg1Cqcq4Y9IR6zRObkmvX+wppYYPIReZg2rvfwQGV58EtpPFCKI3+xbRgJ1jdB3KR4d09zjAxwNBgKpcy5pSnwZCHvSwro9rObUARqCzEiH5M3bvyqP4VEGqUN7TtXSfD+xPPwMqIar3WGDiGsmLFFkYWoWzd0eVfBybeUFWfS/eIBcZWZj0LFtpbEUdzPqNYBvCEVkgJ4eIXskZqwHdBsj0qZIXTBLV/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783490730; c=relaxed/relaxed;
	bh=UNUAL7h75C0GFWhLYoN6/t//Ndh4nenCF1NhVs7dVZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4dguZhPF5j1kkWf66gM+j+sYB7PG9QxH3zSXbW0sMZxA22w9wWTxcpLU8JaeN7XFrFRexwIyf87mYA3PdqWvHuzt1j8D1c5pwzXQ4sAvC2rIvl21bF6it/Jn2JmAILuQUnVw619dBm0+dyzmxjw/xPPbQ+ua4Pn8/mlx6Gwb7bq87mOv06n7WHF3g77KSdaTCWm8q6WOULS0PmXVxM61bNlJA1OjsEbgZEIlXwElXBFIbKbneEjrLvpIQ0k2VwyO2kOjFxQIFWYuNCQ55NTofHZiLmRzduc+nJrzi77YxW+wDTuPZXrVnYIwUvCSk6PbUZSq941umdoCdpAMDPVDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjSrKmw7; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjSrKmw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw6yd6VbCz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 16:05:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D861D6001D;
	Wed,  8 Jul 2026 06:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01461F000E9;
	Wed,  8 Jul 2026 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783490726;
	bh=UNUAL7h75C0GFWhLYoN6/t//Ndh4nenCF1NhVs7dVZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjSrKmw7UHPYTStSUjitFqxzQMjUF0T9ULD+lOLjGAsG49g5ujy85Vxjppg6IbVzO
	 s9j08fA/1oru76AZ0i4YFOHhPAe+AzzR9ZOPqox3Vz7LGvO+HHdZtbVYeMeUIHppal
	 Q8o0DUXQGB4QdxvpLZDHXaTcDFPGx9J37Cud0fqWCrJLVhuQSH/CJZLLUyaCIfL7WK
	 Hh5IRm5jSZv1AzVckuiUlPvhPquuPMUnh+BrjUva9x7UVbL6a89ijx9TCVt6YeQLtg
	 cwr2BL1ijUb6C0JCyYhsMWjNjpMyHj/F46j8iUhmo92Qf7CnUrl6U6ewqTaL5tf7Fv
	 bnkmzaLHF9oFw==
Date: Tue, 7 Jul 2026 23:05:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <ak3opN58uZ1UJzfs@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
 <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
 <akhM9-d-tNjZzb-A@google.com>
 <845be1b6-8e56-46fa-a258-5b0033fac474@linux.ibm.com>
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
In-Reply-To: <845be1b6-8e56-46fa-a258-5b0033fac474@linux.ibm.com>

On Tue, Jul 07, 2026 at 07:36:06PM +0530, Tanushree Shah wrote:
> Hi Namhyung,
> The only change I had planned for v2 was the fix for the pre-existing issue,
> which has now already been merged separately upstream.
> 
> https://github.com/torvalds/linux/commit/2857a5dca750ea989c6fb70b4c14e801e4b7b4ad
> 
> Please let me know if there is any additional change you would like me to
> include in v2.

Oh, nevermind then.  I'll process this.

Thanks,
Namhyung

