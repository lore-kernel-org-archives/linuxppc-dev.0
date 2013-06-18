Return-Path: <B31939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA7D42C023D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 12:49:01 +1000 (EST)
Received: from mail224-tx2 (localhost [127.0.0.1])	by
 mail224-tx2-R.bigfish.com (Postfix) with ESMTP id 00AA59401AF	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:48:57 +0000 (UTC)
Received: from TX2EHSMHS027.bigfish.com (unknown [10.9.14.247])	by
 mail224-tx2.bigfish.com (Postfix) with ESMTP id D779CCC0062	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:48:55 +0000 (UTC)
Message-ID: <51BFCAAF.1070400@freescale.com>
Date: Tue, 18 Jun 2013 10:49:19 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
References: <1371516126.9073.16@snotra>
In-Reply-To: <1371516126.9073.16@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/18/2013 08:42 AM, Scott Wood wrote:
> On 06/17/2013 07:28:07 PM, Scott Wood wrote:
>> On 06/17/2013 12:07:41 AM, Lian Minghuan-b31939 wrote:
>>>>> +    compatible = "fsl,mpic-msi";
>>>>> +    reg = <0x41600 0x200 0x44140 4>;
>>>>
>>>> Why 0x200?
>>>>
>>> [Minghuan] The offsets of the MSIA registers are from 0x41600 to 
>>> 0x417ff, and the size is 0x200.
>>> offset 0x41600-0x4170 are MSIIRA1-7.
>>> 0x41720 is MSISRA,
>>> 0x41750 is MSIIR.
>>> The others are reserved.
>>
>> There is no MSIIRA on fsl,mpic-msi.
>
> Sigh, I was thinking of MSIIR1A -- which of course is distinct from 
> both MSIIRA1 and MSIIRA. :-P
>
> So it's just a bug that pq3-mpic.dtsi has a length of 0x80?
[Minghuan] I am sorry, there is a typo.
offset 0x41600-0x4170 should be MSIRA0-7.
The MSI bank size is 0x200.
The MSIR 0-7 size is 0x80.
So the first region of 'reg' should indicate bank size or MSIR size?
I think it should be a bank size. So MSI driver can access MSISR and 
MSIIR, and provide some new features in feature.
>
> -Scott
