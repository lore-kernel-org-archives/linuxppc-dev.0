Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2xLN29r7zDrWC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 16:06:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: david@gibson.dropbear.id.au, anton@samba.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Increase memory block size to 1GB on
 radix
In-Reply-To: <20171220042520.7946-1-mpe@ellerman.id.au>
References: <20171220042520.7946-1-mpe@ellerman.id.au>
Date: Fri, 22 Dec 2017 16:06:19 +1100
Message-ID: <87608zpd10.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> When we're using the Radix MMU we map the kernel linear mapping with
> 1G pages. That means we must do memory hot remove in blocks of at
> least that size. Otherwise the linear mapping can end up not mapping
> all of memory because we've removed part of a 1G region but unmapped
> the entire 1G region from the linear mapping.
>
> Currently on pseries we consult the device tree to find out the the
> "LMB" (Logical Memory Block) size. This is the unit of memory hotplug
> communicated to us by the hypervisor, but it does not take into
> account anything the kernel has done itself, such as use 1G pages for
> the linear mapping.

This patch failed to survive contact with reality. ie. it doesn't work.

NAK.

cheers
