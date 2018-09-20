Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SS1vdjzF31s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
In-Reply-To: <152425618836.15614.7060070452480906952.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com
Subject: Re: pseries/memory-hotplug: Only update DT once per memory DLPAR
 request
Message-Id: <42G3SR6Jmsz9sBv@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-20 at 20:29:48 UTC, Nathan Fontenot wrote:
> The updates to powerpc numa and memory hotplug code now use the
> in-kernel LMB array instead of the device tree. This change
> allows the pseries memory DLPAR code to only update the device
> tree once after successfully handling a DLPAR request.
> 
> Prior to the in-kernel LMB array, the numa code looked up the
> affinity for memory being added in the device tree, the code
> now looks this up in the LMB array. This change means the
> memory hotplug code can just update the affinity for an LMB
> in the LMB array instead of updating the device tree.
> 
> This also provides a savings in kernel memory. When updating the
> device tree old properties are never free'ed since there is no
> usecount on properties. This behavior leads to a new copy of the
> property being allocated every time a LMB is added or removed
> (i.e. a request to add 100 LMBs creates 100 new copies of the
> property). With this update only a single new property is created
> when a DLPAR request completes successfully.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/063b8b1251fd069f3740339fca5611

cheers
