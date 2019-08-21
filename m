Return-Path: <SRS0=9oUV=WR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE7C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 16:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5072332A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV/oZ5n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5072332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DCtD0CfQzDrDD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 02:34:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DCnw3LXLzDrB0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 02:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kV/oZ5n9"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46DCnv37FWz8wVm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 02:30:43 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46DCnv0Sdcz9sDQ; Thu, 22 Aug 2019 02:30:43 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kV/oZ5n9"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46DCnt30lCz9s3Z;
 Thu, 22 Aug 2019 02:30:42 +1000 (AEST)
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7367216F4;
 Wed, 21 Aug 2019 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566405040;
 bh=gV2U9wxJ+o1VAHDvjn0nJpm8IHEuAW3n7lpukRD1/FE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kV/oZ5n9xXqyLF0Na9idXpoU8mK4hSSEEUmF6K82W6dFdai4zw6/w7E2ka1zOHleG
 Q6/BBUDxq8GiIaY+juXKmrYPRYHoShYKvVU5/D+EVtYLiGTPzjKNqmF+1Hy3iBuBNf
 5DmnJoL4ZQZ4UpDvXbPQQzo0QyPujgv5r+HmhUqg=
Date: Wed, 21 Aug 2019 09:30:38 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] x86/efi: move common keyring handler functions to
 new file
Message-ID: <20190821163038.GB28571@kroah.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-4-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566400103-18201-4-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 linux-integrity@vger.kernel.org, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 21, 2019 at 11:08:22AM -0400, Nayna Jain wrote:
> This patch moves the common code to keyring_handler.c

That says _what_ you are doing, but not _why_ you are doing it.  We have
no idea :(

