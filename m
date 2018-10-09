Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B8C67803
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:56:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1A420835
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1A420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Twgc1Py0zF3D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 22:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Twd102H5zF39g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 22:54:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Twcz5Ylpz9s89;
 Tue,  9 Oct 2018 22:54:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>, Geoff Levand <geoff@infradead.org>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] powerpc: signedness bug in update_flash_db()
In-Reply-To: <6fa5827e-3346-4057-ca44-c6d9758f5837@c-s.fr>
References: <20181001164458.GB29197@mwanda>
 <6fa5827e-3346-4057-ca44-c6d9758f5837@c-s.fr>
Date: Tue, 09 Oct 2018 22:54:27 +1100
Message-ID: <87in2b1gjw.fsf@concordia.ellerman.id.au>
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
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 01/10/2018 =C3=A0 18:44, Dan Carpenter a =C3=A9crit=C2=A0:
>> The "count < sizeof(struct os_area_db)" comparison is type promoted to
>> size_t so negative values of "count" are treated as very high values and
>> we accidentally return success instead of a negative error code.
>>=20
>> This doesn't really change runtime much but it fixes a static checker
>> warning.
>>=20
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>=20
>> diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platfor=
ms/ps3/os-area.c
>> index cdbfc5cfd6f3..f5387ad82279 100644
>> --- a/arch/powerpc/platforms/ps3/os-area.c
>> +++ b/arch/powerpc/platforms/ps3/os-area.c
>> @@ -664,7 +664,7 @@ static int update_flash_db(void)
>>   	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
>>=20=20=20
>>   	count =3D os_area_flash_write(db, sizeof(struct os_area_db), pos);
>> -	if (count < sizeof(struct os_area_db)) {
>> +	if (count < 0 || count < sizeof(struct os_area_db)) {
>
> Why not simply add a cast ? :
>
> if (count < (ssize_t)sizeof(struct os_area_db)) {

The explicit check against 0 is much clearer IMO.

The original author and all reviewers since obviously didn't realise
that count was being implicitly cast, so fixing that with another cast
seems likely to just confuse people even more :)

cheers
