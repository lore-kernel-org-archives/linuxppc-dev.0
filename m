Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D6C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:35:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B41820882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B41820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qNB24Mc6zDqNl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 23:35:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qN283xbNzDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:28:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qN273Dkqz9sCL;
 Wed, 30 Jan 2019 23:28:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Perform full re-add of CPU for topology
 update post-migration
In-Reply-To: <719fbfbf-795b-05c8-c181-96dd9c63b448@linux.vnet.ibm.com>
References: <154083861636.18916.18172276232185726281.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <810d1cee-98ce-6e8f-f87b-f9acb8ba35f2@linux.vnet.ibm.com>
 <877eenst1l.fsf@concordia.ellerman.id.au>
 <719fbfbf-795b-05c8-c181-96dd9c63b448@linux.vnet.ibm.com>
Date: Wed, 30 Jan 2019 23:28:30 +1100
Message-ID: <87r2cupbwx.fsf@concordia.ellerman.id.au>
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
Cc: ldufour@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 1/29/19 3:37 AM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> 
>>> On 10/29/18 1:43 PM, Nathan Fontenot wrote:
>>>> On pseries systems, performing a partition migration can result in
>>>> altering the nodes a CPU is assigned to on the destination system. For
>>>> exampl, pre-migration on the source system CPUs are in node 1 and 3,
>>>> post-migration on the destination system CPUs are in nodes 2 and 3.
>>>>
>>>> Handling the node change for a CPU can cause corruption in the slab
>>>> cache if we hit a timing where a CPUs node is changed while cache_reap()
>>>> is invoked. The corruption occurs because the slab cache code appears
>>>> to rely on the CPU and slab cache pages being on the same node.
>>>>
>>>> The current dynamic updating of a CPUs node done in arch/powerpc/mm/numa.c
>>>> does not prevent us from hitting this scenario.
>>>>
>>>> Changing the device tree property update notification handler that
>>>> recognizes an affinity change for a CPU to do a full DLPAR remove and
>>>> add of the CPU instead of dynamically changing its node resolves this
>>>> issue.
>>>>
>>>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com
>>> Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
>
> Tested-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>

Thanks.

cheers
