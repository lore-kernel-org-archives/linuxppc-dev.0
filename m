Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTty3n6lzDqyc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:14 +1000 (AEST)
In-Reply-To: <1468444634-1866-7-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [06/15] cxl: Do not create vPHB if there are no AFU configuration
 records
Message-Id: <3rrTty1hxzz9snm@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:05 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The vPHB model of the cxl kernel API is a hierarchy where the AFU is
> represented by the vPHB, and it's AFU configuration records are exposed
> as functions under that vPHB. If there are no AFU configuration records
> we will create a vPHB with nothing under it, which is a waste of
> resources and will opt us into EEH handling despite not having anything
> special to handle.
> 
> This also does not make sense for cards using the peer model of the cxl
> kernel API, where the other functions of the device are exposed via
> additional peer physical functions rather than AFU configuration
> records. This model will also not work with the existing EEH handling in
> the cxl driver, as that is designed around the vPHB model.
> 
> Skip creating the vPHB for AFUs without any AFU configuration records,
> and opt out of EEH handling for them.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4f5fc001a6cb82bef91037245

cheers
