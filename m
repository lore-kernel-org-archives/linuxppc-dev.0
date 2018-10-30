Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9CC6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9032320870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="GgWE6+oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42khZG3n3rzDrNX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 17:36:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="GgWE6+oy";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42khVP4ZZKzF1Q0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 17:33:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="GgWE6+oy"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42khVP1gfTz9s9J; Tue, 30 Oct 2018 17:33:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540881181; bh=PcNtQ0ZOfUbLJ03aA5rGKbE98WVcmcvXJmKDgdihuk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GgWE6+oyhZfz8xCBOgzFVw0CGC154DBzbfjusYXbF/fDclyb6DYGUuRcX7ETH+2O6
 JFJXcTef4AvNZpWUO9liMT+uaOAy3ikDKyto7Up3h83oMBCbkgGG+xZd2bLhOkgUsE
 XB5kVqQYn0y9Cy1GTfnjC0ntJMj/VD+Upwjn0SPhX3pfufT6cP8a425s/eV4RmjxPK
 O6ZZwk3/4woGwNqEDbKDajdXDb+ZfbNE/UoTtEu+9iXytx4emu5IdL8ViXJO//XsC7
 dnYt/ZlyCrqdYiMym2mFf0PskDNaANpSm3iBliDh6AsAPkLe89rxmvdy9ouMchD87u
 sEWg1o+gqc4NQ==
Date: Tue, 30 Oct 2018 17:32:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH v1 1/4] kvmppc: HMM backend driver to manage pages of
 secure guest
Message-ID: <20181030063258.GA14878@blackberry>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-2-bharata@linux.ibm.com>
 <20181030050300.GA11072@blackberry>
 <20181030063155.GB5494@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030063155.GB5494@ram.oc3035372033.ibm.com>
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
Cc: kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 benh@linux.ibm.com, linux-mm@kvack.org, jglisse@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, paulus@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 11:31:55PM -0700, Ram Pai wrote:
> On Tue, Oct 30, 2018 at 04:03:00PM +1100, Paul Mackerras wrote:
> > On Mon, Oct 22, 2018 at 10:48:34AM +0530, Bharata B Rao wrote:
> > > HMM driver for KVM PPC to manage page transitions of
> > > secure guest via H_SVM_PAGE_IN and H_SVM_PAGE_OUT hcalls.
> > > 
> > > H_SVM_PAGE_IN: Move the content of a normal page to secure page
> > > H_SVM_PAGE_OUT: Move the content of a secure page to normal page
> > 
> > Comments below...
> > 
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > > ---
> > >  /* pSeries hypervisor opcodes */
> ....
> > >  #define H_REMOVE		0x04
> > >  #define H_ENTER			0x08
> > > @@ -295,7 +298,9 @@
> > >  #define H_INT_ESB               0x3C8
> > >  #define H_INT_SYNC              0x3CC
> > >  #define H_INT_RESET             0x3D0
> > > -#define MAX_HCALL_OPCODE	H_INT_RESET
> > > +#define H_SVM_PAGE_IN		0x3D4
> > > +#define H_SVM_PAGE_OUT		0x3D8
> > > +#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
> > 
> > We should define hcall numbers in the implementation-specific range.
> > We can't use numbers in this range without first getting them
> > standardized in PAPR.  Since these hcalls are not actually used by
> > the guest but are just a private interface between KVM and the
> > ultravisor, it's probably not worth putting them in PAPR.  We should
> > pick a range somewhere in the 0xf000 - 0xfffc area and use that.
> 
> We are using that range for Ucalls.  For hcalls we were told to reserve
> a range between 1024(0x400) to  2047(0x7FF). Have to reserve them in the
> appropriate database.

Who gave you that advice?

Paul.
