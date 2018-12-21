Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 00:58:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B84218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 00:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B84218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LVbn3wZyzDr97
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 11:57:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LVYV2RCgzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 11:55:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43LVYT64pwz9sCX;
 Fri, 21 Dec 2018 11:55:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v2] powerpc/pkeys: copy pkey-tracking-information at fork()
In-Reply-To: <20181220200330.GA5385@ram.oc3035372033.ibm.com>
References: <1543869802-15372-1-git-send-email-linuxram@us.ibm.com>
 <8736qsqqsu.fsf@concordia.ellerman.id.au>
 <20181220200330.GA5385@ram.oc3035372033.ibm.com>
Date: Fri, 21 Dec 2018 11:55:57 +1100
Message-ID: <87va3npujm.fsf@concordia.ellerman.id.au>
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
Cc: fweimer@redhat.com, Ulrich.Weigand@de.ibm.com, dave.hansen@linux.intel.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ram Pai <linuxram@us.ibm.com> writes:

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
>     
> v2: do not copy if pkeys is disabled.
>     	-- comment by Michael Ellermen

Thanks.

I changed the subject to:

  powerpc/pkeys: Fix handling of pkey state across fork()

And added tags:

  Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
  Cc: stable@vger.kernel.org # v4.16+

cheers
