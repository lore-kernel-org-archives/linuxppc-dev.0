Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-7.online-age.net (ext-nj2ut-7.online-age.net
	[64.14.54.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9631EDE0B7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 04:05:28 +1100 (EST)
Received: from int-nj2ut-2.online-age.net (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by ext-nj2ut-7.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0CH5ORq022068
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 12:05:24 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by int-nj2ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0CH5JEr002082
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 12:05:24 -0500
Message-ID: <496B784C.5010800@gefanuc.com>
Date: Mon, 12 Jan 2009 17:05:16 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
References: <1231601482-28123-1-git-send-email-adrian@lisas.de>	<c613a7e0a88e249894bafe6d2183fbf2@bga.com>
	<20090110195040.GA19945@lisas.de>
In-Reply-To: <20090110195040.GA19945@lisas.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Reber wrote:
> On Sat, Jan 10, 2009 at 11:52:56AM -0600, Milton Miller wrote:
>> Normally such drivers are written and mtd drivers.
>>
>> If slof were not an of implementation I would just say put the right  
>> properties on the node in the device tree, but the kernel should adapt  
>> to real OF.  It should be easy to write a driver to hook up a mtd  
>> platform device if this is a direct mapped flash.
> 
> The reason why I did not use mtd is that part of the flash is used by
> the firmware image and I do not know if that works with mtd, if only a
> part of the flash can be used. SLOF does also a "CRC" check over the
> firmware image, so that image must have valid SLOF "CRC". The flash is
> a direct mapped flash, but the size of the firmware can vary.
> 

It can. MTD can create "partitions" within the flash, for an example see lines 84-110 of arch/powerpc/bootdts/sbc8641d.dts (http://tinyurl.com/7k2kym)

Partitions can also be labeled as read-only, I guess the CRC could be checked from userspace as necessary.

HTH,

Martyn
-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
