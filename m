Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 69A982C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 08:43:29 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 16:43:26 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D700A6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:43:18 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1CLhNE89699778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 21:43:23 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1CLhM3K000744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:43:23 -0500
Message-ID: <52FBEAF9.5080206@linux.vnet.ibm.com>
Date: Wed, 12 Feb 2014 13:43:21 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] powerpc/pseries: fix issues in suspend/resume code
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2014 03:58 PM, Tyrel Datwyler wrote:
> This patchset fixes a couple of issues encountered in the suspend/resume code
> base. First when using the kernel device tree update code update-nodes is
> unnecessarily called more than once. Second the cpu cache lists are not
> updated after a suspend/resume which under certain conditions may cause a
> panic. Finally, since the cache list fix utilzes in kernel device tree update
> code a means for telling drmgr not to perform a device tree update from
> userspace is required.
> 
> Changes from v2:
> - Moved dynamic configuration update code into pseries specific routine
>   per Nathan's suggestion.
> 
> Changes from v1:
> - Fixed several commit message typos
> - Fixed authorship of first two patches
> 
> Haren Myneni (2):
>   powerpc/pseries: Device tree should only be updated once after
>     suspend/migrate
>   powerpc/pseries: Update dynamic cache nodes for suspend/resume
>     operation
> 
> Tyrel Datwyler (1):
>   powerpc/pseries: Report in kernel device tree update to drmgr
> 
>  arch/powerpc/include/asm/rtas.h           |  1 +
>  arch/powerpc/platforms/pseries/mobility.c | 26 +++++++-----------
>  arch/powerpc/platforms/pseries/suspend.c  | 44 ++++++++++++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 17 deletions(-)
> 

Ping?

Nathan, can I at least get your ack on this v3 patchset. We really need
to get these upstream.

-Tyrel
