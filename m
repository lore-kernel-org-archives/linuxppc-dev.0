Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1983C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 12:00:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF7A217F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 12:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KKo4ghsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF7A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447y7L5gg5zDqT6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 23:00:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447y3l6bZhzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 22:57:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=samsung.com header.i=@samsung.com header.b="KKo4ghsA"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 447y3k2CMtz8t4q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 22:57:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 447y3j6cdSz9sCH; Tue, 26 Feb 2019 22:57:21 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=samsung.com
 (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com;
 envelope-from=b.zolnierkie@samsung.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=samsung.com header.i=@samsung.com header.b="KKo4ghsA"; 
 dkim-atps=neutral
X-Greylist: delayed 322 seconds by postgrey-1.36 at bilbo;
 Tue, 26 Feb 2019 22:57:19 AEDT
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 447y3g5Bhhz9s5c
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2019 22:57:17 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190226115151euoutp02c220c5f39232552c59e0c128351488e7~G57r5EpZ_1947719477euoutp02H
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2019 11:51:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190226115151euoutp02c220c5f39232552c59e0c128351488e7~G57r5EpZ_1947719477euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1551181911;
 bh=PjCVhQAp5EO97zKk2n8MxjOqBqvhq2DZ66r65l02p5g=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=KKo4ghsA4x01H+ngLh5rTkVbs7nScgDziiVVBh1L28s3npnI6FtAVEaqDvsJ97NHz
 3BAwUp5vOkY3mJKijoN4heTDICFBTK1kfNP+zR1WXR64U/R7i8cpr+98mxBlGkeU8N
 k7wltoYxTn4TXW9k5zamJXttsvDmI48tD6iGa8H8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190226115151eucas1p2954701bb893a53ac04ae811bfe581981~G57rkuxQZ1113411134eucas1p2N;
 Tue, 26 Feb 2019 11:51:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.14.04294.758257C5; Tue, 26
 Feb 2019 11:51:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f~G57q4_Uto1118211182eucas1p2c;
 Tue, 26 Feb 2019 11:51:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190226115150eusmtrp18aad98e7adf7e191e63e5c11726a0e32~G57q4ELZ72473024730eusmtrp1m;
 Tue, 26 Feb 2019 11:51:50 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-23-5c7528571d6f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.43.04128.658257C5; Tue, 26
 Feb 2019 11:51:50 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190226115150eusmtip1fecaf8dce064c30b5ea8c95713271591~G57qhGtOv1600816008eusmtip13;
 Tue, 26 Feb 2019 11:51:50 +0000 (GMT)
Subject: Re: Re: Kernel panic when loading the IDE controller driver
To: Christophe Leroy <christophe.leroy@c-s.fr>, sgosavi1
 <Sachin.Gosavi@emerson.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <37311a64-63ac-3ef2-9cdf-c19248cf7d77@samsung.com>
Date: Tue, 26 Feb 2019 12:51:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <40b6281d-3aed-bff1-79fc-09a293d37b7f@c-s.fr>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7rhGqUxBuv+C1p833KdyaKjmcli
 zvkWFotjOx4xWfy/8YbF4vmn8+wObB6t/T/YPLasvMnksXjnP3aPnbPusnusvHSR3ePzJrkA
 tigum5TUnMyy1CJ9uwSujN6mzSwFE0QrWl5fY29gnC/YxcjJISFgIvFt8yTmLkYuDiGBFYwS
 r/6fYYRwvjBK/DmynhXC+cwoMbd1IitMy915s1ggEssZJZY9PQ7V8p5RYuq05UwgVcICLhKv
 /11nBLFFBMIk1p7YxARSxCwwkVFixbtWZpAEm4CVxMT2VWBFvAJ2EouXXwazWQRUJX7NnQ+0
 joNDVCBCov+MOkSJoMTJmU9YQGxOoNZN6x+BjWEWkJdo3jqbGeK6RewSf2a7QdguErMP9kPF
 hSVeHd/CDmHLSJye3AP2gYTAdEaJN7+WQjnrGSXWnDnGBFFlLXH4+EWwI5gFNCXW79KHCDtK
 zLn+lQ0kLCHAJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfOlVDneEhsmjCZaQKj
 4iwkn81C8s0shL0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaa0/+Of9nBuOtP
 0iFGAQ5GJR7eE/eLY4RYE8uKK3MPMUpwMCuJ8N5QLY0R4k1JrKxKLcqPLyrNSS0+xCjNwaIk
 zlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwNjlxXm0OS1I0ONe3gGL1Udl1+n6Lzl464HTCXFf
 bbsGo4zULO25Vamup+7Kr7qz5esELh/lqHmCKkuXHOT16dkj/vDznwl7zkaenl2kdnjOo0Ms
 ru80BJM2rVK19ZdTN3i9OunrrJ2sL2YqudX8Ni2Mz7h+7ELBwlU3Y046TPUVKls5O9trvYwS
 S3FGoqEWc1FxIgDOT9CWMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7phGqUxBv9falt833KdyaKjmcli
 zvkWFotjOx4xWfy/8YbF4vmn8+wObB6t/T/YPLasvMnksXjnP3aPnbPusnusvHSR3ePzJrkA
 tig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN6m
 zSwFE0QrWl5fY29gnC/YxcjJISFgInF33iyWLkYuDiGBpYwSCyZ/Y+9i5ABKyEgcX18GUSMs
 8edaFxtEzVtGibZDjYwgCWEBF4nX/66D2SICYRL3519nhyjaxyTRPv01WAezwERGiVldIO2c
 HGwCVhIT21eBdfAK2EksXn4ZzGYRUJX4NXc+K4gtKhAhcethBwtEjaDEyZlPwGxOoN5N6x8x
 g9jMAuoSf+ZdgrLlJZq3zmaewCg4C0nLLCRls5CULWBkXsUoklpanJueW2ykV5yYW1yal66X
 nJ+7iREYRduO/dyyg7HrXfAhRgEORiUeXoVHxTFCrIllxZW5hxglOJiVRHhvqJbGCPGmJFZW
 pRblxxeV5qQWH2I0BXpiIrOUaHI+MMLzSuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGan
 phakFsH0MXFwSjUw8ryf1XxsflWghhbDvSlz7my8rXt0uy3v8rMcWXnOXrX2B9b/2tp9xrRE
 2ueztbWGT4mg1G3p1frzQw3XxGkuTzigO7NNTadywZXtO6vvL1YPk14464tofi/jEneRjasC
 wr8sT2c59dQ99UrLt6ui9Z+zfjwRqP38T6jp7N2a9t1tT/itDK5LK7EUZyQaajEXFScCABFz
 oLa4AgAA
X-CMS-MailID: 20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
 <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
 <40b6281d-3aed-bff1-79fc-09a293d37b7f@c-s.fr>
 <CGME20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f@eucas1p2.samsung.com>
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
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 02/14/2019 06:54 PM, Christophe Leroy wrote:
> 
> 
> Le 13/02/2019 à 16:27, Christophe Leroy a écrit :
>>
>>
>> Le 13/02/2019 à 13:53, sgosavi1 a écrit :
>>>> Why using 4.15.13 which is obsolete instead of using one of the Long
>>>> Term Support versions which are still maintained, like 4.14 or 4.19 ?
>>>> (see the complete list at https://www.kernel.org/category/releases.html)
>>>
>>> Well, when I started this task 4.15.13 was probably the latest stable
>>> release and hence we decided to port this version. In the older kernel, we
>>> have the m8260_setup.c source file for our board where the function
>>> "io_block_mapping" was used to configure the non-standard IO port address
>>> starting at 0xe0000000 location. This address was passed as the base address
>>> followed by control address and IRQ number to the ide-core.ko module. In the
>>> new kernel we do not have an option to send these addresses and IRQ numbers
>>> as arguments to the driver. Instead the ide-generic.c source file in the new
>>> kernel uses the standard IO port values and IRQ values. I modified the code
>>> in the above file to used the addresses and IRQ number we used in the past.
>>> Also, added code in the "MMU_init" function call available under
>>> arch/PowerPC/init_32.c to setup the IO port address range by adding the
>>> "io_block_mapping" call and the required IO port address range.
>>>
>>> Is there anything else that needs to be added or how can we configure the
>>> desired IO address range in the new kernel?
>>>
>>
>> Maybe look around https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9a0e77f28b50128df0c9e26ae489e44e29a7270a
>>
>> Also look at ide_platform.c. I imagine there must be some way to set it up in your device tree.

Please don't add new users to subsystem deprecated almost 10 years ago..

>> Maybe Bartlomiej Zolnierkiewicz can help ?
>>
>> Christophe
> 
> Le 14/02/2019 à 09:17, sgosavi1 a écrit :>> Maybe look around
>>
>> I have gone through this before and also tried the pata_platform driver but
>> no success yet. I haven't found any example that passes the IO ports and IRQ
>> information through the device tree to the driver code.

Please look at pata_of_platform.c driver from libata subsystem,
it should have all required functionality.

>> Thanks,
>> Sachin.
> 
> 
> Maybe someone from the IDE SUBSYSTEM would be able to help better ?
> 
> Entire thread at http://linuxppc.10917.n7.nabble.com/Kernel-panic-when-loading-the-IDE-controller-driver-td150020.html#none
> 
> Christophe

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
