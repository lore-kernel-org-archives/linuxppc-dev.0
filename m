Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B90CC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:57:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2912184D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2912184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N3pj3KYmzDqtW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 00:57:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N38P2mdtzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:28:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43N38N53KKz9sNq; Mon, 24 Dec 2018 00:28:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ab7032e793f9ad799ca2692046fba5baed6d2a86
X-Patchwork-Hint: ignore
In-Reply-To: <20181219085232.103441-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel, v6,
 01/20] powerpc/ioda/npu: Call skiboot's hot reset hook when disabling
 NPU2
Message-Id: <43N38N53KKz9sNq@ozlabs.org>
Date: Mon, 24 Dec 2018 00:28:04 +1100 (AEDT)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?Leonardo_Augus?= =?utf-8?q?to_Guimar=C3=A3es_Garcia?=
 <lagarcia@br.ibm.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-12-19 at 08:52:13 UTC, Alexey Kardashevskiy wrote:
> The skiboot firmware has a hot reset handler which fences the NVIDIA V100
> GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
> https://github.com/open-power/skiboot/commit/fca2b2b839a67
> 
> Now we are going to pass V100 via VFIO which most certainly involves
> KVM guests which are often terminated without getting a chance to offline
> GPU RAM so we end up with a running machine with misconfigured memory.
> Accessing this memory produces hardware management interrupts (HMI)
> which bring the host down.
> 
> To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
> via pci_disable_device() which switches NPU2 to a safe mode and prevents
> HMIs.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Alistair Popple <alistair@popple.id.au>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ab7032e793f9ad799ca2692046fba5

cheers
