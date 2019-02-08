Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F19DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:07:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4488420857
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4488420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxnz2VM4zDqMl
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:07:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwMH3cDzzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:02:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wwMH0nJbz9sNQ; Sat,  9 Feb 2019 00:02:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 865a9432d16fe2f40a1a52005fd30778056c7921
X-Patchwork-Hint: ignore
In-Reply-To: <1548696702-20686-1-git-send-email-arbab@linux.ibm.com>
To: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Add _PAGE_SAO to _PAGE_CACHE_CTL mask
Message-Id: <43wwMH0nJbz9sNQ@ozlabs.org>
Date: Sat,  9 Feb 2019 00:02:34 +1100 (AEDT)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Charles Johns <crjohns@us.ibm.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-01-28 at 17:31:42 UTC, Reza Arbab wrote:
> In htab_convert_pte_flags(), _PAGE_CACHE_CTL is used to check for the
> _PAGE_SAO flag:
> 
>   else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
>           rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
> 
> But, it isn't defined to include that flag:
> 
>   #define _PAGE_CACHE_CTL (_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
> 
> This happens to work, but only because of the flag values:
> 
>   #define _PAGE_SAO               0x00010 /* Strong access order */
>   #define _PAGE_NON_IDEMPOTENT    0x00020 /* non idempotent memory */
>   #define _PAGE_TOLERANT          0x00030 /* tolerant memory, cache inhibited */
> 
> To prevent any issues if these particulars ever change, add _PAGE_SAO to
> the mask.
> 
> Suggested-by: Charles Johns <crjohns@us.ibm.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/865a9432d16fe2f40a1a52005fd30778

cheers
