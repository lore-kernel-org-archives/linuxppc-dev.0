Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:46:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B61F2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Fy/MOjvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B61F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RM346JxzDqTy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:46:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RGv0rP3zDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Fy/MOjvB"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 445RGt5Lwnz9sB8; Fri, 22 Feb 2019 20:43:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550828598; bh=kkFZR+1x5t2SxE1DFisnUOo0pFDJKpb0vUMXGH8St04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fy/MOjvBzMssZMdqsA2wZrKSuozdKv3Ut4mlPSeW7WeuKej+H9VEepNax4ZvAzkD/
 17nzEEQhi2suTxELUfAPFgxUyWctshGXSi70PaTsPl+1bSpX0hg5srVRTnSpcn1miU
 TJjVTfqcVshK13tj1C5EMfhs/vVAlnh+HiZfEG7BYlC1igu6P3+sf8BkorTW+njJw+
 9oMPri+lxS68/Zf6w0Vg611cqBfuNkEkNmVOAAhEF4G2k+ysaTdgxyc6UFKok4wfnn
 sRJWBqUdI39DVIHLqoMi4MJGLAimU8kKmmB8psbEuE20WUWnxbmL3UMGP0egflniZp
 cASWobX+em6/A==
Date: Fri, 22 Feb 2019 20:39:02 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Optimise mmio emulation for devices
 on FAST_MMIO_BUS
Message-ID: <20190222093902.GB6006@blackberry>
References: <20190207045650.18322-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207045650.18322-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 07, 2019 at 03:56:50PM +1100, Suraj Jitindar Singh wrote:
> Devices on the KVM_FAST_MMIO_BUS by definition have length zero and are
> thus used for notification purposes rather than data transfer. For
> example eventfd for virtio devices.
> 
> This means that when emulating mmio instructions which target devices on
> this bus we can immediately handle them and return without needing to load
> the instruction from guest memory.
> 
> For now we restrict this to stores as this is the only use case at
> present.
> 
> For a normal guest the effect is negligible, however for a nested guest
> we save on the order of 5us per access.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Thanks, applied to my kvm-ppc-next tree.

Paul.
