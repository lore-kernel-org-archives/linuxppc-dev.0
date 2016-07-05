Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQks4gHgzDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:13 +1000 (AEST)
In-Reply-To: <1458282993-6371-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/rtas: fix array overrun in ppc_rtas() syscall
Message-Id: <3rkQks3yQtz9sBc@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-18-03 at 06:36:33 UTC, Andrew Donnellan wrote:
> If ppc_rtas() is called with args.nargs == 16 and args.nret == 0, args.rets
> is set to point to &args.args[16], which is beyond the end of the args.args
> array. This results in a minor read overrun of the array when we check the
> first return code (which, per PAPR, is a required output of all RTAS calls)
> to see if there's been a hardware error.
> 
> Change the nargs/nret check to ensure nargs is <= 15, allowing room for the
> status code. Users shouldn't be calling with nret == 0, but there's no real
> harm if they do, so we don't stop them.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a9862c7440f191439a51f77233

cheers
