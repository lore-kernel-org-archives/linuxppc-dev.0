Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEACD2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="wQ5zegNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEACD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RSr71FdzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:51:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RGv4B5mzDqTW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="wQ5zegNO"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 445RGv1njKz9sBR; Fri, 22 Feb 2019 20:43:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550828599; bh=69RpLShxu7v7F3u7hhUy500rILC7BMMahqW1Kax5vVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wQ5zegNOOELgVaNnAGjXctHceAwNu9qh+nFMNardBxru/wNAkpvPeFPUcRf+jXBdG
 +h35CyHZHs/UCRE45Dr60daKe9NQYAUEhV9TQyqqC//gGgWVq2N/VkXlMhbcXaDvyy
 OmZ20DtXSl4k9rOaSCSO7cEoMz2qwvgTYjaITBPzaM8+sgOhDdXgLHu1NV7isRddeu
 3OyG3WNdw+E18ICmeTgqc5b7adVkKFGEIRG75PYjZsdAaL69bgh5nTuz8OCjoYYDBj
 /5B0OgRGfF4IzHkjOERZIctwtAOS3fBK/ISb2GHU6e+VPTeNFcBjObpYr+ruihHH0T
 PAz7OarvDTLbg==
Date: Fri, 22 Feb 2019 20:41:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] KVM: PPC: Improve KVM reference counting
Message-ID: <20190222094153.GF6006@blackberry>
References: <20190221034414.41777-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221034414.41777-1-aik@ozlabs.ru>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 02:44:14PM +1100, Alexey Kardashevskiy wrote:
> The anon fd's ops releases the KVM reference in the release hook.
> However we reference the KVM object after we create the fd so there is
> small window when the release function can be called and
> dereferenced the KVM object which potentially may free it.
> 
> It is not a problem at the moment as the file is created and KVM is
> referenced under the KVM lock and the release function obtains the same
> lock before dereferencing the KVM (although the lock is not held when
> calling kvm_put_kvm()) but it is a fragile against future changes.
> 
> This references the KVM object before creating a file.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-next tree.

Paul.
