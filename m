Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B936C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 15:24:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1730222C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 15:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1730222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440gDP6Hj6zDqVB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 02:24:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440g9r6cgyzDqTb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 02:22:24 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03422C04D283;
 Thu, 14 Feb 2019 15:22:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BFF35D6B6;
 Thu, 14 Feb 2019 15:22:19 +0000 (UTC)
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Davidlohr Bueso <dave@stgolabs.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
 <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
 <20190214132352.wm26r5g632swp34n@linux-r8p5>
From: Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <9860a0c2-1f24-a00f-fdea-89e55a07c571@redhat.com>
Date: Thu, 14 Feb 2019 10:22:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214132352.wm26r5g632swp34n@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 14 Feb 2019 15:22:22 +0000 (UTC)
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 the arch/x86 maintainers <x86@kernel.org>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02/14/2019 08:23 AM, Davidlohr Bueso wrote:
> On Fri, 08 Feb 2019, Waiman Long wrote:
>> I am planning to run more performance test and post the data sometimes
>> next week. Davidlohr is also going to run some of his rwsem performance
>> test on this patchset.
>
> So I ran this series on a 40-core IB 2 socket with various worklods in
> mmtests. Below are some of the interesting ones; full numbers and curves
> at https://linux-scalability.org/rwsem-reader-spinner/
>
> All workloads are with increasing number of threads.
>
> -- pagefault timings: pft is an artificial pf benchmark (thus reader
> stress).
> metric is faults/cpu and faults/sec
>                                       v5.0-rc6                 v5.0-rc6
>                                                                    dirty
> Hmean     faults/cpu-1    624224.9815 (   0.00%)   618847.5201 *  -0.86%*
> Hmean     faults/cpu-4    539550.3509 (   0.00%)   547407.5738 *   1.46%*
> Hmean     faults/cpu-7    401470.3461 (   0.00%)   381157.9830 *  -5.06%*
> Hmean     faults/cpu-12   267617.0353 (   0.00%)   271098.5441 *   1.30%*
> Hmean     faults/cpu-21   176194.4641 (   0.00%)   175151.3256 *  -0.59%*
> Hmean     faults/cpu-30   119927.3862 (   0.00%)   120610.1348 *   0.57%*
> Hmean     faults/cpu-40    91203.6820 (   0.00%)    91832.7489 *   0.69%*
> Hmean     faults/sec-1    623292.3467 (   0.00%)   617992.0795 *  -0.85%*
> Hmean     faults/sec-4   2113364.6898 (   0.00%)  2140254.8238 *   1.27%*
> Hmean     faults/sec-7   2557378.4385 (   0.00%)  2450945.7060 *  -4.16%*
> Hmean     faults/sec-12  2696509.8975 (   0.00%)  2747968.9819 *   1.91%*
> Hmean     faults/sec-21  2902892.5639 (   0.00%)  2905923.3881 *   0.10%*
> Hmean     faults/sec-30  2956696.5793 (   0.00%)  2990583.5147 *   1.15%*
> Hmean     faults/sec-40  3422806.4806 (   0.00%)  3352970.3082 *  -2.04%*
> Stddev    faults/cpu-1      2949.5159 (   0.00%)     2802.2712 (   4.99%)
> Stddev    faults/cpu-4     24165.9454 (   0.00%)    15841.1232 (  34.45%)
> Stddev    faults/cpu-7     20914.8351 (   0.00%)    22744.3294 (  -8.75%)
> Stddev    faults/cpu-12    11274.3490 (   0.00%)    14733.3152 ( -30.68%)
> Stddev    faults/cpu-21     2500.1950 (   0.00%)     2200.9518 (  11.97%)
> Stddev    faults/cpu-30     1599.5346 (   0.00%)     1414.0339 (  11.60%)
> Stddev    faults/cpu-40     1473.0181 (   0.00%)     3004.1209 (-103.94%)
> Stddev    faults/sec-1      2655.2581 (   0.00%)     2405.1625 (   9.42%)
> Stddev    faults/sec-4     84042.7234 (   0.00%)    57996.7158 (  30.99%)
> Stddev    faults/sec-7    123656.7901 (   0.00%)   135591.1087 (  -9.65%)
> Stddev    faults/sec-12    97135.6091 (   0.00%)   127054.4926 ( -30.80%)
> Stddev    faults/sec-21    69564.6264 (   0.00%)    65922.6381 (   5.24%)
> Stddev    faults/sec-30    51524.4027 (   0.00%)    56109.4159 (  -8.90%)
> Stddev    faults/sec-40   101927.5280 (   0.00%)   160117.0093 ( -57.09%)
>
> With the exception of the hicup at 7 threads, things are pretty much in
> the noise region for both metrics.
>
> -- git checkout
>
> First metric is total runtime for runs with incremental threads.
>
>           v5.0-rc6    v5.0-rc6
>                          dirty
> User         218.95      219.07
> System       149.29      146.82
> Elapsed     1574.10     1427.08
>
> In this case there's a non trivial improvement (11%) in overall
> elapsed time.
>
> -- reaim (which is always succeptible to rwsem changes for both
> mmap_sem and
> i_mmap)
>                                     v5.0-rc6               v5.0-rc6
>                                                                dirty
> Hmean     compute-1         6674.01 (   0.00%)     6544.28 *  -1.94%*
> Hmean     compute-21       85294.91 (   0.00%)    85524.20 *   0.27%*
> Hmean     compute-41      149674.70 (   0.00%)   149494.58 *  -0.12%*
> Hmean     compute-61      177721.15 (   0.00%)   170507.38 *  -4.06%*
> Hmean     compute-81      181531.07 (   0.00%)   180463.24 *  -0.59%*
> Hmean     compute-101     189024.09 (   0.00%)   187288.86 *  -0.92%*
> Hmean     compute-121     200673.24 (   0.00%)   195327.65 *  -2.66%*
> Hmean     compute-141     213082.29 (   0.00%)   211290.80 *  -0.84%*
> Hmean     compute-161     207764.06 (   0.00%)   204626.68 *  -1.51%*
>
> The 'compute' workload overall takes a small hit.
>
> Hmean     new_dbase-1         60.48 (   0.00%)       60.63 *   0.25%*
> Hmean     new_dbase-21      6590.49 (   0.00%)     6671.81 *   1.23%*
> Hmean     new_dbase-41     14202.91 (   0.00%)    14470.59 *   1.88%*
> Hmean     new_dbase-61     21207.24 (   0.00%)    21067.40 *  -0.66%*
> Hmean     new_dbase-81     25542.40 (   0.00%)    25542.40 *   0.00%*
> Hmean     new_dbase-101    30165.28 (   0.00%)    30046.21 *  -0.39%*
> Hmean     new_dbase-121    33638.33 (   0.00%)    33219.90 *  -1.24%*
> Hmean     new_dbase-141    36723.70 (   0.00%)    37504.52 *   2.13%*
> Hmean     new_dbase-161    42242.51 (   0.00%)    42117.34 *  -0.30%*
> Hmean     shared-1            76.54 (   0.00%)       76.09 *  -0.59%*
> Hmean     shared-21         7535.51 (   0.00%)     5518.75 * -26.76%*
> Hmean     shared-41        17207.81 (   0.00%)    14651.94 * -14.85%*
> Hmean     shared-61        20716.98 (   0.00%)    18667.52 *  -9.89%*
> Hmean     shared-81        27603.83 (   0.00%)    23466.45 * -14.99%*
> Hmean     shared-101       26008.59 (   0.00%)    29536.96 *  13.57%*
> Hmean     shared-121       28354.76 (   0.00%)    43139.39 *  52.14%*
> Hmean     shared-141       38509.25 (   0.00%)    41619.35 *   8.08%*
> Hmean     shared-161       40496.07 (   0.00%)    44303.46 *   9.40%*
>
> Overall there is a small hit (in the noise level but consistent
> throughout
> many workloads), except git-checkout which does quite well.
>
> Thanks,
> Davidlohr

Thanks for running the patch through your performance tests.

Cheers,
Longman

