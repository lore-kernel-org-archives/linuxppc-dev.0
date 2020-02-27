Return-Path: <SRS0=jCWG=4P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE49C4BA24
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 01:33:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E351324670
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 01:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="O1buNsIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E351324670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48SZtT4dQQzDqbY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:33:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48SZrJ4fbkzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2020 12:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=O1buNsIL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48SZrJ1cLGz9sR4;
 Thu, 27 Feb 2020 12:31:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582767072;
 bh=4iPApqRrhTbSdch1ve3p4lLXGqBpul/c3NudAAMMyc4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=O1buNsIL5uvpzDvA4YOoPpM1WTbup7v7RKTjE0zLcmZjHIGu/1onXxA72f1jqgR0R
 wRxA0o1HR00wAIN7DVOvqiXg2gQHqAore1rgKLUdSyy/yjD8srOLbyZh9+ZtHxmEwh
 2keM1VEDl+XBTuS/4o4CDfT1rZwgrULXjMxZWNFzTE4QFJzpjtb+4zyUwAyJ7fo8wF
 spvl3wGWBpjvHBHey3znKoljO7jQW+od2j8X4qwDJydKlKM416HUfw6x8LHva00lT3
 Ez7dW0oF8rr+BZnuU0P7Yk2uzUpw4zC2wFFw5azX5P1ErzOe25svCKCcnG5KUuaZ17
 ksC0XESaFCxsg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <ajd@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] cpufreq/powernv: Fix use-after-free
In-Reply-To: <33e1d358-caa4-ddbc-895e-4c7a6c282e91@linux.ibm.com>
References: <20200206062622.28235-1-oohall@gmail.com>
 <33e1d358-caa4-ddbc-895e-4c7a6c282e91@linux.ibm.com>
Date: Thu, 27 Feb 2020 12:31:11 +1100
Message-ID: <871rqg3jfk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Donnellan <ajd@linux.ibm.com> writes:
> On 6/2/20 5:26 pm, Oliver O'Halloran wrote:
>> The cpufreq driver has a use-after-free that we can hit if:
>> 
>> a) There's an OCC message pending when the notifier is registered, and
>> b) The cpufreq driver fails to register with the core.
>> 
>> When a) occurs the notifier schedules a workqueue item to handle the
>> message. The backing work_struct is located on chips[].throttle and when b)
>> happens we clean up by freeing the array. Once we get to the (now free)
>> queued item and the kernel crashes.
>> 
>> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
>> Fixes: c5e29ea ("cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}")
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
> This sounds like it needs to go to stable.

I tagged it for stable when applying.

cheers
