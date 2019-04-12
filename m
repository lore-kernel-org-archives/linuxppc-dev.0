Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F7C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 14:11:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A022171F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4ePoQ7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A022171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gfvD2PTnzDqRh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:11:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gflJ4kR7zDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 00:04:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="d4ePoQ7q"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44gflF3Qspz8t9Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 00:04:09 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44gflF10kTz9s9y; Sat, 13 Apr 2019 00:04:09 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="d4ePoQ7q"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44gflD3MPFz9s8m
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Apr 2019 00:04:08 +1000 (AEST)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 54AA82083E;
 Fri, 12 Apr 2019 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555077845;
 bh=JnUies5H0KZQuTMhBT1bwryBTiqMMk1nnpjRG5vQINM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d4ePoQ7qTz+PVKRZJ/rkLhFmAR5loYKwFJ77OMK8QvjUQfAxrkbRCs5LRVzGfAPpg
 D8vW3Yn/IJApzx+EAWpHbuFCjpx3BdtKsFgfLJKXiznkMplAFOSCk5gER7gmZtBo/K
 EEMFXExyV1LRA6yIdb3NE9iLi1dvhEIUxCoGqaBk=
Date: Fri, 12 Apr 2019 10:04:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH stable v4.9 00/35] powerpc spectre backports for 4.9
Message-ID: <20190412140404.GP11568@sasha-vm>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
 <20190411152543.GN11568@sasha-vm>
 <87ef68ufda.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ef68ufda.fsf@concordia.ellerman.id.au>
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
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, diana.craciun@nxp.com,
 linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 12:28:01PM +1000, Michael Ellerman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> On Thu, Apr 11, 2019 at 09:45:55PM +1000, Michael Ellerman wrote:
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>Hi Greg,
>>>
>>>Please queue up these powerpc patches for 4.9 if you have no objections.
>>>
>>>There's one build fix for newer toolchains, and the rest are spectre related.
>>
>> I've queued it up, thank you.
>
>Thanks. I'll fix my script to generate "Hi Sasha" for v4.9 mails :)

Hah :)

Sasha "Greg" Levin.
