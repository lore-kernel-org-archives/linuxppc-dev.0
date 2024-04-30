Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF51C4345F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2024 03:55:39 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=IJl+WCBU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VT5vZ2VnKz3bq0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2024 13:55:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=IJl+WCBU;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VT5tk5DL2z2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2024 13:54:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714449294;
	bh=xCWb0CB+X6parJaIVgRXRyhjhhCpOlkcY/roGDJcTuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IJl+WCBU3JsnE5wXYWK6iZpGGRI2OyWD1KrdwiLkFpFBwZdLIW43dd376ibLddqNW
	 o3MGoNoKJAr6Grp00sbxsm7ZCRYRZy00rvK/jfCRaAkVLDhSF2gM4ZeRPaK0FclMhe
	 dW9vITgU4fkOMZJ0gwZjHJwZZuT7HGwJnxLXBN63GYVdWzvx6VbwkNcxE1E/Dshkgh
	 yydjhuDB7q98avUhymCMD0/lM6HHuPb+s7hgvLq6SKpVgbEoUU6PKC8h5f84yc6Nv0
	 0FkbhB1gGSQWHaWt0HNsZjzrG4yQKURKzo8c0U4wTgANjszZsEPBwT3+5fgxb09qDy
	 OA9wYPH6Iz4Qg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT5tk42jYz4wyS;
	Tue, 30 Apr 2024 13:54:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, nathanl@linux.ibm.com
Subject: Re: [PATCH v2 0/2] powerpc/pseries: Fixes for lparstat boot reports
In-Reply-To: <cabc8249-4ef4-4d57-afb4-93b95120a51e@linux.ibm.com>
References: <20240412092047.455483-1-sshegde@linux.ibm.com>
 <cabc8249-4ef4-4d57-afb4-93b95120a51e@linux.ibm.com>
Date: Tue, 30 Apr 2024 13:54:52 +1000
Message-ID: <87cyq7ec8j.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: naveen.n.rao@linux.ibm.com, tyreld@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> On 4/12/24 2:50 PM, Shrikanth Hegde wrote:
>> Currently lparstat reports which shows since LPAR boot are wrong for
>> some fields. There is a need for storing the PIC(Pool Idle Count) at
>> boot for accurate reporting. PATCH 1 Does that.
>> 
>> While there, it was noticed that hcall return value is long and both
>> h_get_ppp and h_get_mpp could set the uninitialized values if the hcall
>> fails. PATCH 2 does that.
>> 
>> v1 -> v2:
>> - Nathan pointed out the issues surrounding the h_pic call. Addressed
>> those.
>> - Added a pr_debug if h_pic fails during lparcfg_init
>> - If h_pic fails while reading lparcfg, related files are not exported.
>> - Added failure checks for h_get_mpp, h_get_ppp calls as well.
>> 
>> v1: https://lore.kernel.org/all/20240405101340.149171-1-sshegde@linux.ibm.com/
>> 
>> Shrikanth Hegde (2):
>>   powerpc/pseries: Add pool idle time at LPAR boot
>>   powerpc/pseries: Add fail related checks for h_get_mpp and h_get_ppp
>> 
>>  arch/powerpc/include/asm/hvcall.h        |  2 +-
>>  arch/powerpc/platforms/pseries/lpar.c    |  6 ++--
>>  arch/powerpc/platforms/pseries/lparcfg.c | 45 +++++++++++++++++-------
>>  3 files changed, 37 insertions(+), 16 deletions(-)
>> 
>> --
>> 2.39.3
>> 
>
> Ping. 
>
> Michael, Nathan, Naveen
> Any comments on these patches?

Looks fine. I have it in next-test, will probably go into next tomorrow.

cheers
