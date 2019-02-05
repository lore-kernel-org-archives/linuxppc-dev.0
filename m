Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E18C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:15:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85A720823
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Uu0Uerb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85A720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vJmZ4nDdzDqPD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 09:15:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vJkB3x4NzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 09:13:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Uu0Uerb8"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43vJk91dRXz9sDr; Wed,  6 Feb 2019 09:13:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1549404801; bh=6Ljkwx7omDo6K1qhkcmW+pc0EbnURQhuKPCR1guwhPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uu0Uerb8zXXyFWvl2KCGDqUgBTK2MdCZhPA5wT2OBjQI99KxUnE2ULz5KzcwPG6qY
 kjR+zd1bgrJuhUjDx8eJnYjtLw8GWmPnJVhpbcmdNBqiZjzFkQshQJeNYyq4LTxSW6
 W/FAQog7uoquYM8pggvI88ttU8AzBmHL/zdGZs2SkMr7H7PPbNt3O1aItqNwMmsx77
 yMAP3FuZh4veUoLAw4WF/bYThg/eP7FsKB+UK6rNHsHHMFEzqwt15SKlaqGwguQ2A1
 uPWo1eAhm+p3b9akzFTJMskhHskN5berz0b8nReisP8Erb0CjmgtI/23JLmHu+jTxC
 VrrR3RpJUMv8A==
Date: Wed, 6 Feb 2019 09:13:15 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190205221315.GB29038@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
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

On Tue, Feb 05, 2019 at 12:31:28PM +0100, Cédric Le Goater wrote:
> >>> As for nesting, I suggest for the foreseeable future we stick to XICS
> >>> emulation in nested guests.
> >>
> >> ok. so no kernel_irqchip at all. hmm. 
> 
> I was confused with what Paul calls 'XICS emulation'. It's not the QEMU
> XICS emulated device but the XICS-over-XIVE KVM device, the KVM XICS 
> device KVM uses when under a P9 processor. 

Actually there are two separate implementations of XICS emulation in
KVM.  The first (older) one is almost entirely a software emulation
but does have some cases where it accesses an underlying XICS device
in order to make some things faster (IPIs and pass-through of a device
interrupt to a guest).  The other, newer one is the XICS-on-XIVE
emulation that Ben wrote, which uses the XIVE hardware pretty heavily.
My patch was about making the the older code work when there is no
XICS available to the host.

Paul.
