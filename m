Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50773DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 09:43:45 +1100 (EST)
In-Reply-To: <18381.49853.255430.142431@cargo.ozlabs.ibm.com>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
	<15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
	<18381.49853.255430.142431@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c3fe70f4c488b04e426b9d61c5263059@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
Date: Tue, 4 Mar 2008 23:43:25 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, henrik.sorensen@gmail.com,
	Stephane Marchesin <marchesin@icps.u-strasbg.fr>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Every occurrence of r7 here is wrong (and some of the r6).  Is there
>> any reason to do this in assembler code at all?
>
> The fact that the obvious C code generates ... a call to __ucmpdi2? :)

Hrm?  Here's the "obvious" C code, portable to all architectures
(modulo the specific types used, this isn't a proposed patch):


unsigned int ucmpdi2(unsigned long long a, unsigned long long b)
{
         unsigned long ahi, bhi, alo, blo;

         ahi = a >> 32;
         bhi = b >> 32;
         if (ahi < bhi)
                 return 0;
         if (ahi > bhi)
                 return 2;

         alo = a;
         blo = b;
         if (alo < blo)
                 return 0;
         if (alo > blo)
                 return 2;

         return 1;
}


(libgcc does it a bit differently, with unions and stuff).


Segher
