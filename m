Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBD6C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 May 2022 21:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kw3gm5Yxwz3c9S
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 May 2022 07:32:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=A49620i7;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3yzJVIl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=A49620i7; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=3yzJVIl7; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kw3g3730Nz3byZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2022 07:31:59 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651872716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
 b=A49620i7PRera+mhe1BweZ6Vv1Q3trFfvTBAN/4Kjrnu3jQc1o9ibi6TM3bHEk90av0atW
 t9hqMpAcGdW4SbUyZKmSOSd+YlbwGKNdD6WfYWTyEzICdgkDD0w9sM4vLp4oY9i0+I5D/s
 dNOmLMo8e7yKP2U1yZBOHkPKvDaLhKvj9DxFUsSN8bABxScYUK6yIdXlqeFsbRDt+wk7c4
 kvHyI7hjY2t5z2YVBVNHsqYSKqGW+DG2/TPqmSbklG7oUZCmxm5l3r7wnnk6rIfkS8A7Va
 sguCM4GL4nhWAwPbS2G9vdH00Fudh92BSslQrn7pJwyRBDGSW9Q3cY47KyfFoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651872716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
 b=3yzJVIl7aCbWJSTq+FwrDzYos2+d1FJ1UOnv4pyL8gSCEpD/WyUdjoYCOlOsOeDopNjtU5
 7RCkeX440NM7qOAg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs
 in non-IR format
In-Reply-To: <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 23:31:56 +0200
Message-ID: <87r156fiur.ffs@tglx>
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
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Joerg Roedel <joro@8bytes.org>, Ricardo Neri <ricardo.neri@intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> +	 *
> +	 * Also, NMIs do not have an associated vector. No need for cleanup.

They have a vector and what the heck is this cleanup comment for here?
There is nothing cleanup alike anywhere near.

Adding confusing comments is worse than adding no comments at all.

Thanks,

        tglx
