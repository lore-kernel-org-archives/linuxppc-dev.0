Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB84C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 09:10:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7609610A1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 09:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7609610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZDZc2sM8z30D5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 19:10:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=E3frY2oi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.165;
 helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=E3frY2oi; 
 dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZDZ047QDz2yRK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 19:09:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1620119344; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=MB72LLSdG1gdHd8w89jq71sjrh7PBF3vTS4/W+uclZPUt8/qMIOq6JCc0e4r2GxZcb
 CeFUyy8U4spug4Bj3GUE3iNV/FN+srQD4kK+9fID5A63Au1i/EAfNSLsY2V3vMgoe1s3
 xB+yg+EoERVVV/COjNtI/xmWwKF1xmOVR6cgtQ6t5QWx+pOFRXFIqMzaxj3BEgz4fFSH
 6BXwloSBpWttNDeMBJMSfstMVv11ueJVOxupSbn2t8KsICDExa6h2apLttUIoOxM7UYA
 EjQ75IqZc7nU84Ow7KS8phGVAnX4qFALZRoKf0rXaITX1NdB9hgoYxTaFg+aPghCqQw1
 /2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620119344;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
 From:Subject:Sender;
 bh=S4EW5Ed1d6SIg/pmkDDVIVH3N2MMwVJ+pp6XuzJdmK0=;
 b=GbPPESo0eGJ3R32n05ZyFlNWtradTEM10IqBRhQQ7nHJSvKPH9xzMEhIl1OYyDkbT3
 HA13L5XksV+2VxQbAgxFPkeCpu5JX9OT/rdtjetFjP/Q+bevP+0w+1sT9/IWyhiRhXZv
 iCnGj5Y6QyBQpv6Bzr133VFRCZNZ+KcCnf8A6ERn5qHZHJU0iVsEov5ldiqYi7DAJIhK
 b54MgZrNQj2e6VT27W/h0qp7c8wrxT1E4qAbxVT1T7xUnt3Qq5ExbwFVc6Q963882mI4
 oGVA0SO/G/tjQiPfbptkr4i8O0DYwnQysbN0TYhcs1IM0Wu9QHss3ifw1S0KwqbfL+lg
 muMQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620119344;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
 From:Subject:Sender;
 bh=S4EW5Ed1d6SIg/pmkDDVIVH3N2MMwVJ+pp6XuzJdmK0=;
 b=E3frY2oipZxxtIfHV1hmFBzSC08H9G/K9fOurqjug/Lgu54qbWlao73ALjepVX/sbI
 pQtJgAHZzLfLElGs1gJaTpr2hHobCpFPYEnYlGanpJkl98u5GzVEScIjQDdwPrf5Fkv/
 Vn/2Zn2/sSw+GkhkA0RJ37uJjWUEEczjQkvrgv9f9VQnAsXgsImUjkWpnuXO6Ynz8yGu
 o3AjHNijAf9cIBM6DFFEAx1zbZ7RE7RmMVTlwNZd4BHnDLIWRS3YiFOyg4H2iZITS/z1
 /KGF5j2Lud7W/8cG75JKCL42Yv5KSaDMi7+stnxQwXQvuaCNoupCZCoM+ZTUq3MjV05u
 8K2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIhsJhhV/a8MrHM5J4CoqSoOzBQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:14dd:6e8f:db34:91bd]
 by smtp.strato.de (RZmta 47.25.6 AUTH)
 with ESMTPSA id D075c0x449930kM
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 4 May 2021 11:09:03 +0200 (CEST)
Subject: Re: [FSL P50x0] Xorg always restarts again and again after the the
 PowerPC updates 5.13-1
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <c5b0ac7c-525f-0208-7587-c90427eae137@xenosoft.de>
 <0886c1dc-e946-69cb-a0a9-57247acfd080@csgroup.eu>
 <9864cd72-f1aa-4cf5-1cda-b3a10233b24d@xenosoft.de>
 <1b0307be-05cd-ab62-8b22-75ffb59ff76b@csgroup.eu>
 <daace050-6233-77ea-4517-0fd3c4b21057@xenosoft.de>
 <30f559f4-b50a-de63-94e1-761022468684@csgroup.eu>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <c9a692b4-0ac0-d595-10fa-c3213b1518fc@xenosoft.de>
Date: Tue, 4 May 2021 11:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30f559f4-b50a-de63-94e1-761022468684@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Am 04.05.21 um 10:58 schrieb Christophe Leroy:
>
>
> Le 04/05/2021 à 10:29, Christian Zigotzky a écrit :
>> On 04 May 2021 at 09:47am, Christophe Leroy wrote:
>>> Hi
>>>
>>> Le 04/05/2021 à 09:21, Christian Zigotzky a écrit :
>>>> Hi Christophe,
>>>>
>>>> Thanks for your answer but I think I don't know how it works with 
>>>> the cherry-pick.
>>>>
>>>> $ git bisect start
>>>
>>> As you suspect the problem to be specific to powerpc, I can do
>>>
>>> git bisect start -- arch/powerpc
>>>
>>>
>>>> $ git bisect good 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
>>>> $ git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>>>
>>> You said that powerpc-5.13-1 is bad so you can narrow the search I 
>>> think:
>>>
>>> git bisect bad powerpc-5.13-1
>>> git bisect good 887f3ceb51cd3~
>> I tried it but without any success.
>>
>> git bisect bad powerpc-5.13-1
>>
>> Output:
>> fatal: Needed a single revision
>> Bad rev input: powerpc-5.13-1
>
> I don't understand, on my side it works. Maybe a difference between 
> your version of git and mine.
>
> In that case, just use the SHA corresponding to the merge:
>
> git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>
> Christophe
Do you use a BookE machine?
