Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Df812mjzDsSh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:29:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sinan Kaya <okaya@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Rob Herring <robh@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 02/26] powerpc/PCI: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-3-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-3-git-send-email-okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 21:29:01 +1100
Message-ID: <87fu879fki.fsf@concordia.ellerman.id.au>
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

Sinan Kaya <okaya@codeaurora.org> writes:

> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
>
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
>
> Use pci_get_domain_bus_and_slot() with a domain number of 0 as the code
> is not ready to consume multiple domains and existing code used domain
> number 0.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  arch/powerpc/kernel/pci_32.c              | 3 ++-
>  arch/powerpc/platforms/powermac/feature.c | 2 +-
>  arch/powerpc/sysdev/mv64x60_pci.c         | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Looks to do what it says. I don't know if any of these call sites could
be improved to provide the domain, but that's not really your problem.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
