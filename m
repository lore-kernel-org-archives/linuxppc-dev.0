Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA949C072B5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 23:17:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20765217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 23:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="v6DWPkD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20765217D9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457s9Q5sYhzDqNs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 09:17:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457s7x4zWxzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 09:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="v6DWPkD5"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 457s7x3n3fz9sBV; Wed, 22 May 2019 09:15:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1558480557; bh=EcL5jNMwirXTp1nwjLDv8azqx1af2nZDnWeeqODaWl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v6DWPkD5rk7OkfCPQ49WmTUhjcF2pXpXnUrZJUWrYhes3yM7IQ52M3VzX4qFS5OS1
 ZLXtu3eTdfgvc5SRKiQEs4sFrzRizQg+Qhx03pOJfaxieNKjuocfy+7fsSbXrEuVbI
 ndHDx1830swdI81Tpp1TR4NaPYsFMu4/hM/C4MSsbI9ftiMyBrjJXQoadH96F4BeTB
 VriDTasIUIp6n14H05L2JNHNYBYj4wi+mq13YJ0avuuAvPw1OeU7HuwNs3C4iWhzaa
 mqmgipgEwEJFSYPyfUjwqceWTuTVHBUhSaVv59RXGsH0hSMA996B8k5Sl6r59r71de
 SRXEa4pymY3CA==
Date: Wed, 22 May 2019 09:15:54 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 02/12] powerpc: Add support for adding an ESM blob to
 the zImage wrapper
Message-ID: <20190521231554.GB3874@blackberry>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
 <20190521044912.1375-3-bauerman@linux.ibm.com>
 <20190521051326.GC29120@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521051326.GC29120@lst.de>
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
Cc: Anshuman Khandual <anshuman.linux@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Mike Anderson <andmike@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 Claudio Carvalho <cclaudio@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 21, 2019 at 07:13:26AM +0200, Christoph Hellwig wrote:
> On Tue, May 21, 2019 at 01:49:02AM -0300, Thiago Jung Bauermann wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > For secure VMs, the signing tool will create a ticket called the "ESM blob"
> > for the Enter Secure Mode ultravisor call with the signatures of the kernel
> > and initrd among other things.
> > 
> > This adds support to the wrapper script for adding that blob via the "-e"
> > option to the zImage.pseries.
> > 
> > It also adds code to the zImage wrapper itself to retrieve and if necessary
> > relocate the blob, and pass its address to Linux via the device-tree, to be
> > later consumed by prom_init.
> 
> Where does the "BLOB" come from?  How is it licensed and how can we
> satisfy the GPL with it?

The blob is data, not code, and it will be created by a tool that will
be open source.  My understanding is that most of it will be encrypted
with a session key that is encrypted with the secret key of the
ultravisor.  Ram Pai's KVM Forum talk last year explained how this
works.

Paul.
