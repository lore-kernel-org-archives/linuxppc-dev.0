Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B4C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:45:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E410220733
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NhDElDY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E410220733
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47d3r20ByPzDqbh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 16:45:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47d3fD1sspzDqYq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 16:36:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NhDElDY9"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 47d3fC0xHGz9sS9; Wed, 18 Dec 2019 16:36:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1576647395; bh=arBhEw9NZmuhyzR9ri9+gjUXrFXvq5epgRZxiP5ucNg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NhDElDY9zmVJkVePcXc133bDxJpq78JWTKjRkTXTN6bvZxBcOMs/hpys48N9ukgp5
 7nr87BGLpPTjupTI3yUT9v/j+7oL4tN9jKYRu6RkJmW/tKHKcDW1YYaHFcfDBJ0RTs
 DibDDbf0taAlwZgPKYksGt895RCWB/0WCHTEGK6d4quXaHvrclxZt2LnGZsI25Ey/F
 G2m0THpYmB1CcvqPc2Bo2kI0b9cFWAonDWr7INs1X+72+hxT97NUjLcpbAlCQHdol8
 mCEqVeLIlhnEieHqyFkljrQlMYO+C6I2s9mKYosevnS/8uLY6sIDh5mlbdEHavlrAA
 H6IEgkuH1/f/A==
Date: Wed, 18 Dec 2019 16:32:50 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] KVM: PPC: Add skip_page_out parameter
Message-ID: <20191218053250.GB29890@oak.ozlabs.ibm.com>
References: <20191215021104.GA27378@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215021104.GA27378@us.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 14, 2019 at 06:11:04PM -0800, Sukadev Bhattiprolu wrote:
> 
> This patch is based on Bharata's v11 KVM patches for secure guests:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-November/200918.html
> ---
> 
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Fri, 13 Dec 2019 15:06:16 -0600
> Subject: [PATCH V3 1/2] KVM: PPC: Add skip_page_out parameter
> 
> Add 'skip_page_out' parameter to kvmppc_uvmem_drop_pages() which will
> be needed in a follow-on patch that implements H_SVM_INIT_ABORT hcall.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
