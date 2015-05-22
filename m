Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31A691A0076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 12:45:55 +1000 (AEST)
In-Reply-To: <1432195530-31382-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Ian Munsie <imunsie@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [v5] cxl: Export AFU error buffer via sysfs
Message-Id: <20150522024555.1FD8614077A@ozlabs.org>
Date: Fri, 22 May 2015 12:45:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-21-05 at 08:05:30 UTC, Vaibhav Jain wrote:
> Export the "AFU Error Buffer" via sysfs attribute (afu_err_buf). AFU
> error buffer is used by the AFU to report application specific
> errors. The contents of this buffer are AFU specific and are intended to
> be interpreted by the application interacting with the afu.
> 
> Testing:
> 	- Build against pseries le/be configs.
> 	- Run testing with a special version of memcpy afu on a 'be'
> 	kernel.
> 
> Change-log:
> v4 -> v5
> 	- Improved documentation in cxl_afu_read_err_buffer function to
> 	address why I am using '_memcpy_fromio' instead of
> 	'memcpy_fromio'

> +	/*
> +	 * using '_memcpy_fromio' instead of 'memcpy_fromio' as on powerpc
> +	 * arch its gauranteed to use 8/4 bytes aligned reads. This may
> +	 * not be the case with other archs.
> +	 */

Please just use memcpy_fromio().

Via the definition at:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/include/asm/io-defs.h#n57

You'll get the implementation at:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/include/asm/io.h#n584

Which because there is no hook defined will use the implementation at:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/include/asm/io.h#n542

Which will use:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/include/asm/eeh.h#n417


Which calls _memcpy_fromio() and also checks for EEH errors.

cheers
