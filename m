Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346C606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYucXjt5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYg8d3sv7z2xlw;
	Tue, 24 Nov 2026 22:10:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795518641;
	cv=none; b=fB7DPYJJVwPBPvY/r9BlMmm8ZqH4756zcqTeWhJphYSf8vo8cDa55DFZ8LqWjqaSj/QtBAgDfybV6RfR+2UnOzzanIfOyGk77Kc5i7EmEszHkQLICVRzUuymXckh1A5QJE75UwT+wVDOw0ZJf7erKGcJFKukmQwaO3YnS6R7Fo+dO66lmptd4oWLV60qS3XQntriQd1BoofW5pd7q/A9oVv1thFvcRNBLqsy0a/pjALsndyXPN3w5SiSinHKQw3esXVFc4CBMRkU0M70GPYPccb6mz55q2Skp3oyqtWEBn1r1irrVJBx2P1cCTl6HzUOpmoo1HPYTF0Olj6zn7UF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795518641; c=relaxed/relaxed;
	bh=frSIgxUTlioq2uhgijeM3PWfH5xAEbVA200e6JXr+NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHigz+mq8m9AZmTMIbvYnauO2F4G8aGA690bAyinayDyj88MBvDdaPwYRTHTpPJTy8yxlbZ+IhlO58ttfSEHVrHKBvNr01dkpVkziAmmzW3Xk/GWoLtsqP4fkmZCWO2rgvIoYLlg3hbWKB7jrN0kozFEiZr3mQZUk9oSygyRBcJ11e0louPrCMErXbwq83O1PyFKMj1i5CVULDOjqabXR1B949DQIOSAKm+RtlnwdtYx3VXaEODYyS7wf7yvyGbOjcXAhOiIZPkhtjn7Z6F8JYc2YTZZXTqDZ+LBq6RTe930fKmlv+19edLnyZSiZKaZerSwcQTFl9/TCgxo0momDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYucXjt5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYucXjt5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYg8c5KhDz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 22:10:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 963C04420D;
	Tue, 24 Nov 2026 11:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F164C1F000CA;
	Tue, 24 Nov 2026 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795518638;
	bh=frSIgxUTlioq2uhgijeM3PWfH5xAEbVA200e6JXr+NE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BYucXjt5G91y0VAxxGlCdgd/4laD4od+Lg2Lj/i1nLEhdEg3GP6GTMLuOUB/o/Z9+
	 aMKmwN3Ek7fscLrppvrpUyATdQW3snq/Z3R7VuBn+plVi3bXH/PC1nyQqfcHGgcnAq
	 P9eYI2jH+X0C4jc5Hu4/HRzYfLl6xAfRInNjgBZ/OKid0i49kWOxdQkoV4VVC0a0Od
	 fm5ExHLScwOrEMpRwKrCMFE/yw3vUl9bxEKCU16vjBCtQtex0oLX9pMl1cGfNdhMiI
	 4H5+DJ/psLL004CY0h16IRiRI/HGh9oiKVT8XFZeVF0vvN7Z/W91zZM1BTVejBBsVd
	 kYEY+6fPW1S+w==
Message-ID: <31d57c47-d8a2-4ac1-bf40-292fd3eab1a1@kernel.org>
Date: Tue, 24 Nov 2026 12:10:32 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] macintosh: ans-lcd: add missing MODULE_DESCRIPTION()
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20261121192319.930162-1-rdunlap@infradead.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261121192319.930162-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 21/11/2026 à 20:23, Randy Dunlap a écrit :
> Add missing MODULE_DESCRIPTION() that is now required.
> 
> WARNING: modpost: drivers/macintosh/ans-lcd.ko: missing MODULE_DESCRIPTION()

Can you add in the commit message that it has been required since commit 
6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()")

Also, that's probably not the only one in drivers/macintosh missing a 
MODULE_DESCRIPTION():

   drivers/macintosh$ git grep -l MODULE_ | wc -l
   28

   drivers/macintosh$ git grep -l MODULE_DESCRIPTION | wc -l
   23

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
>   drivers/macintosh/ans-lcd.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20261118.orig/drivers/macintosh/ans-lcd.c
> +++ linux-next-20261118/drivers/macintosh/ans-lcd.c
> @@ -202,4 +202,5 @@ anslcd_exit(void)
>   
>   module_init(anslcd_init);
>   module_exit(anslcd_exit);
> +MODULE_DESCRIPTION("/dev/lcd driver for Apple Network Servers");
>   MODULE_LICENSE("GPL v2");


