Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08771C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 13:15:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386F720672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifatlMqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386F720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GWHf44t2zDrMD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 00:15:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="ifatlMqq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+5e80788e52907cbc6741+5591+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GWDT5yWRzDrBv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 00:12:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cg/FZeN/jTwq9z9tK6bfxxJ2iCsJ6q4oil+PxinbC3s=; b=ifatlMqqOUfqtdrB4WHZDwyUx
 Jh9+klzxMd+FBTl2dVsnxBiaHAhLwy4ld9gxtxHibCs0TDLjgM3RQdrGyAgo+gzzTodvoobJFhRGy
 bTNEOekJskyjcSSi3RiuCt/kNP9w2MHWJDrZ8Tg2CiiuoThl6ztMrk8Qs8fuwGC+1Xa6rK61hzmtG
 0+V4vbnoBJ/4knfNyF5NhlFdjWnjCQ8u2oVCbB/qOxlpQidAIz+x6M7LuuEkee9N4XeV1k32KxYnA
 AT6fD54VHRzCim7w3IQkOXDik/4Dmm3W8+pBJ//0iU84Qmin/V2Z7vOVsC3CaOgwpz7qJpPZ2zmYl
 0eEq4Ds2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gXnGB-00014U-0H; Fri, 14 Dec 2018 13:12:07 +0000
Date: Fri, 14 Dec 2018 05:12:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI: provide pcibios_sriov_add_vfs
Message-ID: <20181214131206.GA2606@infradead.org>
References: <20181212215453.GJ99796@google.com>
 <20181213175428.87520-1-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213175428.87520-1-sebott@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 13, 2018 at 06:54:27PM +0100, Sebastian Ott wrote:
> Move VF detection and device creation code to weak functions
> such that architectures can provide a different implementation.

No magic weak functions please.  If you really have a reason to
override the implementation add a proper Kconfig symbol and
an explicit override.
