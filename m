Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 09:47:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267A62084A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267A62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43phVc1hdZzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 20:47:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43phSp2cfHzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 20:45:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43phSn3Rdlz9s9h;
 Tue, 29 Jan 2019 20:45:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, acme@kernel.org
Subject: Re: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
In-Reply-To: <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
References: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
 <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
Date: Tue, 29 Jan 2019 20:45:44 +1100
Message-ID: <874l9rsson.fsf@concordia.ellerman.id.au>
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
Cc: dzickus@redhat.com, maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 fowles@inreach.com, linux-kernel@vger.kernel.org, jmario@redhat.com,
 namhyung@kernel.org, jolsa@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:

> On 1/14/19 9:44 AM, Ravi Bangoria wrote:
>> Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
>> event and, perf_mem_events by default includes ldlat=30 which is
>> causing failure on powerpc. Refactor code to support perf mem/c2c on
>> powerpc.
>> 
>> This patch depends on kernel side changes done my Madhavan:
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
>> 
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>
>
> Arnaldo / Michael, Any thoughts?

I haven't merged the kernel patch, I think because Maddy told me not to
because it would break the userspace tooling :)

What is the actual dependency between them? ie. should we merge the
kernel fix first or second or what?

cheers
