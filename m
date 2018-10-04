Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A389C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:36:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A60213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HcrovXDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A60213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QnpB14zxzF3K5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 19:36:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HcrovXDW";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QnhT4m5czF3HC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HcrovXDW"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QnhT35lZz9sB5; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42QnhT2YB5z9s8J; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538645497; bh=kHu7eTXTFLhStg46p+AfnPsp/0+Xw5lB8M6GDc+tgdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HcrovXDWLndMg6IBLJ7eTVymlW6l0rXPBXglcqcxUT5fYbluUIubSIZei9d3hLdsb
 HxnnIn9GGkMsMacT3wqVczfhElfOGaWGTQUhvkfc3rsb2joIYPtZKT8wwqZqfHRDRV
 ODQCb0dFzxqP0hIG/ji+YS6MGjIZ2sdqao9SSXRFdQkZvgj1E9xEhpWacg9u72tK6a
 RmcJCEbcvXP5Ur1e00+rcmR5wPQFHB1hbZcWn+/oKuczmqV47CahmxW3k+lVVYxM3r
 e33GjfXwuD1hhWDbyfNWyQ16w79nhsuzEilV6Wwvwdn0hJ8v7IdEGyZE6Tena7O0DP
 6nrZ0e7yYfzrQ==
Date: Thu, 4 Oct 2018 19:29:38 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 29/33] KVM: PPC: Book3S HV: Handle differing
 endianness for H_ENTER_NESTED
Message-ID: <20181004092938.GB3255@fergus>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-30-git-send-email-paulus@ozlabs.org>
 <20181003061336.GV1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003061336.GV1886@umbus.fritz.box>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 03, 2018 at 04:13:36PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:28PM +1000, Paul Mackerras wrote:
> > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > 
> > The hcall H_ENTER_NESTED takes as the two parameters the address in
> > L1 guest memory of a hv_regs struct and a pt_regs struct which the
> > L1 guest would like to use to run a L2 guest and in which are returned
> > the exit state of the L2 guest.  For efficiency, these are in the
> > endianness of the L1 guest, rather than being always big-endian as is
> > usually the case for PAPR hypercalls.
> 
> Does that actually make a difference for efficiency?  I thought the
> presence of the byte-reversing loads and stores meant byteswapping was
> basically zero-cost on POWER.

It means that the L1 hypervisor can pass a pointer to the regs struct
in the kvm_vcpu struct rather than having to make a copy, and copy the
values back after the H_ENTER_NESTED.  I'll reword the commit message
to say it's mostly about convenience and to a lesser extent about
performance.

Paul.

