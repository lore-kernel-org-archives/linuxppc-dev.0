Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A8BC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F053B2084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="T/On6EAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F4bb4DvHzDqd9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 16:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="T/On6EAJ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F4Tm2Q8gzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 16:03:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="T/On6EAJ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43F4Tm05yWz9s3Z; Wed, 12 Dec 2018 16:03:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544591036; bh=rhEosjEfZQzhO2bufzhDYXx13Ie6MQ63HUdwjJ0mvBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/On6EAJ8s/c3MCJUpyi0kf9eTf6ldoCznRPofkXLaxKgJyPQxhH9fJdLuTG7YgFS
 8MO6GzMJ3B7M0nAT+1jT/U3psl3Eqq8zIp8uWaTK+FjVvNTLN5/PlawFEOMHsibAi0
 ycC21g1yRthYEBTXQHmnGLzkR0mxghAfMYMRWNFU1XYZiuGvMwYrxtr7d5IIMRpg37
 vhA8lSSTfddQAEMd82tUYsNiViWUKYGvo+AUDkfuLQ881gC2J9eNZ1bRfyed/XJ2H2
 aOG4vMImeDe/8pM0mlwJD0MNgTps+a2EuB5w3+D5qRBrss3J1w9BaKZp5CRctDdfO7
 M8+jaPBfh+LQg==
Date: Wed, 12 Dec 2018 16:03:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: lantianyu1986@gmail.com
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
Message-ID: <20181212050353.GF22265@blackberry>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The patch is to make kvm_set_spte_hva() return int and caller can
> check return value to determine flush tlb or not.

It would be helpful if the patch description told the reader which
return value(s) mean that the caller should flush the tlb.  I would
guess that non-zero means to do the flush, but you should make that
explicit.

> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

For the powerpc bits:

Acked-by: Paul Mackerras <paulus@ozlabs.org>
