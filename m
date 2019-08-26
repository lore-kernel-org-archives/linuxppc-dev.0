Return-Path: <SRS0=H2FS=WW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8BDC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 03:23:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDB020815
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 03:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDB020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Gy504qZnzDqfK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 13:23:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Gy2s4dmxzDqc1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2019 13:21:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46Gy2r3xn6z9sMr; Mon, 26 Aug 2019 13:21:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46Gy2q45Bxz9sDB;
 Mon, 26 Aug 2019 13:21:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Claudio Carvalho <cclaudio@linux.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv: Add ultravisor message log interface
In-Reply-To: <4e577a36-4ce1-410b-3ceb-d31bbf564b3d@linux.ibm.com>
References: <20190823060654.28842-1-cclaudio@linux.ibm.com>
 <87o90g3v5o.fsf@concordia.ellerman.id.au>
 <4e577a36-4ce1-410b-3ceb-d31bbf564b3d@linux.ibm.com>
Date: Mon, 26 Aug 2019 13:21:20 +1000
Message-ID: <87lfvg4nnz.fsf@concordia.ellerman.id.au>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Ryan Grimm <grimm@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> On 8/23/19 9:48 AM, Michael Ellerman wrote:
>> Claudio Carvalho <cclaudio@linux.ibm.com> writes:
>>> Ultravisor (UV) provides an in-memory console which follows the OPAL
>>> in-memory console structure.
>>>
>>> This patch extends the OPAL msglog code to also initialize the UV memory
>>> console and provide a sysfs interface (uv_msglog) for userspace to view
>>> the UV message log.
>>>
>>> CC: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> CC: Oliver O'Halloran <oohall@gmail.com>
>>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>>> ---
>>> This patch depends on the "kvmppc: Paravirtualize KVM to support
>>> ultravisor" patchset submitted by Claudio Carvalho.
>>> ---
>>>  arch/powerpc/platforms/powernv/opal-msglog.c | 99 ++++++++++++++------
>>>  1 file changed, 72 insertions(+), 27 deletions(-)
>> I think the code changes look mostly OK here.
>>
>> But I'm not sure about the end result in sysfs.
>>
>> If I'm reading it right this will create:
>>
>>  /sys/firmware/opal/uv_msglog
>>
>> Which I think is a little weird, because the UV is not OPAL.
>>
>> So I guess I wonder if the file should be created elsewhere to avoid any
>> confusion and keep things nicely separated.
>>
>> Possibly /sys/firmware/ultravisor/msglog ?
>
>
> Yes, makes sense. I will do that.

Thanks.

> Currently, the ultravisor memory console DT property is in
> /ibm,opal/ibm,opal-uv-memcons. I think we should move it to
> /ibm,ultravisor/ibm,uv-firmware/ibm,uv-memcons. What do you think?

Yes that looks better.

As an aside, you don't really need to namespace every node and property
under ibm,ultravisor, the top-level ibm,ultravisor is already a
namespace of sorts.

ie. it could just be: /ibm,ultravisor/firmware/memcons

But if it's too late to change those paths it doesn't really matter.

cheers
