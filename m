Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D90C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180D020882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180D020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qNNY6Pc6zDqWB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 23:44:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qNKS2vW4zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:41:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qNKR6f4Zz9s9h;
 Wed, 30 Jan 2019 23:41:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [RESEND PATCH v3] cxl: Wrap iterations over afu slices inside
 'afu_list_lock'
In-Reply-To: <20190129110618.13481-1-vaibhav@linux.ibm.com>
References: <20190129110618.13481-1-vaibhav@linux.ibm.com>
Date: Wed, 30 Jan 2019 23:41:47 +1100
Message-ID: <87lg32pbas.fsf@concordia.ellerman.id.au>
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Within cxl module, iteration over array 'adapter->afu' may be racy
> at few points as it might be simultaneously read during an EEH and its
> contents being set to NULL while driver is being unloaded or unbound
> from the adapter. This might result in a NULL pointer to 'struct afu'
> being de-referenced during an EEH thereby causing a kernel oops.
>
> This patch fixes this by making sure that all access to the array
> 'adapter->afu' is wrapped within the context of spin-lock
> 'adapter->afu_list_lock'.
>
> Cc: stable@vger.kernel.org
> Fixes: 9e8df8a2196("cxl: EEH support")
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> Resend:
> * Fixed the reference to 'adapter->afu' in patch description. [Andrew]
> * Added the 'Fixes' tag and marked the patch to stable

FYI RESEND means you didn't change anything, but you sent the patch
again for some other reason, like the Cc list was wrong or you thought
it had been ignored.

In this case you should have just sent a v4, updating the change log is
a perfectly valid reason for a new version of the patch.

I've applied it, no need to RESEND ;)

cheers
