Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptcv3sSBzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:22:55 +1000 (AEST)
In-Reply-To: <20180322210528.22017-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: cxl: remove a dead branch
Message-Id: <41ptcv2xyYz9sC7@ozlabs.org>
Date: Mon, 13 Aug 2018 21:22:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 21:05:28 UTC, Mathieu Malaterre wrote:
> In commit 14baf4d9c739 ("cxl: Add guest-specific code") the following code
> was added:
> 
> 	if (afu->crs_len < 0) {
> 		dev_err(&afu->dev, "Unexpected configuration record size value\n");
> 		return -EINVAL;
> 	}
> 
> However the variable `crs_len` is of type u64 and cannot be compared < 0.
> Remove the dead code section. Fix the following warning treated as error
> with W=1:
> 
> ../drivers/misc/cxl/guest.c:919:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4ecafb14fd9cd77d8f4320af1922e

cheers
