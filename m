Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACFC6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:18:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C7F20664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C7F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kw8n5TgyzF1RD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:18:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kw6l5cGvzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 02:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42kw6l2wYmz9s9G;
 Wed, 31 Oct 2018 02:16:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
In-Reply-To: <87efc8be37.fsf@morokweng.localdomain>
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
 <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
 <132d7e4f-153f-8ba4-95f2-f0d9c1a66f28@debian.org>
 <87efc8be37.fsf@morokweng.localdomain>
Date: Wed, 31 Oct 2018 02:16:45 +1100
Message-ID: <87r2g7ihwi.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Breno Leitao <leitao@debian.org> writes:
>
>> Hi Tyrel,
>>
>> On 10/23/2018 05:41 PM, Tyrel Datwyler wrote:
>>>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>>> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>>>>  	FILE *f;
>>>>
>>>>  	f = fopen(core_pattern_file, "w");
>>>> -	if (!f) {
>>>> -		perror("Error writing to core_pattern file");
>>>> -		return TEST_FAIL;
>>>> -	}
>>>> +	SKIP_IF(!f);
>>>>
>>>>  	ret = fwrite(core_pattern, 1, len, f);
>>>>  	fclose(f);
>>>> -	if (ret != len) {
>>>> -		perror("Error writing to core_pattern file");
>>>> -		return TEST_FAIL;
>>>> -	}
>>>> +	SKIP_IF(ret != len);
>>
>>> If we don't have proper privileges we should fail on the open, right?
>>> So wouldn't we still want to fail on the write if something goes
>>> wrong?
>>
>> That is a good point. Should the test fail or skip if it is not possible
>> to create the infrastructure to run the core test?
>>
>> Trying to find the answer in the current test sets, I find tests where
>> the self test skips if the test environment is not able to be set up, as
>> for example, when a memory allocation fails.
>>
>> File: tools/testing/selftests/powerpc/alignment/alignment_handler.c
>>
>>         ci1 = mmap(NULL, bufsize, PROT_WRITE, MAP_SHARED,
>>                    fd, bufsize);
>>         if ((ci0 == MAP_FAILED) || (ci1 == MAP_FAILED)) {
>>                 printf("\n");
>>                 perror("mmap failed");
>>                 SKIP_IF(1);
>>         }
>
> I think TEST_FAIL means the test was able to exercise the feature
> and found a problem with it. In this case, the test wasn't able to
> exercise the feature so it's not appropriate.
>
> Ideally, there should be a TEST_ERROR result for a case like this where
> an unexpected problem prevented the testcase from exercising the
> feature.
>
> If we're to use the an existing result then I vote for SKIP_IF.

Yeah I agree.

See for example some of the TM tests, which skip if TM is not available.
Or the alignment test which skips if it can't open /dev/fb0.

In this case it should print "you need to be root to run this" and then
skip.

cheers
