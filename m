Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07389C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F1B2184D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F1B2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N3vV2kR7zDqvl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 01:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N38S4GGRzDqVy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43N38R5Q9rz9sLw; Mon, 24 Dec 2018 00:28:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2cd4bd192ee94848695c1c052d87913260e10f36
X-Patchwork-Hint: ignore
In-Reply-To: <20181220200330.GA5385@ram.oc3035372033.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/pkeys: copy pkey-tracking-information at fork()
Message-Id: <43N38R5Q9rz9sLw@ozlabs.org>
Date: Mon, 24 Dec 2018 00:28:06 +1100 (AEDT)
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
Cc: fweimer@redhat.com, dave.hansen@linux.intel.com, mhocko@kernel.org,
 Ulrich.Weigand@de.ibm.com, bauerman@linux.vnet.ibm.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-12-20 at 20:03:30 UTC, Ram Pai wrote:
> Pkey tracking information is not copied over to the mm_struct of the
> child during fork(). This can cause the child to erroneously allocate
> keys that were already allocated. Any allocated execute-only key is lost
> aswell.
>     
> Add code; called by dup_mmap(), to copy the pkey state from parent to
> child explicitly.
>     
> This problem was originally found by Dave Hansen on x86, which turns out
> to be a problem on powerpc aswell.
>     
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2cd4bd192ee94848695c1c052d8791

cheers
