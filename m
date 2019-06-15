Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF639C31E47
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:49:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FF2206B7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 07:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="KTBzlzh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FF2206B7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QqPZ6rGtzDrR4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 17:49:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QqMR239FzDrQN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 17:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="KTBzlzh+"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 45QqMR1CyRz9sNk; Sat, 15 Jun 2019 17:47:47 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45QqMR0FTCz9sNl; Sat, 15 Jun 2019 17:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1560584867; bh=RbVxzic/utIowZwLvmsu0ZqoiFt+kS5VBsZdtW+Utcc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTBzlzh+vKbi32BAVrbFzAP8ZM8khVQoraLTz72U4uRj7oMEImg8+W93wiW5V0gXI
 ZEpWauGXSgcX/5cnNlH4vSEOomomYA2sLQhsa2PD71CN23j5ZT5CyvZ2NWkVAEvINJ
 GZB0CxHVHVzvrysEdmAYNDUhH1WWhftXdOkiaz0kCLNPxvXDN/jbqnV1yIZQ/UtfNq
 fbgpRI59KkSFj23SIcT4DLepKdeKbQ88QpOdJSTU0hcN/l52oSHagT79kvq/enb0lN
 P+7AT1nympiM2xIPoOUCraD1XuEAC+344cmM6gEE93W0npUa6xmhd55bv/55uurDtF
 c6NcXiGObMKHw==
Date: Sat, 15 Jun 2019 17:43:34 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 7/9] KVM: PPC: Ultravisor: Restrict LDBAR access
Message-ID: <20190615074334.GD24709@blackberry>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
 <20190606173614.32090-8-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606173614.32090-8-cclaudio@linux.ibm.com>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 02:36:12PM -0300, Claudio Carvalho wrote:
> When the ultravisor firmware is available, it takes control over the
> LDBAR register. In this case, thread-imc updates and save/restore
> operations on the LDBAR register are handled by ultravisor.
> 
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

Just a note on the signed-off-by: it's a bit weird to have Ram's
signoff when he is neither the author nor the sender of the patch.
The author is assumed to be Claudio; if that is not correct then the
patch should have a From: line at the start telling us who the author
is, and ideally that person should have a signoff line before
Claudio's signoff as the sender of the patch.

Paul.
