Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF17C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 08:43:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863C82070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 08:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C82070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N8pb20QszDqKS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 19:43:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N8mp5kchzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 19:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44N8ml7070z9s47;
 Mon, 18 Mar 2019 19:41:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Biggers <ebiggers@kernel.org>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
In-Reply-To: <20190315043433.GC1671@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
 <875zsku5mk.fsf@dja-thinkpad.axtens.net>
 <20190315043433.GC1671@sol.localdomain>
Date: Mon, 18 Mar 2019 19:41:42 +1100
Message-ID: <87pnqo7ewp.fsf@concordia.ellerman.id.au>
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
Cc: leo.barbosa@canonical.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, nayna@linux.ibm.com,
 omosnacek@gmail.com, marcelo.cerri@canonical.com, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Eric Biggers <ebiggers@kernel.org> writes:
> On Fri, Mar 15, 2019 at 03:24:35PM +1100, Daniel Axtens wrote:
...
>> >> This leads to corruption of the IV, which leads to subsequent blocks
>> >> being corrupted.
>> >> 
>> >> This can be detected with libkcapi test suite, which is available at
>> >> https://github.com/smuellerDD/libkcapi
>> >
>> > Is this also detected by the kernel's crypto self-tests, and if not why not?
>> > What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?
>> 
>> It seems the self-tests do not catch it. To catch it, there has to be a
>> test where the blkcipher_walk creates a walk.nbytes such that
>> [(the number of AES blocks) mod 8] is either 2 or 3. This happens with
>> AF_ALG pretty frequently, but when I booted with self-tests it only hit
>> 1, 4, 5, 6 and 7 - it missed 0, 2 and 3.
>> 
>> I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
>> -next?
>
> The improvements I recently made to the self-tests are intended to catch exactly
> this sort of bug.  They were just merged for v5.1, so try the latest mainline.
> This almost certainly would be caught by EXTRA_TESTS (and if not I'd want to
> know), but it may be caught by the regular self-tests now too.

Enabling the crypto tests (CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n)
actually hides the bug for me.

By which I mean I can't trigger the bug via kcapi-enc-tests.sh, because
the VMX code is never called.

ie:
  # zgrep -e CRYPTO_MANAGER -e VMX /proc/config.gz
  CONFIG_CRYPTO_MANAGER=y
  CONFIG_CRYPTO_MANAGER2=y
  # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
  # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
  CONFIG_CRYPTO_DEV_VMX=y
  CONFIG_CRYPTO_DEV_VMX_ENCRYPT=y

  # echo "p:p8_aes_ctr_crypt p8_aes_ctr_crypt" > /sys/kernel/debug/tracing/kprobe_events
  # echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
  # ./kcapi-enc-test.sh
  ...
  Number of failures: 0
  # grep -c p8_aes_ctr_crypt  /sys/kernel/debug/tracing/trace
  0


I don't understand how the crypto core chooses which crypto_alg to use,
but I didn't expect enabling the tests to change it?

cheers
