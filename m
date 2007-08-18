Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBAEDDDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 15:38:14 +1000 (EST)
In-Reply-To: <a79f1cbe580d675c6bb231e4e3a0326b@kernel.crashing.org>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
	<a79f1cbe580d675c6bb231e4e3a0326b@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <116E5908-D8CD-4050-BC86-3AD3751397F4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
Date: Sat, 18 Aug 2007 00:40:03 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 6:25 PM, Segher Boessenkool wrote:

>>  include/asm-powerpc/8xx_immap.h   |  564 +++++++++++++++++
>>  include/asm-powerpc/commproc.h    |  692 ++++++++++++++++++++
>>  include/asm-powerpc/cpm2.h        | 1248 +++++++++++++++++++++++++ 
>> ++++++++++++
>>  include/asm-powerpc/gg2.h         |   61 ++
>>  include/asm-powerpc/highmem.h     |  135 ++++
>>  include/asm-powerpc/hydra.h       |  102 +++
>>  include/asm-powerpc/immap_cpm2.h  |  648 +++++++++++++++++++
>>  include/asm-powerpc/kgdb.h        |   57 ++
>>  include/asm-powerpc/m8260_pci.h   |  187 ++++++
>>  include/asm-powerpc/mpc10x.h      |  180 ++++++
>>  include/asm-powerpc/mpc52xx_psc.h |  191 ++++++
>
> Can't we move most of this to the dir where they are used,
> instead?

The following are shared between arch/powerpc code and drivers:

  include/asm-powerpc/8xx_immap.h   |  564 +++++++++++++++++
  include/asm-powerpc/commproc.h    |  692 ++++++++++++++++++++
  include/asm-powerpc/cpm2.h        | 1248 +++++++++++++++++++++++++++ 
++++++++++
  include/asm-powerpc/immap_cpm2.h  |  648 +++++++++++++++++++
  include/asm-powerpc/mpc52xx_psc.h |  191 ++++++

These could possibly move, I'll look into it:
  include/asm-powerpc/gg2.h         |   61 ++		[into platforms/chrp]
  include/asm-powerpc/hydra.h       |  102 +++		[into platforms/chrp]
  include/asm-powerpc/kgdb.h        |   57 ++		[not sure, maybe leave  
here for now]
  include/asm-powerpc/mpc10x.h      |  180 ++++++	[into platforms/ 
embedded6xx]

Needs to live in include/asm-powerpc:
  include/asm-powerpc/highmem.h     |  135 ++++

Will kill this one per Scott/Arnd:
  include/asm-powerpc/m8260_pci.h   |  187 ++++++

- k
