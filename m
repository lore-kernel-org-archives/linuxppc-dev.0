Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A3C2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 01:00:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8251820768
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 01:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YlEB2G4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8251820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491Rwd4t8DzDqLC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 11:00:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491Rkq30F5zDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 10:51:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YlEB2G4L; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 491Rkp6QyRz9sSk;
 Tue, 14 Apr 2020 10:51:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1586825491;
 bh=Lu+lnFaV1xSDWR81mSR54x4nl15RVb3+4B7MuYkt1g0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YlEB2G4L51G4Z0CbLAgGzQc/vGjKnbCq9KXxcegdigB4DRQklBa7IBu8dK4izaEb6
 v687sHdCGAZpeS1DxBs5R9kJrF9bdDIhPhGazL0Nd+K/ssVh+gdzWUIb/hBEoszcHE
 frEaMXbSFVIubwOihvFtfknrgbSbdhdEBk3reW2RBYIV3VbLfOupyyrSG4OiTvIFNG
 wdE1E0IOpqH91p7JNhYelJMCtg8VXhzuAZkqds3a403iWenYza6oqoaZcMf/LT22i0
 JCPFbkrKzEyFveJh+Y5gP183qZX4QyjkK8fB7vlb+2sINn1sq1ABQRbYVogPBcdw0h
 Yd78MVLfPPHew==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] qtpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver
 as module
In-Reply-To: <20200402193134.GC10314@linux.intel.com>
References: <20200319010017.738677-1-stefanb@linux.vnet.ibm.com>
 <20200319195706.GD24804@linux.intel.com>
 <2BF66599-184A-4647-BC57-105A1512F119@linux.vnet.ibm.com>
 <20200402193134.GC10314@linux.intel.com>
Date: Tue, 14 Apr 2020 10:51:37 +1000
Message-ID: <87k12ikhye.fsf@mpe.ellerman.id.au>
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> On Wed, Apr 01, 2020 at 02:40:30PM +0530, Sachin Sant wrote:
>> > On 20-Mar-2020, at 1:27 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>> > 
>> > On Wed, Mar 18, 2020 at 09:00:17PM -0400, Stefan Berger wrote:
>> >> From: Stefan Berger <stefanb@linux.ibm.com>
>> >> 
>> >> This patch fixes the following problem when the ibmvtpm driver
>> >> is built as a module:
>> >> 
>> >> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
>> >> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
>> >> make: *** [Makefile:1298: modules] Error 2
>> >> 
>> >> Fixes: 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2")
>> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> >> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> >> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> > 
>> 
>> Ping. This failure can now be seen in mainline (cad18da0af) as well.
>
> It is in my tree

Can you please send it to Linus?

cheers
