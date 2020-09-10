Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18434C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:42:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD9D20795
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TtYadyhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD9D20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bn9pB0xlVzDqcv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bn9ky6VR4zDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 17:39:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=TtYadyhT; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bn9ky1h0kz9sTN;
 Thu, 10 Sep 2020 17:39:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1599723578;
 bh=nKPtyqBT+cZzuIl7eAPaflm+WURPjkTyEz/nF4q7arA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TtYadyhT2SJrSAOl0AhRMAFcK6CaZ92+a8yreYgJt4cnL3hhdTSze26qDdsHw1lUM
 mAEw3GXMC52YYM3zl06NtAajfT06fEvLe0lWJ1/Jvno66P2Hws+Cg/K5wsJTAHfQB6
 +fX1bfLDoTkS04gIkKQyTROXav+vRp23BwhXsgn1ywDt79AL4uQ2LdKsu/p0Y9R3Jp
 ZoR5pp8dEpw4pkAkpJ+VPeTfXcte37LAmbxWupXX2q7lhl00dIEpW7TvmJekZbQQMm
 Y+jewt4dwbEYqUzIJFizX1D87McyOLDdDXz418G+qodP/vAXEoxfJNN8n8zHN+icW+
 3Cc2XoHmjUzUQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc: Warn about use of smt_snooze_delay
In-Reply-To: <159965716554.808686.4840855488904790852.b4-ty@ellerman.id.au>
References: <20200630015935.2675676-1-joel@jms.id.au>
 <159965716554.808686.4840855488904790852.b4-ty@ellerman.id.au>
Date: Thu, 10 Sep 2020 17:39:37 +1000
Message-ID: <874ko6rsg6.fsf@mpe.ellerman.id.au>
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 30 Jun 2020 11:29:35 +0930, Joel Stanley wrote:
>> It's not done anything for a long time. Save the percpu variable, and
>> emit a warning to remind users to not expect it to do anything.
>> 
>> Fixes: 3fa8cad82b94 ("powerpc/pseries/cpuidle: smt-snooze-delay cleanup.")
>> Cc: stable@vger.kernel.org # v3.14
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> --
>> v2:
>>  Use pr_warn instead of WARN
>>  Reword and print proccess name with pid in message
>>  Leave CPU_FTR_SMT test in
>>  Add Fixes line
>> 
>> [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc: Warn about use of smt_snooze_delay
>       https://git.kernel.org/powerpc/c/a02f6d42357acf6e5de6ffc728e6e77faf3ad217

I applied v3 actually.

cheers
