Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B7DC10DCE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:36:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5AF20714
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="R/8QvpMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5AF20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mhNp4G81zDr0t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 17:36:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mhLd2wfPzDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 17:34:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=R/8QvpMM; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48mhLc62Rfz9sNg;
 Tue, 24 Mar 2020 17:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585031689;
 bh=5Hd5RUwA/dvRMS4WLUeTFYytdcYhONFN7COAZjGe2ZI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=R/8QvpMMOGOvB2SBheePKyqG/9FNKIhpvV3+NXp9oPbPnr+y+Y9FqYq/qftTI81jX
 TTJJBApqrx7RsVt31sowNMafRKvD2AdB1McUZOqNkhjOrbUDKQ4uFGYqGY+3NNmW+x
 k3eTAln+cKrDkMswlglr1RXo3ZPV/4XxBtcWZk29BLubGPvsLjOC2YdR8r3L7kBnU7
 oEWw0zshCBZBDWXfTfThCWaOdaJEN3hX1YetFcGXhaw2RJaAFWMo9XQUwJUVJbMvNh
 6m6AF1IIRf+LiR/B/PGMPJmkjY9mKTdM574qdqMbpLSCmHceo+yklU7l2SgL/O7khS
 m8Yv54tJrC0tg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Pratik Rajesh Sampat <psampat@linux.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in
 powernv_cpufreq_work_fn
In-Reply-To: <1921198.IfoiWgUDIW@kreacher>
References: <20200316135743.57735-1-psampat@linux.ibm.com>
 <1921198.IfoiWgUDIW@kreacher>
Date: Tue, 24 Mar 2020 17:34:56 +1100
Message-ID: <87h7yexnu7.fsf@mpe.ellerman.id.au>
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
Cc: ego@linux.vnet.ibm.com, pratik.r.sampat@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> On Monday, March 16, 2020 2:57:43 PM CET Pratik Rajesh Sampat wrote:
>> The patch avoids allocating cpufreq_policy on stack hence fixing frame
>> size overflow in 'powernv_cpufreq_work_fn'
>> 
>> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>
> Any objections or concerns here?
>
> If not, I'll queue it up.

I have it in my testing branch, but if you pick it up I can drop it.

cheers

>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 56f4bc0d209e..20ee0661555a 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>  void powernv_cpufreq_work_fn(struct work_struct *work)
>>  {
>>  	struct chip *chip = container_of(work, struct chip, throttle);
>> +	struct cpufreq_policy *policy;
>>  	unsigned int cpu;
>>  	cpumask_t mask;
>>  
>> @@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
>>  	chip->restore = false;
>>  	for_each_cpu(cpu, &mask) {
>>  		int index;
>> -		struct cpufreq_policy policy;
>>  
>> -		cpufreq_get_policy(&policy, cpu);
>> -		index = cpufreq_table_find_index_c(&policy, policy.cur);
>> -		powernv_cpufreq_target_index(&policy, index);
>> -		cpumask_andnot(&mask, &mask, policy.cpus);
>> +		policy = cpufreq_cpu_get(cpu);
>> +		if (!policy)
>> +			continue;
>> +		index = cpufreq_table_find_index_c(policy, policy->cur);
>> +		powernv_cpufreq_target_index(policy, index);
>> +		cpumask_andnot(&mask, &mask, policy->cpus);
>> +		cpufreq_cpu_put(policy);
>>  	}
>>  out:
>>  	put_online_cpus();
>> 
