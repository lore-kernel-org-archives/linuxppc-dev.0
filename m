Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25E0FDDE27
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 06:20:21 +1000 (EST)
In-Reply-To: <1178187440.20944.12.camel@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F12C74C-0C14-4D43-9EE0-F0C5FF0AC798@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
Date: Fri, 4 May 2007 15:19:22 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 3, 2007, at 5:17 AM, Adrian Cox wrote:

> On Wed, 2007-05-02 at 16:34 -0500, Jon Loeliger wrote:
>> From: James.Yang <James.Yang@freescale.com>
>>
>> Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
>> This prevents needlessly setting M=1 when not SMP.
>
> There may be side effects to removing this. Most of the 74xx  
> processors
> had this flag added because of the L2 prefetch bug (erratum #16 on the
> 7447A). I see that bug is missing from the 7448 errata.
>
> The problem is that many 32-bit PowerPC machines needed
> CPU_FTR_NEED_COHERENT set for a second reason: compatibility with the
> cache in the MPC107. This was handled by CPU_FTR_COMMON in cputable.h
> before the L2 prefetch bug was known.  There may be other host bridges
> that cache, but nobody will have noticed because all the CPUs had
> CPU_FTR_NEED_COHERENT set already.

While this may be the case for non-10X bridges I don't think we  
should impose the restriction if we don't know its actually needed.

- k
