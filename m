Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63020DDF2D
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:33:10 +1100 (EST)
In-Reply-To: <1204648648.3891.439.camel@pmac.infradead.org>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
	<15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
	<1204648648.3891.439.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d65fa0ae5361ca507c0988d8a7f1d009@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
Date: Tue, 4 Mar 2008 21:32:50 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: paulus@samba.org, henrik.sorensen@gmail.com,
	Stephane Marchesin <marchesin@icps.u-strasbg.fr>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Every occurrence of r7 here is wrong (and some of the r6).
>
> Can you elucidate?

Sure!  It should read either "7" or "cr7".

>>   Is there any reason to do this in assembler code at all?
>
> Is there any particular reason not to?

1) If written in assembler, it needs to be written for every 
architecture
separately, and sometimes even for every architecture variant (32 vs. 64
bit is only the tip of the iceberg).

2) As shown here as well as in the recent strncmp() patch, it is a lot 
harder
to write correct assembler code than it is to write correct C code(*), 
and
the C code isn't less efficient either.


Segher

(*) Well, the generic C strncmp() code in the kernel is broken too, bad
example perhaps :-)
