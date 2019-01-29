Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79ADC282C7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:14:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC002147A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="TwuWaQh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC002147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pY6L1lh8zDqNg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pY4Y5SpszDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 15:12:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TwuWaQh9"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43pY4Y3Xjxz9sDL; Tue, 29 Jan 2019 15:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548735165; bh=bD32aIVYjRJQf5VZA8UIAFhQqDDyZSz+PPu5olsSJNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TwuWaQh97bUvcGFn9N5CfmKr1LY07LjcACRliXrKukdVOYQLR2b0xBbSlbdHVVSfX
 ReTGRV4BS+djMDLEBejG47+6QxUtL2jrtKdEPX7YHBSc3wa1L5uMQ26t2uGhUQMIPG
 ElvqZTgxaiGUtoQfhETihw35criq71eroMZi1CMxQj1ZjfP1WkhKbp3xa5my1peMXV
 aRCDVNRuZIdsdUY7fb3FwtiKD+pP+UmUSiuckncBLdSAwupQna09eYEZKYvxzBnJPd
 B6I1Z5mnLyttqWegbYDsVK6Kwqa7mZ2btrB7AqxXbrTxWUUcSoqyzkqEo4P8PFssYi
 s5tgLttYbU0cw==
Date: Tue, 29 Jan 2019 15:12:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190129041241.GA17660@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
> 
> Is clearing the PTEs and repopulating the VMA unsafe ? 

Actually, now that I come to think of it, there could be any number of
VMAs (well, up to almost 64k of them), since once you have a file
descriptor you can call mmap on it multiple times.

The more I think about it, the more I think that getting userspace to
manage the mappings with mmap() and munmap() is the right idea if it
can be made to work.

Paul.

