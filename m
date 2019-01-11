Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F86C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 10:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E0920874
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 10:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E0920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bfL32whszDr3Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 21:31:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bfJC53hnzDr0s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 21:30:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43bfJC3kTcz9sCh; Fri, 11 Jan 2019 21:30:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43bfJC2FHjz9s4s;
 Fri, 11 Jan 2019 21:30:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 1/3] powerpc: Stop using pr_cont() in __die()
In-Reply-To: <996253a4-3deb-c320-f78a-15c8de261217@c-s.fr>
References: <20190110115737.30931-1-mpe@ellerman.id.au>
 <996253a4-3deb-c320-f78a-15c8de261217@c-s.fr>
Date: Fri, 11 Jan 2019 21:30:00 +1100
Message-ID: <871s5jfpw7.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 10/01/2019 =C3=A0 12:57, Michael Ellerman a =C3=A9crit=C2=A0:
>> Using pr_cont() risks having our output interleaved with other output
>> from other CPUs. Instead print everything in a single printk() call.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
>> ---
>>   arch/powerpc/kernel/traps.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>=20
>> v2: Use a single printk with (mostly) compile time checks rather than
>> constructing the string with seq_buf.
>>=20
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 64936b60d521..164fc92895be 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -257,24 +257,14 @@ static int __die(const char *str, struct pt_regs *=
regs, long err)
>>   {
>>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>
> Maybe this printk() should also be merge with the following to further=20
> limit risks of interleaving ?

Possibly yeah.

Though I was comparing it to other arches and I think we could improve
the info on that line. So I'll leave it for now.

cheers
