Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CEFC3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 07:26:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04D722CEC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 07:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04D722CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46PC0l3hbVzDr2h
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 17:26:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46PBy42wK3zDqxc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 17:23:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46PBy34d7Tz9sDB; Thu,  5 Sep 2019 17:23:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46PBy328Skz9s7T;
 Thu,  5 Sep 2019 17:23:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 14/31] powernv/fadump: define register/un-register
 callback functions
In-Reply-To: <156630275043.8896.8993437371524687114.stgit@hbathini.in.ibm.com>
References: <156630261682.8896.3418665808003586786.stgit@hbathini.in.ibm.com>
 <156630275043.8896.8993437371524687114.stgit@hbathini.in.ibm.com>
Date: Thu, 05 Sep 2019 17:23:53 +1000
Message-ID: <87zhjjnr3q.fsf@mpe.ellerman.id.au>
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Oliver <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini <hbathini@linux.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
> index e466f7e..91fb909 100644
> --- a/arch/powerpc/platforms/powernv/opal-fadump.c
> +++ b/arch/powerpc/platforms/powernv/opal-fadump.c
> @@ -52,6 +68,8 @@ static ulong opal_fadump_init_mem_struct(struct fw_dump *fadump_conf)
>  	opal_fdm->fadumphdr_addr = (opal_fdm->rgn[0].dest +
>  				    fadump_conf->boot_memory_size);
>  
> +	opal_fadump_update_config(fadump_conf, opal_fdm);
> +
>  	return addr;
>  }
>  
> @@ -97,12 +115,69 @@ static int opal_fadump_setup_metadata(struct fw_dump *fadump_conf)
>  
>  static int opal_fadump_register(struct fw_dump *fadump_conf)
>  {
> -	return -EIO;
> +	int i, err = -EIO;
> +	s64 rc;

Some compiler versions are warning about this being used uninitialised:

arch/powerpc/platforms/powernv/opal-fadump.c:316:3: error: 'rc' may be used uninitialized in this function [-Werror=uninitialized]

http://kisskb.ellerman.id.au/kisskb/buildresult/13943984/

Which does seem like a legitimate warning.

cheers
