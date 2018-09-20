Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sh0drDzF37h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:08 +1000 (AEST)
In-Reply-To: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: Disable CPU hotplug across migrations
Message-Id: <42G3Sg1wjyz9sCt@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-17 at 19:14:02 UTC, Nathan Fontenot wrote:
> When performing partition migrations all present CPUs must be online
> as all present CPUs must make the H_JOIN call as part of the migration
> process. Once all present CPUs make the H_JOIN call, one CPU is returned
> to make the rtas call to perform the migration to the destination system.
> 
> During testing of migration and changing the SMT state we have found
> instances where CPUs are offlined, as part of the SMT state change,
> before they make the H_JOIN call. This results in a hung system where
> every CPU is either in H_JOIN or offline.
> 
> To prevent this this patch disables CPU hotplug during the migration
> process.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/85a88cabad57d26d826dd94ea34d3a

cheers
