Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B80C31A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 20:41:30 +1100 (AEDT)
In-Reply-To: <562F9C67.3040207@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [v2] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
Message-Id: <20151102094130.A0131140E31@ozlabs.org>
Date: Mon,  2 Nov 2015 20:41:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-27-10 at 15:46:47 UTC, Nathan Fontenot wrote:
> Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed make a change to use
> kstrndup() instead of kmalloc() + strlcpy() in the pseries_of_derive_parent()
> routine that introduces a subtle change in the parent path name generated.
> The kstrndup() routine will copy n characters followed by a terminating null,
> whereas strlcpy() will copy n-1 characters and add a terminating null.
> 
> This slight difference results in having a parent path that includes the
> tailing '/' character, "/cpus/" vs. "/cpus". This then causes the subsequent
> call to of_find_node_by_path() to fail, and in the case of DLPAR add
> operations the DLPAR request fails.
> 
> This patch decrements the pointer returned from kbasename() to point to the
> '/' character before the base name instead of the base name. This then
> adjusts the string length calculations to not include the trailing '/'
> in the parent path name.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f755ecfb8cec7b19dff84295

cheers
