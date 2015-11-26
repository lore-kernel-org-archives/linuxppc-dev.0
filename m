Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F89D1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:55 +1100 (AEDT)
In-Reply-To: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: cxl: use correct operator when writing pcie config space values
Message-Id: <20151126121555.1158614031B@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-11 at 02:24:09 UTC, Andrew Donnellan wrote:
> When writing a value to config space, cxl_pcie_write_config() calls
> cxl_pcie_config_info() to obtain a mask and shift value, shifts the new
> value accordingly, then uses the mask to combine the shifted value with the
> existing value at the address as part of a read-modify-write pattern.
> 
> Currently, we use a logical OR operator rather than a bitwise OR operator,
> which means any use of this function results in an incorrect value being
> written. Replace the logical OR operator with a bitwise OR operator so the
> value is written correctly.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: stable@vger.kernel.org
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/48f0f6b717e314a30be121b6

cheers
