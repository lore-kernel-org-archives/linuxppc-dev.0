Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPBbl5QCpzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 23:04:19 +1000 (AEST)
Message-ID: <1465304653.30446.5.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] KVM: PPC: hypervisor large decrementer support
From: Michael Ellerman <mpe@ellerman.id.au>
To: benh@au1.ibm.com, Michael Neuling <mikey@neuling.org>, Oliver O'Halloran
 <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
Date: Tue, 07 Jun 2016 23:04:13 +1000
In-Reply-To: <1464903967.3078.316.camel@au1.ibm.com>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
 <1464679016-10347-2-git-send-email-oohall@gmail.com>
 <1464762233.30958.135.camel@neuling.org>
 <1464903967.3078.316.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-03 at 07:46 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2016-06-01 at 16:23 +1000, Michael Neuling wrote:
> > FWIW you can use:
> >         andis. reg,reg,(LPCR_LD)@ha
> 
> @h in that case. Probably the same result but technically @ha is for
> arithmetic operations.

In this case it doesn't matter, because LPCR_LD is a single bit constant.

But if bit 15 of your constant happens to be 1, using @ha will mean 1 is added
to the high 16 bits of the value.

eg. if you have:

	#define CONSTANT        0x00208000

        lis     r4,CONSTANT@ha

You get:

	10000118:	21 00 80 3c 	lis     r4,33
	                                           ^
	                                           = 0x21


Documented (sort of) here:

  http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#RELOC-TYPE
  
  #ha(value) denotes the high adjusted value: bits 16 through 31 of the indicated value, compensating for #lo() being treated as a signed number:
  
      #ha(x) = (((x >> 16) + ((x & 0x8000) ? 1 : 0)) & 0xffff)

cheers
