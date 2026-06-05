Return-Path: <linuxppc-dev+bounces-22098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C24ECD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:21:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWqYR5xZkz3bps;
	Fri, 05 Jun 2026 15:21:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.242.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780636655;
	cv=none; b=WhtB8GFDIq7ydn5o+oxsdV7hwNAOGQFaosCW+cTIu+giujzIh840qcctubwTikluCD+XZUG8YL53h54gejzMrraPH5lWFMFsxwopM65LeftwBtr5HxSDQCsuxl8UFEdkgnLlIhxsG5TkhBlAUbSiWS2rA+alumVIeT2mWoWCGzKvY0DZgMiWDmpaQLvhcJUjo51/Xaxenhp7KxeuxTcJTu4Lp0OlgFYrMVUZDKiUANIXpkV0eMst6b9OUdeBwBGqL8Ee9xd8Coq8QOaz5mzAQu3H2Slvmq2n/REHfMEv5+R/D6AAteJbQ129clGHkCB/sjtOzqskpHESnP9cIzvDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780636655; c=relaxed/relaxed;
	bh=jsw2h0uzotEOlKXsB9+F8JxKlHynat2M6YHI/UsIRuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4x2bEvQ8Mi14HytPfYwTlrp81N3SyEIGURPnL9Ri5sY4Twe9UIXm3T72gVU6JZeR4Zo569tsT+D2QOlYWwr/+iM4nVBAUIv62ibRAdvB0oH3ahV3MopBqvkzRiV9u6xQLMmKJkAzjlAbEutkmafPSpoRoOOX6QR++P0crlfKxSe8/TasFIiQJH8MN0ljFcvdGQznyapT7HiAaOp3VulrROwY+pr9a7HmaVhAF0xuwdZcoihfeL29t/vQ4w5PNEiW84nHX2wvxn6sQ4F2945VejVhI/++/wD4k+EyIML/+nMawkacHj5QQFX5BnC17CTGHsAiVL9Px3ELZV25iqwdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; dkim=pass (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=lA0rkXib; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=F0KvoLUs; dkim-atps=neutral; spf=pass (client-ip=203.29.242.92; helo=sphereful.davidgow.net; envelope-from=david@davidgow.net; receiver=lists.ozlabs.org) smtp.mailfrom=davidgow.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=lA0rkXib;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=F0KvoLUs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=davidgow.net (client-ip=203.29.242.92; helo=sphereful.davidgow.net; envelope-from=david@davidgow.net; receiver=lists.ozlabs.org)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWqSY4Mmxz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:17:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636192;
	bh=rdJd7sfEa7cyvb8ZIBQzpXJdypnFyAzu3Ks6iqmSBs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lA0rkXib/kDl3eMcUq8gGhxvUnLRX20voVmUG4zKgoc4sJwe5xjKkZ/Dqi3zCaNfE
	 1XVnPE0dGLgLqzkidOMz43feumKBCj/vx6D8JEO/wxziiB0zSUiKGp+7HsyA28NudW
	 SCQYU5ZlFU0JvZZQUpuPk1/N1/uEAjGNxKAxNDErhMCigFh7wq+YSJt7caj5nNfZ7K
	 B2KAQ0ywBwcIGKkiHcuR60a4n2YKkT42/Tr81J+3zUaol7CKLMgqNtrVLtBKwkcLfI
	 Mw8zAWIKZZH2mooOA+xWbtKtogLuVJAHBpAVuNiOI1w+cTOsjp+jEsfWE0zyBBXBm8
	 uo7HNjr+2lERUbo/2wM+NvUNSZi8CXDHC+wLwUkZeTluL9BGVuyJuqeYj2hmrroXX1
	 gvjJIxeMaONNnmRulIME7sAUgZEgvmFTn+sB2N+g2dM2ODEXymW/v0rd4PGocfnl4+
	 uKSeDUIrOWO17rczaAxKizd9A1otaW+sXZifK+y3qa5TFl/cOY+FOtADUyzACaw/Yo
	 xpUWc0NtD0xvjc6qTkc+0gad+o5QrYVIJgr4Ptgo/HyYQZEdcJelX/O3XNHpG4FTJt
	 3VMp2Kchuue5UAxQ4THXBd+KI7SSdU2K+dDTjK+VREM5r5kqCSgHqlzOEH9lravo4a
	 ZG2qRQbivUsCN0Mfz6/fCA2U=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 18D5A1E9203; Fri,  5 Jun 2026 13:09:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636190;
	bh=rdJd7sfEa7cyvb8ZIBQzpXJdypnFyAzu3Ks6iqmSBs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F0KvoLUsuoPBb0L1vpN0tiPTEw+DVFUdMPCFYi5wN+BhK/DmrkGb+zMimxDxJshoY
	 XLiwccj56goerSUoYBjDdfmtXGdz05naM9Wn+ypqTv0gdawiy1l8ONdt2jAc9kzUFP
	 q/UeU7bzSxoxHSs6gqB42RKjleOovK0k8ZX3N9/PPBKETjkuXvvDCsfMOoTbHNBkJ+
	 fkPSECpKYUfGoE2epF88S7mZshILQJZ5DEjn+xizMCm20wy2cmQuEjHiHsylFUbZa0
	 G7sZkmsqz1DI4zZ2gAcPWAgm5IERY52BwBhZ6CGQvvfbZvYnhzbZGJbxlSFUxZtZjm
	 WlMsJqnXeVlWp/msuSrYYObtUdjVETGzMUoxhIsswGb0X6aRT3w3hO5cQwcrh6pMv4
	 9cF8L9tBk5XkGWfzyE03gC2VkG3SMQuN3MvO08N2gPJz4Ijxc+kdGDhneST/jvszI9
	 lYB8AP2i+C5U1TK6Sx6QfsqYoLko+TjIiw4ACNbMkyqk6NO8JpeicFfVAUHzB2W9RC
	 Kj77y2yk0jVbaJPNDnGoJcCZ8IaIJS206obxeUejkUYv4QsrWl7StXyXNoRNu+yC5C
	 3azVemgMNHksIZCv+mOINYSOlRiNJcoL/PQmQ6vgpo/oKEifFBi2aVWKB/N0WCoVJA
	 lR8kWGVlH7x9Ns2oYdJj4vDY=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id ED4B61E9202;
	Fri,  5 Jun 2026 13:09:49 +0800 (AWST)
Message-ID: <758228d7-b555-447a-86f7-3c437ce92460@davidgow.net>
Date: Fri, 5 Jun 2026 13:09:47 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kunit: Add ability to skip entire test suites
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
 <20260604162805.556135-2-vaibhav@linux.ibm.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260604162805.556135-2-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2026 à 12:28 AM, Vaibhav Jain a écrit :
> Currently, KUnit provides mechanisms to skip individual test cases, but
> there is no way to skip an entire test suite based on runtime conditions
> checked during suite initialization. This limitation forces test suites
> to either fail or skip tests individually when certain prerequisites are
> not available.
> 
> To address this limitation, the patch adds a 'status' field to struct
> kunit_suite that allows suite_init callbacks to mark the entire suite as
> KUNIT_SKIPPED. When a suite is marked as skipped, all test cases within
> that suite are bypassed without execution.
> 
> The patch proposes changes to kunit_suite_has_succeeded() to check suite
> status before evaluating individual test case results. Also
> kunit_run_tests() is updated to skip suite execution if 'kunit_suite.status'
> is set to KUNIT_SKIPPED, thats either set before suite_init or by the
> suite_init callback itself.
> 
> This enables test suites to perform runtime capability checks in their
> 'suite_init' callback and gracefully skip all tests when prerequisites are
> not met, rather than reporting failures or requiring each test case to
> perform redundant checks.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

Thanks — this is great! There are a few cases it's not handling
properly, though, particularly with respect to the debugfs support.

I think we need to:
- Reset suite->status to KUNIT_SUCCESS in kunit_init_suite(), so that a
suite which is re-run via debugfs isn't automatically skipped again.
- Fix the result handling in debugfs to handle skipped suites.
- (Optional) Maybe we could get rid of kunit_suite::suite_init_err now
that there's a specific status value. That'd have to be done carefully
to preserve all of the semantics, though.

Here's a quick (and slightly hacky) patch to fix the first couple of issues:
---
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9c326f1837bd..23d34bfdba95 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -58,6 +58,22 @@ static void debugfs_print_result(struct seq_file
*seq, struct string_stream *log
 	spin_unlock(&log->lock);
 }

+/* Print the result line for a suite. */
+static void debugfs_print_ok_not_ok(struct seq_file *seq,
+				    enum kunit_status status,
+				    size_t test_number,
+				    const char *description,
+				    const char *directive)
+{
+	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP "
: "";
+	const char *directive_body = (status == KUNIT_SKIPPED) ? directive : "";
+
+	seq_printf(seq, "%s %zd %s%s%s\n",
+		   kunit_status_to_ok_not_ok(status),
+		   test_number, description, directive_header,
+		   directive_body);
+}
+
 /*
  * /sys/kernel/debug/kunit/<testsuite>/results shows all results for
testsuite.
  */
@@ -77,17 +93,17 @@ static int debugfs_print_results(struct seq_file
*seq, void *v)
 	seq_puts(seq, "1..1\n");

 	/* Print suite header because it is not stored in the test logs. */
-	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
-	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
-	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n",
kunit_suite_num_test_cases(suite));
-
-	kunit_suite_for_each_test_case(suite, test_case)
-		debugfs_print_result(seq, test_case->log);
+	if (suite->status != KUNIT_SKIPPED) {
+		seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
+		seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
+		seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n",
kunit_suite_num_test_cases(suite));

+		kunit_suite_for_each_test_case(suite, test_case)
+			debugfs_print_result(seq, test_case->log);
+	}
 	debugfs_print_result(seq, suite->log);

-	seq_printf(seq, "%s %d %s\n",
-		   kunit_status_to_ok_not_ok(success), 1, suite->name);
+	debugfs_print_ok_not_ok(seq, success, 1, suite->name,
suite->status_comment);
 	return 0;
 }

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c0ae45a22b2c..2ff145796450 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -798,9 +798,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 	/* Taint the kernel so we know we've run tests. */
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);

-	if (suite->status == KUNIT_SKIPPED)
-		goto suite_end;
-
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
@@ -836,6 +833,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
 	suite->suite_init_err = 0;
+	suite->status = KUNIT_SUCCESS;

 	if (suite->log)
 		string_stream_clear(suite->log);
---


>  include/kunit/test.h |  1 +
>  lib/kunit/test.c     | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index ce0573e196ce..395221d623f7 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -285,6 +285,7 @@ struct kunit_suite {
>  	struct string_stream *log;
>  	int suite_init_err;
>  	bool is_init;
> +	enum kunit_status status;
>  };
>  
>  /* Stores an array of suites, end points one past the end */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 99773e000e1b..989acc770265 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -214,6 +214,9 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
>  	const struct kunit_case *test_case;
>  	enum kunit_status status = KUNIT_SKIPPED;
>  
> +	if (suite->status == KUNIT_SKIPPED)
> +		return KUNIT_SKIPPED;
> +
>  	if (suite->suite_init_err)
>  		return KUNIT_FAILURE;
>  
> @@ -795,12 +798,20 @@ int kunit_run_tests(struct kunit_suite *suite)
>  	/* Taint the kernel so we know we've run tests. */
>  	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
>  
> +	if (suite->status == KUNIT_SKIPPED)
> +		goto suite_end;
> +

Do we want this? If a test is run more than once, we probably want to
re-run suite_init so that we can tell if we should still skip it.

While I don't think it's likely that a test which was previously skipped
will suddenly become available, it's not impossible with, e.g., CPU hotplug.

>  	if (suite->suite_init) {
>  		suite->suite_init_err = suite->suite_init(suite);
>  		if (suite->suite_init_err) {
> +			suite->status = KUNIT_FAILURE;
>  			kunit_err(suite, KUNIT_SUBTEST_INDENT
>  				  "# failed to initialize (%d)", suite->suite_init_err);
>  			goto suite_end;
> +
> +		} else if (suite->status == KUNIT_SKIPPED) {
> +			/* Skip this kunit suite */
> +			goto suite_end;
>  		}
>  	}
>  

Cheers,
-- David

