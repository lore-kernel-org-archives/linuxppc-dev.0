Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8302C67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA3E20652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ds1w3h6kzDrVM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 20:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42drvQ57QtzDrVn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:34:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42drvQ2qk4z9sDC; Mon, 22 Oct 2018 20:34:26 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 59fe7eaf3598a89cbcd72e645b1d08afd76f7b29
In-Reply-To: <20180529065100.2017-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc64/module elfv1: Set opd addresses after module relocation
Message-Id: <42drvQ2qk4z9sDC@ozlabs.org>
Date: Mon, 22 Oct 2018 20:34:25 +1100 (AEDT)
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
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-05-29 at 06:51:00 UTC, "Naveen N. Rao" wrote:
> module_frob_arch_sections() is called before the module is moved to its
> final location. The function descriptor section addresses we are setting
> here are thus invalid. Fix this by processing opd section during 
> module_finalize()
> 
> Fixes: 5633e85b2c313 ("powerpc64: Add .opd based function descriptor dereference")
> Cc: stable@vger.kernel.org # v4.16
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/59fe7eaf3598a89cbcd72e645b1d08

cheers
