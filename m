Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F6AE1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 12:12:03 +1000 (AEST)
In-Reply-To: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, mikey@neuling.org,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: cxl: Fix lockdep warning while creating afu_err_buff attribute
Message-Id: <20150925021203.0870C140789@ozlabs.org>
Date: Fri, 25 Sep 2015 12:12:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-23-09 at 03:07:59 UTC, Vaibhav Jain wrote:
> Presently a lockdep warning is reported during creation of afu_err_buff
> bin_attribute for the afu. This is caused due to the variable attr.key
> not pointing to a static class key, hence the function lockdep_init_map
> reports this warning:
> 
>  BUG: key <some-address> not in .data!
> 
> The patch fixes this issue by calling sysfs_attr_init on the
> attr_eb.attr structure before populating it with the afu_err_buff file
> details. This will populate the attr.key variable with a static class
> key so that lockdep_init_map stops complaining about the lockdep key not
> being static.
> 
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d6eb71a6d2eda21c8cd7a4dc

cheers
