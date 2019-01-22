Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB8C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3630220879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uBQNfBoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHbl1JngzDqMy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:51:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPt45PGzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="uBQNfBoB"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPt25Qsz9sCh; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135778; bh=G94owmsA7fGeAcbs0wwECohTdERIr4dOKj3trQI01tI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uBQNfBoBlQvnQGDaD5hkSyIq8Fl8ksPcBKZUDTayRKlU5CmMZ8RAmp8f8fAh3PDOH
 b1ColnXGtlypXCZbqcsijEq42+U3HhNNfuRTMyiu/KyjDh3xNLJ98wG7jMetPo28MP
 u4YGG/OUAUyyP1d7vPPO0LVvNQNhbdm5NUSrKtsidA+9mJVLLpq8XG75ODFS+4lUn6
 vav4Y6NKVg/Apyvg2mn2ciTXwZxPlMzpdRZfUQMiaUv2+sHU5HGyyeE6PURp8J+iH8
 +RYSrlp4HIu7q6SqgXq+GiQlTIdey/hhzVuo94AKO0uvQOSDU40bCG2ZmoHOh0Ac/y
 Kv2bxbIRjQz8Q==
Date: Tue, 22 Jan 2019 16:42:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 19/19] KVM: introduce a KVM_DELETE_DEVICE ioctl
Message-ID: <20190122054253.GH15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107191006.10648-3-clg@kaod.org>
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

On Mon, Jan 07, 2019 at 08:10:06PM +0100, Cédric Le Goater wrote:
> This will be used to destroy the KVM XICS or XIVE device when the
> sPAPR machine is reseted. When the VM boots, the CAS negotiation
> process will determine which interrupt mode to use and the appropriate
> KVM device will then be created.

What would be the consequence if we didn't destroy the device?

The reason I ask is that we will have to be much more careful about
memory allocation lifetimes with this patch.  Having KVM devices last
until the KVM instance is destroyed means that we generally avoid
use-after-free bugs.  With this patch we will have to do a careful
analysis of the lifetime of the xive structures vs. possible accesses
on other threads to prove there are no use-after-free bugs.

For example, it is not sufficient to set any pointers in struct kvm or
struct kvm_vcpu that point into xive structures to NULL before freeing
the structures.  There could be code on another CPU that has read the
pointer value before you set it to NULL and then goes and accesses it
after you have freed it.  You need to prove that can't happen,
possibly using some sort of explicit synchronization that ensures that
no other CPU could still be accessing the structure at the time when
you free it.  RCU can help with this, but in general means you need
RCU synchronization primitives (rcu_read_lock() etc.) at all the
places where you use the pointer, which I don't think you currently
have.

If there is a good fundamental reason why this can't happen, even
though you don't have explicit synchronization, then at a minimum you
need to explain that in the patch description, and ideally also in
code comments.

Paul.
