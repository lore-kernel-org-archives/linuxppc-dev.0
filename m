Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46BF72C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 07:37:22 +1000 (EST)
Message-ID: <1367876228.15842.62.camel@pasglop>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and
 ISEL bits in HWCAP2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryan Arnold <ryanarn@us.ibm.com>
Date: Tue, 07 May 2013 07:37:08 +1000
In-Reply-To: <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>
 <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael R Meissner <mrmeissn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 09:38 -0500, Ryan Arnold wrote:
> My understanding was that these bits being 'on' is an indication of
> what features the hardware supports (or what the kernel emulates) and
> a not an indication of whether that facility is currently enabled or
> not.  If the hardware supports a particular feature but it is not
> enabled I'd expect that user-space usage of that feature would cause
> the kernel to trap on a facility availability exception (which is how
> Altivec/VMX is implemented, being defaulted to turned off).

Right but the discussion is about whether we should expose the bits
when the kernel doesn't have the ability to handle the feature :-)

IE. We need to remove the HTM feature if the kernel is compiled without
transactional memory support.

Similarily, Nish, you may need to check that we remove those bits if
pHyp has the partition in a mode that doesn't support them (P7
compatibility for example) for migration purposes.

Cheers,
Ben.

> Otherwise there's no way I could know whether an ISA [optional]
> feature is actually available on a particular machine.
> 
> And yes, the bits can't change.  My usage of hwcap.h has to coincide
> with the kernel's asm/cputable.h
