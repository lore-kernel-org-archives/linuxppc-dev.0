Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC81C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 11:43:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27772226A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 11:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27772226A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwGbP71cczDq63
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 22:42:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CwFPH0j84zDqNW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2020 21:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CwFPG6R35z9sVM; Tue, 15 Dec 2020 21:49:06 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
In-Reply-To: <20201106045650.278987-1-ravi.bangoria@linux.ibm.com>
References: <20201106045650.278987-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/watchpoint: Workaround P10 DD1 issue with
 VSX-32 byte instructions
Message-Id: <160802921197.504444.6283070144643537807.b4-ty@ellerman.id.au>
Date: Tue, 15 Dec 2020 21:49:06 +1100 (AEDT)
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
Cc: christophe.leroy@c-s.fr, mikey@linux.ibm.com, jniethe5@gmail.com,
 npiggin@gmail.com, maddy@linux.ibm.com, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 6 Nov 2020 10:26:50 +0530, Ravi Bangoria wrote:
> POWER10 DD1 has an issue where it generates watchpoint exceptions when
> it shouldn't. The conditions where this occur are:
> 
>  - octword op
>  - ending address of DAWR range is less than starting address of op
>  - those addresses need to be in the same or in two consecutive 512B
>    blocks
>  - 'op address + 64B' generates an address that has a carry into bit
>    52 (crosses 2K boundary)
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/watchpoint: Workaround P10 DD1 issue with VSX-32 byte instructions
      https://git.kernel.org/powerpc/c/3d2ffcdd2a982e8bbe65fa0f94fb21bf304c281e

cheers
