Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D83C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:07:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0F820844
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v0cM5MJZzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:07:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v0Zh6jgYzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:05:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43v0Zh4xPGz9sMl;
 Tue,  5 Feb 2019 21:05:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>, Pete Heyrman <heyrman@us.ibm.com>
Subject: Re: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
In-Reply-To: <25fbcee4-b1c1-de1e-efc0-6bb4bf081d45@linux.vnet.ibm.com>
References: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <8736p9pes4.fsf@concordia.ellerman.id.au>
 <65daf21b-dd1d-c22d-4746-65f4ae5d824f@linux.vnet.ibm.com>
 <1030033d-0cca-efa5-2833-ee8bbd7c4e8a@linux.vnet.ibm.com>
 <25fbcee4-b1c1-de1e-efc0-6bb4bf081d45@linux.vnet.ibm.com>
Date: Tue, 05 Feb 2019 21:05:47 +1100
Message-ID: <87sgx2mtxg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 01/31/2019 02:21 PM, Tyrel Datwyler wrote:
>> On 01/31/2019 01:53 PM, Michael Bringmann wrote:
>>> On 1/30/19 11:38 PM, Michael Ellerman wrote:
>>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>>> This patch is to check for cede'ed CPUs during LPM.  Some extreme
>>>>> tests encountered a problem ehere Linux has put some threads to
>>>>> sleep (possibly to save energy or something), LPM was attempted,
>>>>> and the Linux kernel didn't awaken the sleeping threads, but issued
>>>>> the H_JOIN for the active threads.  Since the sleeping threads
>>>>> are not awake, they can not issue the expected H_JOIN, and the
>>>>> partition would never suspend.  This patch wakes the sleeping
>>>>> threads back up.
>>>>
>>>> I'm don't think this is the right solution.
>>>>
>>>> Just after your for loop we do an on_each_cpu() call, which sends an I=
PI
>>>> to every CPU, and that should wake all CPUs up from CEDE.
>>>>
>>>> If that's not happening then there is a bug somewhere, and we need to
>>>> work out where.
>>>
>>> Let me explain the scenario of the LPM case that Pete Heyrman found, and
>>> that Nathan F. was working upon, previously.
>>>
>>> In the scenario, the partition has 5 dedicated processors each with 8 t=
hreads
>>> running.
>>=20
>> Do we CEDE processors when running dedicated? I thought H_CEDE was part =
of the
>> Shared Processor LPAR option.
>
> Looks like the cpuidle-pseries driver uses CEDE with dedicated processors=
 as
> long as firmware supports SPLPAR option.
>
>>=20
>>>
>>> From the PHYP data we can see that on VP 0, threads 3, 4, 5, 6 and 7 is=
sued
>>> a H_CEDE requesting to save energy by putting the requesting thread into
>>> sleep mode.  In this state, the thread will only be awakened by H_PROD =
from
>>> another running thread or from an external user action (power off, rebo=
ot
>>> and such).  Timers and external interrupts are disabled in this mode.
>>=20
>> Not according to PAPR. A CEDE'd processor should awaken if signaled by e=
xternal
>> interrupt such as decrementer or IPI as well.
>
> This statement should still apply though. From PAPR:
>
> 14.11.3.3 H_CEDE
> The architectural intent of this hcall() is to have the virtual processor=
, which
> has no useful work to do, enter a wait state ceding its processor capacit=
y to
> other virtual processors until some useful work appears, signaled either =
through
> an interrupt or a prod hcall(). To help the caller reduce race conditions=
, this
> call may be made with interrupts disabled but the semantics of the hcall()
> enable the virtual processor=E2=80=99s interrupts so that it may always r=
eceive wake up
> interrupt signals.

Thanks for digging that out of PAPR.

H_CEDE must respond to IPIs, we have no logic to H_PROD CPUs that are
idle in order to wake them up.

There must be something else going on here.

cheers
