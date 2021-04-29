Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3604AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 09:57:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338CB61352
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338CB61352
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FW9rq2qw4z301J
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 19:56:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Fv7Y9NWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Fv7Y9NWG; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FW9rM2Qkjz2xfT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 19:56:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FW9rB5yF0z9sXM;
 Thu, 29 Apr 2021 19:56:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1619690188;
 bh=6PPQKIc7lD5HrR4bsQtHG16u/E9ccQvQAEcyj1Ns58Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Fv7Y9NWGEezzDYtM0nzzds6GD8Lh9f6ttsNHfLyJ2LXuYcS6CU8LCALX7oQT415jC
 sdq0teQrSuPDfEl1r1+N5y1bHBMzwhDQgXNYvDQddh+OPoPaq61/hIz2LNg0rOEjk0
 gHUFQNiEqBA3Zl+YXTAdY6lMnmH16DlusPvHq0iS4otS+9+QABzfqgyEvQdoEgBlXK
 IvIFXecw3o1WPxl+/2t+QCGQVb1ifi1oTruuyTM0KU3pir2e95oJ6RKE3+ROn6fCVG
 5QcDBMRIwJ3POG4yuZmvwiEmm19Fk8omu8oB8BKhLl9veQ9R6L3JvRYfaSlzBoER0p
 PVXzWlFD6zypQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle/pseries: Fixup CEDE0 latency only for
 POWER10 onwards
In-Reply-To: <1619673517-10853-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1619673517-10853-1-git-send-email-ego@linux.vnet.ibm.com>
Date: Thu, 29 Apr 2021 19:56:25 +1000
Message-ID: <87r1it9zxy.fsf@mpe.ellerman.id.au>
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 joedecke@de.ibm.com, Michal Suchanek <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> of the Extended CEDE states advertised by the platform
>
> On POWER9 LPARs, the firmwares advertise a very low value of 2us for
> CEDE1 exit latency on a Dedicated LPAR. The latency advertized by the
> PHYP hypervisor corresponds to the latency required to wakeup from the
> underlying hardware idle state. However the wakeup latency from the
> LPAR perspective should include
>
> 1. The time taken to transition the CPU from the Hypervisor into the
>    LPAR post wakeup from platform idle state
>
> 2. Time taken to send the IPI from the source CPU (waker) to the idle
>    target CPU (wakee).
>
> 1. can be measured via timer idle test, where we queue a timer, say
> for 1ms, and enter the CEDE state. When the timer fires, in the timer
> handler we compute how much extra timer over the expected 1ms have we
> consumed. On a a POWER9 LPAR the numbers are
>
> CEDE latency measured using a timer (numbers in ns)
> N       Min      Median   Avg       90%ile  99%ile    Max    Stddev
> 400     2601     5677     5668.74    5917    6413     9299   455.01
>
> 1. and 2. combined can be determined by an IPI latency test where we
> send an IPI to an idle CPU and in the handler compute the time
> difference between when the IPI was sent and when the handler ran. We
> see the following numbers on POWER9 LPAR.
>
> CEDE latency measured using an IPI (numbers in ns)
> N       Min      Median   Avg       90%ile  99%ile    Max    Stddev
> 400     711      7564     7369.43   8559    9514      9698   1200.01
>
> Suppose, we consider the 99th percentile latency value measured using
> the IPI to be the wakeup latency, the value would be 9.5us This is in
> the ballpark of the default value of 10us.
>
> Hence, use the exit latency of CEDE(0) based on the latency values
> advertized by platform only from POWER10 onwards. The values
                                           ^^^^^^^
> advertized on POWER10 platforms is more realistic and informed by the
> latency measurements. For earlier platforms stick to the default value
> of 10us.

...

> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index a2b5c6f..7207467 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -419,7 +419,8 @@ static int pseries_idle_probe(void)
>  			cpuidle_state_table = shared_states;
>  			max_idle_state = ARRAY_SIZE(shared_states);
>  		} else {
> -			fixup_cede0_latency();
> +			if (pvr_version_is(PVR_POWER10))
> +				fixup_cede0_latency();

A PVR check like that tests for *only* Power10, not Power10 and onwards
as you say in the change log.

The other question is what should happen on a Power10 LPAR that's
running in Power9 compat mode. I assume in that case we *do* want to use
the firmware provided values, because they're tied to the underlying
CPU, not the compat mode?

In which case a check for !PVR_POWER9 would seem to achieve what we
want?

cheers
