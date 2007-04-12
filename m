Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1CE0DDF43
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 17:47:03 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3C7kxMO173888
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 07:46:59 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3C7kxR42551910
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 08:46:59 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3C7kx3k031228
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 08:46:59 +0100
Message-ID: <461DE3B6.8010503@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2007 09:45:58 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] cryptoapi: AES with AltiVec support
References: <20070411164910.657151000@linux.vnet.ibm.com> >
	<20070411165702.256910000@linux.vnet.ibm.com>>
	<1176330126.8061.110.camel@localhost.localdomain>
In-Reply-To: <1176330126.8061.110.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> ==================================================================
>> --- ps3-linux.orig/crypto/Makefile
>> +++ ps3-linux/crypto/Makefile
>> @@ -48,3 +48,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
>>  obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
>>  
>>  obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
>> +
>> +CFLAGS_aes-altivec.o += -O3  -maltivec -mcpu=cell
>> +aes_altivec-objs := aes-alti.o aes-altivec.o
>> +obj-$(CONFIG_CRYPTO_AES_ALTIVEC) += aes_altivec.o
> 
> Ideally (and I know the RAID6 code isnt doing it), the
> code that contains enable_kernel_altivec/disable_kernel_altivec should
> -not- itself be compiled with -malitvec. You don't want the compiler to
> "inadvertently" generate altivec instructions outside of those calls (in
> the function prolog for example).
Yes. aes-altivec.o contains the -maltivec flag and is the only module 
using AltiVec. aes-alti.o uses enable_kernel_altivec & 
disable_kernel_altivec and calls then the AltiVec module.
The raid6 code compiles the raid[1,2,4,8].c files with -maltivec flag 
and uses the noinline keyword in the function that uses AltiVec.
Should I prefer the latter or were you confused with with the - _ in the 
filename and you recommend renaming them?

> I noticed quite a bit of memcpy's around too... see if you can limit
> usage of these.
I check if I can be be sure that the data is always properly aligned

> 
> Ben.
> 

Sebastian
