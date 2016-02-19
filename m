Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B6A21A05EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 23:13:29 +1100 (AEDT)
In-Reply-To: <1455693991-31405-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, stable@vger.kernel.org.#.4.2+,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [kernel,
 v2] powerpc/ioda: Set "read" permission when "write" is set
Message-Id: <20160219121328.EA947140B04@ozlabs.org>
Date: Fri, 19 Feb 2016 23:13:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-17-02 at 07:26:31 UTC, Alexey Kardashevskiy wrote:
> Quite often drivers set only "write" permission assuming that this
> includes "read" permission as well and this works on plenty platforms.
> However IODA2 is strict about this and produces an EEH when "read"
> permission is not and reading happens.
> 
> This adds a workaround in IODA code to always add the "read" bit when
> the "write" bit is set.
> 
> This fixes breakage introduced in
> 10b35b2b74 powerpc/powernv: Do not set "read" flag if direction==DMA_NONE
> 
> Cc: stable@vger.kernel.org # 4.2+
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6ecad912a0073c768db1491c27

cheers
