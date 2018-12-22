Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811EC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:39:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F73219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F73219FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MMSX2Ms6zDqwb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:39:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSq5JxwzDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSq2rRPz9sPQ; Sat, 22 Dec 2018 20:54:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e1e71e201703500f708bdeaf64660a2a178cb6a0
X-Patchwork-Hint: ignore
In-Reply-To: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: ocxl: Fix endiannes bug in ocxl_link_update_pe()
Message-Id: <43MLSq2rRPz9sPQ@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:50 +1100 (AEDT)
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-12-16 at 21:28:50 UTC, Greg Kurz wrote:
> All fields in the PE are big-endian. Use cpu_to_be32() like everywhere
> else something is written to the PE. Otherwise a wrong TID will be used
> by the NPU. If this TID happens to point to an existing thread sharing
> the same mm, it could be woken up by error. This is highly improbable
> though. The likely outcome of this is the NPU not finding the target
> thread and forcing the AFU into sending an interrupt, which userspace
> is supposed to handle anyway.
> 
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
> Cc: stable@vger.kernel.org      # v4.18
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Alastair D'Silva <alastair@d-silva.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1e71e201703500f708bdeaf64660a

cheers
