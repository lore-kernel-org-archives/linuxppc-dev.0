Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B0AC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:25:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B4620835
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tvz21wH9zF3B1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 22:25:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tvs80qnWzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 22:19:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Tvs75fw0z9s89;
 Tue,  9 Oct 2018 22:19:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v03 1/5] powerpc/drmem: Export 'dynamic-memory' loader
In-Reply-To: <3dde35eb-4997-5d61-c94f-d036bd57de18@linux.vnet.ibm.com>
References: <20181001125846.2676.89826.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001125924.2676.54786.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <87y3bfkfnx.fsf@concordia.ellerman.id.au>
 <3dde35eb-4997-5d61-c94f-d036bd57de18@linux.vnet.ibm.com>
Date: Tue, 09 Oct 2018 22:19:55 +1100
Message-ID: <87o9c31i5g.fsf@concordia.ellerman.id.au>
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> On 10/02/2018 08:00 PM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> 
>>> powerpc/drmem: Export many of the functions of DRMEM to parse
>>> "ibm,dynamic-memory" and "ibm,dynamic-memory-v2" during hotplug
>>> operations and for Post Migration events.
>> 
>> This isn't a criticism of your patch, but I think the drmem.c code
>> should be moved into platforms/pseries.
>> 
>> That would then make most of it private to platforms/pseries and we
>> wouldn't need to export things in arch/powerpc/include/asm.
>
> I don't have an issue with moving it to platform/pseries. I originally
> put it in arch/powerpc/mm because the numa code also uses the drmem code.

Yeah, originally the NUMA code was only used on pseries so the
distinction between NUMA and pseries-specific NUMA didn't exist.

But these days we're getting more and more code that is really pseries
(or PAPR) specific, so it might make sense to move it.

I may be wrong, perhaps there isn't a clean split there, but it would be
worth trying.

cheers
