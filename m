Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65998DDFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 08:53:37 +1100 (EST)
In-Reply-To: <6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
Date: Sun, 2 Mar 2008 22:53:12 +0100
To: "Stephane Marchesin" <marchesin@icps.u-strasbg.fr>
Cc: linuxppc-dev@ozlabs.org, henrik.sorensen@gmail.com, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +/*
>> + * __ucmpdi2: 64-bit comparison
>> + *
>> + * R3/R4 has 64 bit value A
>> + * R5/R6 has 64 bit value B
>> + * result in R3: 0 for A < B
>> + *              1 for A == B
>> + *              2 for A > B
>> + */
>> +_GLOBAL(__ucmpdi2)
>> +       cmplw   r7,r3,r5        # compare high words
>> +       li      r3,0
>> +       blt     r7,2f           # a < b ... return 0
>> +       bgt     r7,1f           # a > b ... return 2
>> +       cmplw   r6,r4,r6        # compare low words
>> +       blt     r6,2f           # a < b ... return 0
>> +       li      r3,1
>> +       ble     r6,2f           # a = b ... return 1
>> +1:     li      r3,2
>> +2:     blr

Every occurrence of r7 here is wrong (and some of the r6).  Is there
any reason to do this in assembler code at all?


Segher
