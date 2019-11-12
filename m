Return-Path: <SRS0=XoDG=ZE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E88C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 01:23:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FC621925
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 01:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MoSZd7gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FC621925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Bqkb0cXWzF0VF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 12:23:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Bqgy4Hk6zF51H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2019 12:21:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="MoSZd7gI"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47Bqgy17VBz9sPF; Tue, 12 Nov 2019 12:21:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47Bqgx1Ywjz9sP4;
 Tue, 12 Nov 2019 12:21:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1573521661;
 bh=F9ZI7aJXVRSlCItRZVrAQItH8rcNwZbNz7XhEYGd5MM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=MoSZd7gInPCPqS8Y0iT98x1HK1vNNhVr/zZB4JiXZjLV1BMkNQT13BWWbUIqA0zBO
 JDFYy4EazB84GH1G6G2PPmoRnt0K9ChPMSxwpRYUbhePPcLg2K+M9sswNV1nyfWvTI
 Xiid+IBG0a/bOQycR7OvXIxjUmVwYErB+vS3lX5gZDZLOtkVAEdlpk1077UIzTr0z6
 GCiinP46ZWqf+B8+TrbDVVVpiaGIaZmTjGi0PuBExuFganVMoBm9VcqB6Xd+K6J74z
 TaxZH44Ms9pe5myYbyUf7AMTY7fv1Bd6UIx9AqhJkeRwsRLvKASWbtQuCphrm0eYQx
 03lK0YzT3KyTg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v9 0/4] powerpc: expose secure variables to the kernel and
 userspace
In-Reply-To: <216572e5-d8c6-f181-3ec0-b4a840f20f46@linux.microsoft.com>
References: <1573441836-3632-1-git-send-email-nayna@linux.ibm.com>
 <216572e5-d8c6-f181-3ec0-b4a840f20f46@linux.microsoft.com>
Date: Tue, 12 Nov 2019 12:21:00 +1100
Message-ID: <87sgmt3n5v.fsf@mpe.ellerman.id.au>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> On 11/10/19 7:10 PM, Nayna Jain wrote:
>
> Hi Nayna,
>
>> In order to verify the OS kernel on PowerNV systems, secure boot requires
>> X.509 certificates trusted by the platform. These are stored in secure
>> variables controlled by OPAL, called OPAL secure variables. In order to
>> enable users to manage the keys, the secure variables need to be exposed
>> to userspace.
> Are you planning to split the patches in this patch set into smaller 
> chunks so that it is easier to code review and also perhaps make it 
> easier when merging the changes?

I don't think splitting them would add any value. They're already split
into the firmware specific bits (patch 1), and the sysfs parts (patch
2), which is sufficient for me.

cheers
