Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D6BA1A0BC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 14:40:54 +1100 (AEDT)
Message-ID: <1449027654.11810.8.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] selftests/powerpc: Standardise TM calls
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Rashmica Gupta
 <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Dec 2015 14:40:54 +1100
In-Reply-To: <565D5563.5000900@linux.vnet.ibm.com>
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
 <1448946504-11653-2-git-send-email-rashmicy@gmail.com>
 <565D5563.5000900@linux.vnet.ibm.com>
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

On Tue, 2015-12-01 at 13:38 +0530, Anshuman Khandual wrote:
> On 12/01/2015 10:38 AM, Rashmica Gupta wrote:
> > Currently tbegin, tend etc are written as opcodes or asm instructions. So
> > standardise these to asm instructions.
> 
> I think the asm instructions can be used with only newer versions of GCC.
> But not sure, does it work with the older gcc as well ?

No they don't work with all versions of GCC.

The HTM instructions were added in 4.9 AFAICS, but also backported to 4.8. That
seems old enough to me.

Also we have another test (tm-syscall) which is already using the tbegin
instruction, and no one has complained, so I don't think anyone is trying to
build the selftests with really old compilers.

cheers
