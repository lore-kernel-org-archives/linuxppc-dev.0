Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DF5B1A0C12
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:43:43 +1100 (AEDT)
Message-ID: <1446767022.25265.2.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config
 space values
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Date: Fri, 06 Nov 2015 10:43:42 +1100
In-Reply-To: <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
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

On Fri, 2015-11-06 at 10:05 +1100, Daniel Axtens wrote:

> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> 

> > When writing a value to config space, cxl_pcie_write_config() calls
> > cxl_pcie_config_info() to obtain a mask and shift value, shifts the new
> > value accordingly, then uses the mask to combine the shifted value with the
> > existing value at the address as part of a read-modify-write pattern.
> > 
> > Currently, we use a logical OR operator rather than a bitwise OR operator,
> > which means any use of this function results in an incorrect value being
> > written. Replace the logical OR operator with a bitwise OR operator so the
> > value is written correctly.
> > 
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: stable@vger.kernel.org
> 
> Given that there are no current users of this function, does this need
> to go to stable? Does it actually fix a real (as opposed to theoretical)
> bug?

If it's unused *and* broken then we should just remove it.

cheers
