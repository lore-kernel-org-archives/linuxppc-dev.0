Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 19AB42C0256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 12:53:23 +1100 (EST)
Message-ID: <1393206791.6771.157.camel@pasglop>
Subject: Re: [PATCH v4 0/3] powerpc/pseries: fix issues in suspend/resume code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 24 Feb 2014 12:53:11 +1100
In-Reply-To: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-19 at 12:56 -0800, Tyrel Datwyler wrote:
> This patchset fixes a couple of issues encountered in the suspend/resume code
> base. First when using the kernel device tree update code update-nodes is
> unnecessarily called more than once. Second the cpu cache lists are not
> updated after a suspend/resume which under certain conditions may cause a
> panic. Finally, since the cache list fix utilzes in kernel device tree update
> code a means for telling drmgr that updating the device tree from userspace
> is unnecessary.

This series breaks the !SMP build.

Cheers,
Ben.

> Changes from v3:
> - Updated patch descriptions to better reflect the behavior/interface changes
>   and why they are acceptable per Ben's concerns.
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
