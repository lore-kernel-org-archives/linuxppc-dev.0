Return-Path: <linuxppc-dev+bounces-23234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69B1C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 23:36:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqffQ3qlDz2yft;
	Wed, 01 Jul 2026 09:35:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782862558;
	cv=none; b=nXDVuQ13zOfzldvOihfH0vqlhIGQVPsWWOHlbYRMHnMZwbaZdI05+KpXtiSBq+kvqVa0RdX1YSYQrn293ttBWrT+7HM2mrL7cHAjn/B5LHX1HsSAURwjyAjk03ZtkElztB4upgy2HubO/MPgLdR2Rn0VU4o8XvCJ4ufVUu6hwor4sSdmnh9PiXkM4Zmz1RlI8n3Z5yqo1YUcS5YVC035wForwPPyNDvd/KmqMl2k9PZHZwaf3Lw3UgAkE/Tors2VHJ+U5+Q7MQe2Zz2djpFGaACRrQOD+tZ1jjOIDC1pyCJ3x3IXVgLFDMEe/0YW3PG4anjuYoMNfIuJ5B7cUkC9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782862558; c=relaxed/relaxed;
	bh=MFc41oW3E5gWpFqi+soESlRPUg6TArO3xdhw95q3tX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PtAkSf0x0XHD7zNAjfcnC4R+EjpwtADZxaFodl5dv8s5V2IpKpBu/7+YdT1z2zZdGwP/0QpOMpVeMgCThSPdoX2ugztJAhY5qcVX9QsZ6Qu+eJQnbyIqYNPRDAvreu/JNNWToZx8cWCIah8TjwhJNFGY42ekeplZWz85UkaqLK2uwyTeD+A0+T6Qs2Z7ytZX3w+bsjv2KvN9LVBtVqLE/Ra5QbacoE9UUHNGi/Co3jxczsol+RC+qmqdkkM3Uj9/t+EoXwTK1WtW996QIATmjENlhAt4NjGxXACJ5NayicqH9gfZFMOpi+DM6xRHIiuLF7JganrH9kuxal64d1S47A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJwu58mr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJwu58mr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqffP4Sjnz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 09:35:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5851F417AC;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3751F00A3E;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862555;
	bh=MFc41oW3E5gWpFqi+soESlRPUg6TArO3xdhw95q3tX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jJwu58mrIksNG9xsAdkv90jce/v9ONWYtOdXi0uc0T5esBdgVRe5UEFCTW2RCb8gm
	 VZNwdWBOgSFzzPUtNmfLILWwiqqKaA5QIKTQn9kTkT05VYP8OciWQtYjblQn57cnWb
	 4nRl8T849jr1xWZUMhq7kHIUvHRL12vLv0erYJbWZfqg/LWWufM5ExCEzj6bLqf4Ec
	 13h4BpbWt0kju3xJWPhrhwpgKqR99tsc23yqfusQ34IS1I5mjAf8xG53dCouGjGsEi
	 FoftWomMOhC3NhKDmeLU9DFAsGLcqyVg57gvOZfqqNKY4OZ6+7+SxL7aBywaX/hzFo
	 sBP9cdXLzzydw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260518125041.39286-1-gautam@linux.ibm.com>
References: <20260518125041.39286-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm
 exit reasons
Message-Id: <178286255486.2863034.396333551089947298.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:54 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 18 May 2026 18:20:38 +0530, Gautam Menghani wrote:
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
> and H_VIRT so that exit reasons are displayed as string instead of
> vector numbers when using perf kvm stat.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



