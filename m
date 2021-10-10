Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EBC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Oct 2021 05:34:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3020260F5B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Oct 2021 05:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3020260F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRrGJ2Dyvz2ywT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Oct 2021 16:34:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=smXj9SNP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=smXj9SNP; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRrFX3dt6z2yNL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Oct 2021 16:33:51 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06EC960F57;
 Sun, 10 Oct 2021 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633844027;
 bh=fFtb1mrI1ST0Z8ENmJv/UKksOGpmgzo0n0USEL4Xz6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=smXj9SNPXY/VYJ7AwIAIvQr4XCStM2hHJtZQ52RReVdA1DR3fY6BMbjoILsiYXcwh
 LzZBmcysuTwVBN1I7oual3OdQG2egw9nzEpa0t649Lm+Cwnop68l+yIPNjj2bTErdx
 9Ws+cgeAupflqf4h+gvutPzjmvOuBurPcGpE1nhM=
Date: Sun, 10 Oct 2021 07:33:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWJ7NuapWOZ4QirJ@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
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
Cc: arnd@arndb.de, amit@kernel.org, jirislaby@kernel.org,
 shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 osandov@fb.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 09, 2021 at 11:45:23PM +0800, Xianting Tian wrote:
> 
> 在 2021/10/9 下午7:58, Greg KH 写道:
> > Did you look at the placement using pahole as to how this structure now
> > looks?
> 
> thanks for all your commnts. for this one, do you mean I need to remove the
> blank line?  thanks
>

No, I mean to use the tool 'pahole' to see the structure layout that you
just created and determine if it really is the best way to add these new
fields, especially as you are adding huge buffers with odd alignment.

thanks,

greg k-h
