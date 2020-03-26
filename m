Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07855C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:08:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7406520714
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="L+/P4EyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7406520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p3f74spYzDqcj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 23:07:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p3Ym4pfpzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 23:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=L+/P4EyO; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48p3Ym1hGvz9sRN; Thu, 26 Mar 2020 23:04:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48p3Yl5Vm9z9sQx;
 Thu, 26 Mar 2020 23:04:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585224251;
 bh=VkE+7elGnSpjnbVCvJAm88/od+dIQk44XdBkzZC2ewA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L+/P4EyO8Tngs4WMO/qZ+xEIGSyOSyVE5DbGFxQYgMzpW6K9jJuDmPeolcELMY4hd
 3JFBUc3osCAtRvbzQG/KATTtSHJjZHWr/l37lG717gtiMWQ5QLsST5ye1Z9WvGk28I
 dv/lep+svkLnBNMKzSxWktlHEzRj6Nj+OM2/mWMyvNq+ci29pBcguptnjkJNK0yppI
 nFy4H0Zgv8epwKwD8hE4PWtuyPLMcP7Mdp3vHQfAK5Lc1zVTWr2H+lm6Dy4gZkzweY
 mXH46B93bD3gpJAlx1Tw7Qxz07veT7ugbsca0g5hT+igR56qs4/2pjXnD/YMNP3PT6
 pG2d1u/3Ys2ow==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Add a test of sigreturn vs VDSO
In-Reply-To: <87k13xjpxr.fsf@linux.ibm.com>
References: <20200304110402.6038-1-mpe@ellerman.id.au>
 <87mu8tjq7l.fsf@linux.ibm.com> <87k13xjpxr.fsf@linux.ibm.com>
Date: Thu, 26 Mar 2020 23:04:19 +1100
Message-ID: <87ftdvwce4.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> +static int search_proc_maps(char *needle, unsigned long *low, unsigned long *high)
>>
>>                                ^^ const?

Sorry I meant to do this but then forgot.

>>> +{
>>> +	unsigned long start, end;
>>> +	static char buf[4096];
>>> +	char name[128];
>>> +	FILE *f;
>>> +	int rc = -1;
>>> +
>>> +	f = fopen("/proc/self/maps", "r");
>>> +	if (!f) {
>>> +		perror("fopen");
>>> +		return -1;
>>> +	}
>>> +
>>> +	while (fgets(buf, sizeof(buf), f)) {
>>> +		rc = sscanf(buf, "%lx-%lx %*c%*c%*c%*c %*x %*d:%*d %*d %127s\n",
>>> +			    &start, &end, name);
>>
>> I suspect it doesn't matter in practice for this particular test, but
>> since this looks like a generally useful function that could gain users
>> in the future: does this spuriously fail if the matching line straddles
>> a 4096-byte boundary? Maybe fscanf(3) should be used instead?
>
> Or maybe I should read the fgets man page more closely :-)
>
>   "Reading stops after an EOF or a newline."
>
> Sorry for the noise.

No worries, thanks for reviewing.

cheers
