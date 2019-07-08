Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B55AC606D1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 22:55:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4728216FD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 22:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JeKYvjEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4728216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jLPq0TBZzDqRh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 08:55:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="JeKYvjEH"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jLMs1LdGzDqN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 08:53:27 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id d79so10331409qke.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jul 2019 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
 b=JeKYvjEHv0d4lyie/kiBQRbHspieZhhHk1xlxebuNCuhUGu2Ujj2J5Hn94dfSTuN5U
 ib5PxKy6G0Fdrb8Kf9ZgN46yBcwla5TU9ZmG2/D+e81sTwZio+uWzaJAYYn6t99E6fno
 HZfkywo1Z3Y+s5YbXpcAAhsdJMHg7y81D9tjheXnlxscc6Y0jHCY1EmbsmteXyTI+F0g
 vZaVU90UeK6qQBW4YH523XTj9x4L3JVIFaq9mSiXf478G+zEYS7E6QoXBHxc8xOLnQh+
 s6UjLSgZgRdsU1nZlZA9ZjPbJAueUs8VveDaz+i6ViBZwsNp9BacpUNiDce5RoXVLNln
 V29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
 b=EgY5Fq4UTAxkvjXbkVD2P0Hm3MTV9DOyqRC4CmVoeeeycgA8DSqsuKbjC1BdLmOP4S
 NmZxmxbfBQfcmfCp6nvytXW7EIbaPBI20wgzgMNc5OvmCwOs2nyOkEBSjidvKaZIItuH
 U0/1OZASyNTjnpGRwf3eis0Xwpqkzr6LB30EekKnFt1q2D3UoE6n30eHskbOwKr/nEbi
 LlY8grKQhEleA6cwdzxWTfbBZF2Ku8yqy0IbpvdTHSdQKsrbakoTuSuhdrt32z0s+XWZ
 vA1dxGfmgsp5hpHiYB98qn2aRnOAuNQOw5Er+FcJZoJtWtdoWATgqBxq28g1J1Rmw4vB
 Tr5Q==
X-Gm-Message-State: APjAAAWwEX64uljgmxQVACuLU+ZOEH/feQFwK//p9Z17ulYtW/UzvvAN
 esp1aJtEI+8+DKsJ0Ux7COggWw==
X-Google-Smtp-Source: APXvYqyFDUHN3AlkoWFUd96BfJL00iwdanUkLj+AoJmRBkQWg8dkdiXjQmnE8o1TBO3LPzxpRgT1Kw==
X-Received: by 2002:a37:4a04:: with SMTP id x4mr16546587qka.408.1562626404157; 
 Mon, 08 Jul 2019 15:53:24 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.55.100])
 by smtp.gmail.com with ESMTPSA id n18sm7889774qtr.28.2019.07.08.15.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Jul 2019 15:53:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1hkcVf-000384-Ac; Mon, 08 Jul 2019 19:53:23 -0300
Date: Mon, 8 Jul 2019 19:53:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190708225323.GG23996@ziepe.ca>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
 <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
 <1562624644.11461.66.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562624644.11461.66.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, Nayna Jain <nayna@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, linux-integrity@vger.kernel.org,
 George Wilson <gcwilson@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Peter Huewe <peterhuewe@gmx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 08, 2019 at 06:24:04PM -0400, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Mon, 2019-07-08 at 18:11 +0300, Jarkko Sakkinen wrote:
> > On Sat, 2019-07-06 at 20:18 -0400, Nayna Jain wrote:
> > > +/*
> > > + * tpm_get_pcr_allocation() - initialize the chip allocated banks for PCRs
> > > + * @chip: TPM chip to use.
> > > + */
> > > +static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > > +		rc = tpm2_get_pcr_allocation(chip);
> > > +	else
> > > +		rc = tpm1_get_pcr_allocation(chip);
> > > +
> > > +	return rc;
> > > +}
> > 
> > It is just a trivial static function, which means that kdoc comment is
> > not required and neither it is useful. Please remove that. I would
> > rewrite the function like:
> > 
> > static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > {
> > 	int rc;
> > 
> > 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> >      	     tpm2_get_pcr_allocation(chip) :
> >      	     tpm1_get_pcr_allocation(chip);
> 
> > 
> > 	return rc > 0 ? -ENODEV : rc;
> > }
> > 
> > This addresses the issue that Stefan also pointed out. You have to
> > deal with the TPM error codes.
> 
> Hm, in the past I was told by Christoph not to use the ternary
> operator.  Have things changed?  Other than removing the comment, the
> only other difference is the return.

I also dislike most use of ternary expressions..

Also, it is not so nice that TPM error codes and errno are multiplexed
on the same 'int' type - very hard to get this right. I'm not sure
anything actually needs the tpm error, and if it does maybe we should
be mapping those special cases to errno instead.

Jason
