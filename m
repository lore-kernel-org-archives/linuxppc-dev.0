Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78499C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 13:56:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55E821907
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTixeQLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E821907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wKc76t84zDq7k
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 00:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dTixeQLV"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wKYm28KTzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 00:54:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MslmhBf6sHBX+lTIZiGv5oF8ktq/q6NsQm5zdWGHpTQ=; b=dTixeQLVu7KVSglvTuT6y6NrB
 rYgagcrHhJjihyiiIkRYAiB55rstLOlgOmT/ytB6+MR4UHv2vN/3TX71ojKEKepM8SM2PM6G+vVRM
 SSi1Bqwl0MYMHTVCwd25Tkg7CkQwvFOQ1e5S8dLp8+Mo2W2npAnkDWxmP00Jx0CmqZmL7ayCGsO5k
 bopYRxg/SUtKwzZ3xaha6RLVrjXS93Tq3k7TytGPy6iLX1acucpccOyvne5HPEFRbNf5FPihb2+bX
 W4dPTweVdsHFZUub8DYpjK75j3A37u79TwYV91pIW4rBFkGuleAtWDlckD64Rgal0bkx4q9IA739A
 2OqF0klUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1grk7n-0003OL-U6; Thu, 07 Feb 2019 13:53:55 +0000
Date: Thu, 7 Feb 2019 05:53:55 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
Message-ID: <20190207135355.GU21860@bombadil.infradead.org>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 04:59:27PM +0000, Christophe Leroy wrote:
>  v3: Moved 'Returns:" comment after description.
>      Explained in the commit log why the function is defined static inline
> 
>  v2: Added "Returns:" comment and removed probe_user_address()

The correct spelling is 'Return:', not 'Returns:':

Return values
~~~~~~~~~~~~

The return value, if any, should be described in a dedicated section
named ``Return``.

