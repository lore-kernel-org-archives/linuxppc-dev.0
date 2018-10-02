Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2ABC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:18:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4D420666
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4D420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ph8Y2n66zF3HN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ph224T2KzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:12:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Ph1y36Bmz9t15;
 Wed,  3 Oct 2018 00:12:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuah@kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
 yamada.masahiro@socionext.com, michal.lkml@markovi.net, bamv2005@gmail.com,
 brgl@bgdev.pl, pbonzini@redhat.com, akpm@linux-foundation.org,
 rppt@linux.vnet.ibm.com, aarcange@redhat.com
Subject: Re: [PATCH v6] selftests: add headers_install to lib.mk
In-Reply-To: <4473d2b6-a760-1a48-68e7-9f90023b57b5@kernel.org>
References: <20180809080402.24469-1-anders.roxell@linaro.org>
 <20180904104721.27535-1-anders.roxell@linaro.org>
 <87y3bmte9l.fsf@concordia.ellerman.id.au>
 <4473d2b6-a760-1a48-68e7-9f90023b57b5@kernel.org>
Date: Wed, 03 Oct 2018 00:12:51 +1000
Message-ID: <8736tol9ng.fsf@concordia.ellerman.id.au>
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
Cc: linux-kbuild@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shuah Khan <shuah@kernel.org> writes:
> On 09/27/2018 10:52 PM, Michael Ellerman wrote:
>> [ + linuxppc-dev ]
>> 
>> Anders Roxell <anders.roxell@linaro.org> writes:
>>> If the kernel headers aren't installed we can't build all the tests.
>>> Add a new make target rule 'khdr' in the file lib.mk to generate the
>>> kernel headers and that gets include for every test-dir Makefile that
>>> includes lib.mk If the testdir in turn have its own sub-dirs the
>>> top_srcdir needs to be set to the linux-rootdir to be able to generate
>>> the kernel headers.
>>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
>>> ---
>>>
>>> I sent this (v5) a month ago and wondered if it got lost. Resending
>>> unchanged.
>>>
>>> Cheers,
>>> Anders
>>>
>>>  Makefile                                           | 14 +-------------
>>>  scripts/subarch.include                            | 13 +++++++++++++
>>>  tools/testing/selftests/android/Makefile           |  2 +-
>>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>>>  tools/testing/selftests/net/Makefile               |  1 +
>>>  .../selftests/networking/timestamping/Makefile     |  1 +
>>>  tools/testing/selftests/vm/Makefile                |  4 ----
>>>  11 files changed, 36 insertions(+), 28 deletions(-)
>>>  create mode 100644 scripts/subarch.include
>> 
>> This broke all the powerpc selftests :(
>
> Sorry for thr breakage.
>
>> Why did it go in at rc5?
>
> This patch has been in linux-next for a sometime before I decided to send this.
> My original intent was to send this for rc2, and my schedule was messed up with
> traveling. Since I didn't hear any issues from linux-next soaking, I made a call
> on sending this in for rc5.

OK. And I didn't notice the breakage in linux-next because _I_ was
travelling :)

> On second thought I should have waited until 4.20. Sorry about that.

Yeah that would have been better, no worries.

cheers
