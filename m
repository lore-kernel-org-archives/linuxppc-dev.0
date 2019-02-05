Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DEC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0B72083B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v12g5XDFzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:26:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v10j4vJ8zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:24:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43v10j0yVxz9sMl;
 Tue,  5 Feb 2019 21:24:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>, Pete Heyrman <heyrman@us.ibm.com>
Subject: Re: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
In-Reply-To: <e94ed583-a4d9-b03a-cd44-be990b6cfa19@linux.vnet.ibm.com>
References: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <8736p9pes4.fsf@concordia.ellerman.id.au>
 <65daf21b-dd1d-c22d-4746-65f4ae5d824f@linux.vnet.ibm.com>
 <e94ed583-a4d9-b03a-cd44-be990b6cfa19@linux.vnet.ibm.com>
Date: Tue, 05 Feb 2019 21:24:51 +1100
Message-ID: <87munamt1o.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> See below.
>
> On 1/31/19 3:53 PM, Michael Bringmann wrote:
>> On 1/30/19 11:38 PM, Michael Ellerman wrote:
>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>> This patch is to check for cede'ed CPUs during LPM.  Some extreme
>>>> tests encountered a problem ehere Linux has put some threads to
>>>> sleep (possibly to save energy or something), LPM was attempted,
>>>> and the Linux kernel didn't awaken the sleeping threads, but issued
>>>> the H_JOIN for the active threads.  Since the sleeping threads
>>>> are not awake, they can not issue the expected H_JOIN, and the
>>>> partition would never suspend.  This patch wakes the sleeping
>>>> threads back up.
>>>
>>> I'm don't think this is the right solution.
>>>
>>> Just after your for loop we do an on_each_cpu() call, which sends an IPI
>>> to every CPU, and that should wake all CPUs up from CEDE.
>>>
>>> If that's not happening then there is a bug somewhere, and we need to
>>> work out where.
>
> From Pete Heyrman:
>     Both sending IPI or H_PROD will awaken a logical processors that has ceded.
>     When you have logical proc doing cede and one logical proc doing prod or IPI
>     you have a race condition that the prod/IPI can proceed the cede request.
>     If you use prod, the hypervisor takes care of the synchronization by ignoring
>     a cede request if it was preceeded by a prod.  With IPI the interrupt is
>     delivered which could then be followed by a cede so OS would need to provide
>     synchronization.
>
> Shouldn't this answer your concerns about race conditions and the suitability
> of using H_PROD?

No sorry it doesn't.

Assuming the other CPU is idle it will just continually do CEDE in a
loop, sending it a PROD will just wake it up once and then it will CEDE
again. That first CEDE might return immediately on seeing the PROD, but
then the kernel will just CEDE again because it has nothing to do.

In contrast the IPI we send wakes up the other CPU and tells it to run a
function, rtas_percpu_suspend_me(), which does the H_JOIN directly.

I still don't understand how the original bug ever even happened. That's
what I want to know.

The way we do the joining and suspend seems like it could be simpler,
there's a bunch of atomic flags and __rtas_suspend_last_cpu() seems to
duplicate much of __rtas_suspend_cpu(). It seems more likely we have a
bug in there somewhere.

cheers
