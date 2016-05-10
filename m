Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYh45ldzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:40 +1000 (AEST)
In-Reply-To: <1462520796-30089-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [v2] cxl: Add kernel API to allow a context to operate with
 relocate disabled
Message-Id: <3r4CYh2JhGz9t4P@ozlabs.org>
Date: Wed, 11 May 2016 07:48:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-05 at 07:46:36 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> cxl devices typically access memory using an MMU in much the same way as
> the CPU, and each context includes a state register much like the MSR in
> the CPU. Like the CPU, the state register includes a bit to enable
> relocation, which we currently always enable.
> 
> In some cases, it may be desirable to allow a device to access memory
> using real addresses instead of effective addresses, so this adds a new
> API, cxl_set_translation_mode, that can be used to disable relocation
> on a given kernel context. This can allow for the creation of a special
> privileged context that the device can use if it needs relocation
> disabled, and can use regular contexts at times when it needs relocation
> enabled.
> 
> This interface is only available to users of the kernel API for obvious
> reasons, and will never be supported in a virtualised environment.
> 
> This will be used by the upcoming cxl support in the mlx5 driver.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9bc8ba0e5d59a84e582004e201

cheers
