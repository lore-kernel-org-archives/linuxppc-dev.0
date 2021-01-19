Return-Path: <SRS0=EbLt=GW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B27C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 02:13:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B222229C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 02:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B222229C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKXJL2kS5zDr27
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 13:13:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKXGR4bsLzDqwC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2021 13:11:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=L5GUSdpn; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DKXGP6kwPz9sW0;
 Tue, 19 Jan 2021 13:11:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1611022318;
 bh=XdDjocR66FjgT9c3Vu9dMdlGS/UuVcCUJTKfZcyx08Q=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=L5GUSdpnYiqB4akSEJGDG1VFndEgc8hdHJA+tKifLH2sXkBmAYuIxvA+FeJN4Bp5W
 yy3WMC/W/8hyGhIiGnFLPvbhYR+VsVKpwfagBdI5CPuq9KWX7lgDSxjCBIYZ/B8fqv
 DQk3BLH7r8mzt8605YD6O6k/R+K4K1N0EVTtmfDChEC9IIMa+gPMQ6GS1dqaim2Ywo
 EUeqJcysZlGKIRYYNf3M15aPplSKWBr9XoF5mCtf/ud6DixzpqyGQHRZEYu2C9Lf1i
 nl4+z99+iZDUMBjA0Kgd79pE56LhfQotDK70WIP23WFvL0nFkSwZ1pyZCrCWeA38t+
 D7aHB3JR98pDA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Christopher M. Riedl" <cmr@codefail.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/8] powerpc/uaccess: Add unsafe_copy_from_user
In-Reply-To: <C8LLSM3UC598.L4E2VMGJOI06@geist>
References: <C8LLSM3UC598.L4E2VMGJOI06@geist>
Date: Tue, 19 Jan 2021 13:11:56 +1100
Message-ID: <87pn21r7yr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Christopher M. Riedl" <cmr@codefail.de> writes:
> On Mon Jan 11, 2021 at 7:22 AM CST, Christophe Leroy wrote:
>> Le 09/01/2021 =C3=A0 04:25, Christopher M. Riedl a =C3=A9crit :
>> > Implement raw_copy_from_user_allowed() which assumes that userspace re=
ad
>> > access is open. Use this new function to implement raw_copy_from_user(=
).
>> > Finally, wrap the new function to follow the usual "unsafe_" convention
>> > of taking a label argument.
>>
>> I think there is no point implementing raw_copy_from_user_allowed(), see
>> https://github.com/linuxppc/linux/commit/4b842e4e25b1 and
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/8c74fc9ce8131cab=
b10b3e95dc0e430f396ee83e.1610369143.git.christophe.leroy@csgroup.eu/
>>
>> You should simply do:
>>
>> #define unsafe_copy_from_user(d, s, l, e) \
>> unsafe_op_wrap(__copy_tofrom_user((__force void __user *)d, s, l), e)
>>
>
> I gave this a try and the signal ops decreased by ~8K. Now, to be
> honest, I am not sure what an "acceptable" benchmark number here
> actually is - so maybe this is ok? Same loss with both radix and hash:
>
> 	|                                      | hash   | radix  |
> 	| ------------------------------------ | ------ | ------ |
> 	| linuxppc/next                        | 118693 | 133296 |
> 	| linuxppc/next w/o KUAP+KUEP          | 228911 | 228654 |
> 	| unsafe-signal64                      | 200480 | 234067 |
> 	| unsafe-signal64 (__copy_tofrom_user) | 192467 | 225119 |
>
> To put this into perspective, prior to KUAP and uaccess flush, signal
> performance in this benchmark was ~290K on hash.

If I'm doing the math right 8K is ~4% of the best number.

It seems like 4% is worth a few lines of code to handle these constant
sizes. It's not like we have performance to throw away.

Or, we should chase down where the call sites are that are doing small
constant copies with copy_to/from_user() and change them to use
get/put_user().

cheers
