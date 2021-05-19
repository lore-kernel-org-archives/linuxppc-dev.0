Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE10C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 11:53:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C292611AE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 11:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C292611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlWTZ47X8z3bVD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 21:53:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=dGIC66MH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.53;
 helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=dGIC66MH; 
 dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlWSz4zFkz2yXd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 21:52:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1621425137; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=jI38wZBHTCRDplP91ndDQ4WC1vFffPW1zcTAPw6BB3Pyp5+f7HCkpv/U5Weg0jbufM
 AiMpbg0s9dwNs7uTW2TwurEvuDaCT6723HCmcgZ0+rqfMuvrVpW7DInbXo8uXhmFBezv
 04UD3dcu/sMHjwmxU0Ly0aZyni8O0ZLbIfJPPridqxp8drvIDUKBIMbJL/TLRqklJGR7
 KvBFXgK+tZoIKThFe9sh+0iPUMcUnToP5p7zVVNVcDquzVo01PKkV46Zm4scLuMEFT34
 t6fod1CJaygr9zRbrKatmscXWXiHAFUoQE+2NPaGDGmXokGGTsyZoptTnyA2+7d7DCNC
 xiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621425137;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
 From:Subject:Sender;
 bh=pfRboCO9rmBGzYQrUB0iPICyNMC4oZ5fcKmhzF7+HYU=;
 b=ovvVBGss3bxLqqvHsWeBgxkR3LrVLID5nKk7mfDC2CMY9Y2mdjaE7x59s5igHW7Qx6
 u6MwXbMj3c1iu96vi65q06c29g5sNRmwopJ1OqaVE5hGFrKTj7Dck9TpwKpO72SVxckF
 5W/hovjVDCafXQcMAqG582VxxWUQM6yP9ZQ0vC6f7Bvl9DHLEWNy+lqr6shadMxCy8St
 NJzf/dFe4rDGTgsvGxIxYF/Aoe2y2PiYepIMv3SZj6EGe62N3QJTcyZzy1Hqauuvbtj6
 V+g5xYwgX9Nmu7eNnRDez+z/arOn/VeYPV7ENscBfKIRbknj6RxW+u/nWfxcDyq0qwut
 Dqug==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621425137;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
 From:Subject:Sender;
 bh=pfRboCO9rmBGzYQrUB0iPICyNMC4oZ5fcKmhzF7+HYU=;
 b=dGIC66MH6GNjjwiY0zKEe4vnpF7U9pR/wxc0VPm/hZqWhFPJgdFSsH5Q6HHLaF1mUB
 t5CvrfWYOuQLwkqB+s4sEVoGOI7v5bOcW9xGihXZmznO1kWz9mxIrsybhskGnQd1KBSA
 vnKFk9pk4pKkI8QITamEnWWjEfM5ZYNUqkwjknlC5K6seHxNJdpIvOWti+0BVbf0uzfk
 jbklvIBN4ZeQMMQh2j2MGitQ8vSDkpI78uUAzLNKqbTkbd+zdZHferHLKwNiOitGVlgf
 wd5I5v4iMqFhEARSdNMWAlpqfhxOo0Vjqno141ef991LCkHzgq/BmmxS2k1ZI1MCSwqK
 ig6w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgGIu/IwJXRU14Nr6IowH7cx9oU"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:e411:e463:f7e:f91a]
 by smtp.strato.de (RZmta 47.26.1 AUTH)
 with ESMTPSA id i0437dx4JBqH01n
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 19 May 2021 13:52:17 +0200 (CEST)
Subject: Re: [FSL P50x0] KVM HV doesn't work anymore
To: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <04526309-4653-3349-b6de-e7640c2258d6@xenosoft.de>
 <34617b1b-e213-668b-05f6-6fce7b549bf0@xenosoft.de>
 <9af2c1c9-2caf-120b-2f97-c7722274eee3@csgroup.eu>
 <199da427-9511-34fe-1a9e-08e24995ea85@xenosoft.de>
 <1621236734.xfc1uw04eb.astroid@bobo.none>
 <e6ed7674-3df9-ec3e-8bcf-dcd8ff0fecf8@xenosoft.de>
 <1621410977.cgh0d6nvlo.astroid@bobo.none>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <acf63821-2030-90fa-f178-b2baeb0c4784@xenosoft.de>
Date: Wed, 19 May 2021 13:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1621410977.cgh0d6nvlo.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Darren Stevens <darren@stevens-zone.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 19 May 2021 at 09:57 am, Nicholas Piggin wrote:
> Excerpts from Christian Zigotzky's message of May 17, 2021 7:42 pm:
>> On 17 May 2021 at 09:42am, Nicholas Piggin wrote:
>>> Excerpts from Christian Zigotzky's message of May 15, 2021 11:46 pm:
>>>> I tried it but it doesn't solve the issue. The uImage works without 
>>>> KVM
>>>> HV in a virtual e5500 QEMU machine.
>>> Any more progress with this? I would say that bisect might have just
>>> been a bit unstable and maybe by chance some things did not crash so
>>> it's pointing to the wrong patch.
>>>
>>> Upstream merge of powerpc-5.13-1 was good and powerpc-5.13-2 was bad?
>>>
>>> Between that looks like some KVM MMU rework. You could try the patch
>>> before this one b1c5356e873c ("KVM: PPC: Convert to the gfn-based MMU
>>> notifier callbacks"). That won't revert cleanly so just try run the
>>> tree at that point. If it works, test the patch and see if it fails.
>>>
>>> Thanks,
>>> Nick
>> Hi Nick,
>>
>> Thanks a lot for your answer. Yes, there is a little bit of progress.
>> The RC2 of kernel 5.13 successfully boots with -smp 3 in a virtual e5500
>> QEMU machine.
>> -smp 4 doesn't work anymore since the PowerPC updates 5.13-2. I used
>> -smp 4 before 5.13 because my FSL P5040 machine has 4 cores.
>>
>> Could you please post a patch for reverting the commit before
>> b1c5356e873c ("KVM: PPC: Convert to the gfn-based MMU notifier callbacks")?
> You could `git checkout b1c5356e873c~1`
>
> Thanks,
> Nick
Hi Nick,

Thanks for your answer. I checked out the commit b1c5356e873c~1 (HEAD is 
now at d923ff258423 KVM: MIPS/MMU: Convert to the gfn-based MMU notifier 
callbacks).
The kernel boots with '-smp 4' without any problems.
After that I patched with the probable first bad commit (KVM: PPC: 
Convert to the gfn-based MMU notifier callbacks). The kernel also boots 
with this patch. That means, this isn't the first bad commit.
Further information: 
https://forum.hyperion-entertainment.com/viewtopic.php?p=53267#p53267

Cheers,
Christian
