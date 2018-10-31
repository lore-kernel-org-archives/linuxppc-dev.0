Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A47FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 09:43:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BD520685
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 09:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BD520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lNgq2dPJzF3Gn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 20:43:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lNdf0YfWzDsN0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 20:41:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42lNdd5BcTz9s3l;
 Wed, 31 Oct 2018 20:41:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
In-Reply-To: <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
 <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 20:41:39 +1100
Message-ID: <87lg6eihbg.fsf@concordia.ellerman.id.au>
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
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 10/23/2018 01:23 PM, Breno Leitao wrote:
>> Current core-pkey selftest fails if the test runs without privileges to
>> write into the core pattern file (/proc/sys/kernel/core_pattern). This
>> causes the test to fail and give the impression that the subsystem being
>> tested is broken, when, in fact, the test is being executed without the
>> proper privileges. This is the current error:
>> 
>> 	test: core_pkey
>> 	tags: git_version:v4.19-3-g9e3363be9bce-dirty
>> 	Error writing to core_pattern file: Permission denied
>> 	failure: core_pkey
>> 
>> This patch simply skips this test if it runs without the proper privileges,
>> avoiding this undesired failure.
>> 
>> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> index e23e2e199eb4..e07949120fc8 100644
>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>>  	FILE *f;
>> 
>>  	f = fopen(core_pattern_file, "w");
>> -	if (!f) {
>> -		perror("Error writing to core_pattern file");
>> -		return TEST_FAIL;
>> -	}
>> +	SKIP_IF(!f);
>> 
>>  	ret = fwrite(core_pattern, 1, len, f);
>>  	fclose(f);
>> -	if (ret != len) {
>> -		perror("Error writing to core_pattern file");
>> -		return TEST_FAIL;
>> -	}
>> +	SKIP_IF(ret != len);
>
> If we don't have proper privileges we should fail on the open, right?
> So wouldn't we still want to fail on the write if something goes
> wrong?

Yes you're right. If we don't have permission then the open should have
failed, and we skip then.

But if the open succeeded and the write fails then we don't know what's
going on and the test should fail.

cheers
