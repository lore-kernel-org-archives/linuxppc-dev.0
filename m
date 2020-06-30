Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3751AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 02:28:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789E720702
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 02:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HAPr1ft0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789E720702
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wpFY1JgMzDqgB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 12:28:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wpCp53WhzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 12:27:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=HAPr1ft0; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49wpCp1LFCz9sRk; Tue, 30 Jun 2020 12:27:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1593484038; bh=NFM6COCoADkJtON3c24Vv6dFmjtqhT4V6y1+lHPgb0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HAPr1ft04WysSZiADOMjCalamrA2adoBIwdiJ0pp2KzZhZVSmLmTsuGjLjCxYggFr
 q8DiWs7T4bJs329eLGZx7d4U281mnCNHKeyrctNhSGtBnj0cJJj3Wz/N+aRJgkhIRu
 JBgeZ5EjOYIewS9wFaYJPP3pfL/Hf3OlIUuppXCgR/9evzKx+xtCIXquNUwyrChwok
 GH4YJkNpGXJG8FwvzktyPgLLPWFLDU/I3eNGgS0/Hy69HTMtLrxCq+wrcr4PiLe3AF
 GGr0iHUJyQSKRDXJtsbxCJW04BzXYtzeyv0Hdw3MeOCelCh9ZQ3eEpNYjWT7ic5gaB
 xPvLycUUxw1Vw==
Date: Tue, 30 Jun 2020 12:27:13 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/pseries: Add KVM guest doorbell restrictions
Message-ID: <20200630022713.GA618342@thinks.paulus.ozlabs.org>
References: <20200627150428.2525192-1-npiggin@gmail.com>
 <20200627150428.2525192-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627150428.2525192-4-npiggin@gmail.com>
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
Cc: kvm-ppc@vger.kernel.org, Anton Blanchard <anton@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jun 28, 2020 at 01:04:28AM +1000, Nicholas Piggin wrote:
> KVM guests have certain restrictions and performance quirks when
> using doorbells. This patch tests for KVM environment in doorbell
> setup, and optimises IPI performance:
> 
>  - PowerVM guests may now use doorbells even if they are secure.
> 
>  - KVM guests no longer use doorbells if XIVE is available.

It seems, from the fact that you completely remove
kvm_para_available(), that you perhaps haven't tried building with
CONFIG_KVM_GUEST=y.  Somewhat confusingly, that option is not used or
needed when building for a PAPR guest (i.e. the "pseries" platform)
but is used on non-IBM platforms using the "epapr" hypervisor
interface.

If you did intend to remove support for the epapr hypervisor interface
then that should have been talked about in the commit message (and
would I expect be controversial).

So NAK on the kvm_para_available() removal.

Paul.
