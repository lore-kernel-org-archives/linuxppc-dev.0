Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01222C282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:22:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DB12175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="n+4DZsfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DB12175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qCw55VzfzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 17:22:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qCsn106FzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:20:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="n+4DZsfJ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43qCsm59F4z9s9h; Wed, 30 Jan 2019 17:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548829244; bh=gYyGRdl7q6/iXNQsE09fuBEeCAxiu9f0WOxhodYg43E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n+4DZsfJozkLVCG4p7nfuqom1tGC8o7UZzj9Y3nlMwJgYGbESQ4x3F+npjFIwT6ul
 JoRNNWd4yoeOtxnC1ShRyW7toKWohMIL8YzDQ9EWuuvNI3b0O5XkpN1zwyQQziiUjx
 4m0JDn277OlCeMfzZrhU0P1s8ZX/YGoT8vuAJQjLl87p8SwWp4MbepF4R1jUezZQ+y
 uytaS/0IhbMlTae6dJzgFhoPv6VjHgoaR8Co/pKUxFiVtJqHnMODSLPcyevWbxwiVD
 g1Nh5jzxGIYtJmXX/vOgQyQaxi6DZrqKy0gipAo0ImPQ6T5+SWb75mzV1vdzIXZdGq
 6h9b1v2X7ksnw==
Date: Wed, 30 Jan 2019 16:55:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190130055546.GC27109@blackberry>
References: <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
 <20190129041241.GA17660@blackberry>
 <2fd9b526-347d-a1d5-925b-bc633231de64@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd9b526-347d-a1d5-925b-bc633231de64@kaod.org>
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

On Tue, Jan 29, 2019 at 06:44:50PM +0100, Cédric Le Goater wrote:
> On 1/29/19 5:12 AM, Paul Mackerras wrote:
> > On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
> >>
> >> Is clearing the PTEs and repopulating the VMA unsafe ? 
> > 
> > Actually, now that I come to think of it, there could be any number of
> > VMAs (well, up to almost 64k of them), since once you have a file
> > descriptor you can call mmap on it multiple times.
> > 
> > The more I think about it, the more I think that getting userspace to
> > manage the mappings with mmap() and munmap() is the right idea if it
> > can be made to work.
> 
> We might be able to mmap() and munmap() regions of ESB pages in the RTAS 
> call "ibm,change-msi".  I think that's the right spot for it. 

I was thinking that the ESB pages should be mmapped for device
interrupts at VM startup or when a device is hot-plugged in, and
munmapped when the device is hot-removed.  Maybe the mmap could be
done in conjunction with the KVM_IRQFD call?

What is the reasoning behind doing it in the ibm,change-msi call?

Paul.
