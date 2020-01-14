Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C783C33CA9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 01:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16314207FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 01:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zyZWEDP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16314207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xXW70JcxzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 12:12:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=timur@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=zyZWEDP1; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xXSS5bL3zDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 12:10:16 +1100 (AEDT)
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DA47207FD;
 Tue, 14 Jan 2020 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578964214;
 bh=9RR/dsyUxAIKCBbgqeyDG6B1QWfHBZxDaXlbgrHe4nA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=zyZWEDP1p/ibljWUKQNAIFOjr2iMagsqkDSQ+sXqO7xpxJG8f5UraSfGLI92EJ0dh
 12OxdO2wk02foGD1uZ5cAHw3z/uBSf+zi42Uumas+zTnhZSO/BA8GVSpY1xHdu5ti/
 D6Yq1oHVUkWwb3O5uOAqbb9aKUnDcFS06rdFSO1A=
Subject: Re: [PATCH] evh_bytechan: fix out of bounds accesses
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200109183912.5fcb52aa@canb.auug.org.au>
 <CAOZdJXXiKgz=hOoiaTrxgbnwzyvp1Zfn3aCz+0__i17vyFngRg@mail.gmail.com>
 <20200114072522.3cd57195@canb.auug.org.au>
From: Timur Tabi <timur@kernel.org>
Message-ID: <6ec4bc30-0526-672c-4261-3ad2cf69dd94@kernel.org>
Date: Mon, 13 Jan 2020 19:10:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114072522.3cd57195@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: b08248@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, york sun <york.sun@nxp.com>,
 PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>, swood@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/13/20 2:25 PM, Stephen Rothwell wrote:
> The problem is not really the declaration, the problem is that
> ev_byte_channel_send always accesses 16 bytes from the buffer and it is
> not always passed a buffer that long (in one case it is passed a
> pointer to a single byte).  So the alternative to the memcpy approach I
> have take is to complicate ev_byte_channel_send so that only accesses
> count bytes from the buffer.

Ah, I see now.  This is all coming back to me.

I would prefer that ev_byte_channel_send() is updated to access only 
'count' bytes.  If that means adding a memcpy to the 
ev_byte_channel_send() itself, then so be it.  Trying to figure out how 
to stuff n bytes into 4 32-bit registers is probably not worth the effort.
