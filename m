Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLN56bMzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:24 +1000 (AEST)
In-Reply-To: <1492474900-10658-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sachinp@linux.vnet.ibm.com, devicetree@vger.kernel.org,
 pantelis.antoniou@konsulko.com, stable@vger.kernel.org, robh+dt@kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, bharata@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/pseries: fix of_node_put() underflow during dlpar
 remove
Message-Id: <3wBhLN4M8Fz9s8V@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 00:21:40 UTC, Tyrel Datwyler wrote:
> Historically device_node references were tracked using a kref embedded
> as a struct field. Commit 75b57ecf9 refactored device_nodes to be
> kobjects such that the device tree could by more simply exposed to
> userspace using sysfs. Commit 0829f6d1f6 followed up these changes to
> better control the kobject lifecycle and in particular the referecne
> counting via of_node_get(), of_node_put(), and of_node_init(). A side
> effect of this second commit was that it introduced an of_node_put()
> call when a dynamic node is detached that removes the initial kobj
> reference created by of_node_init() . Traditionally as the original
> dynamic device node user the pseries code had assumed responsibilty for
> releasing this final reference in its platform specific DLPAR detach code.
> 
> This patch fixes a refcount underflow introduced by commit 0829f6d1f6,
> and recently exposed by the upstreaming of the recount API.
> 
> Messages like the following are no longer seen in the kernel log with this
> patch following DLPAR remove operations of cpus and pci devices.
> 
>   [  269.589441] rpadlpar_io: slot PHB 72 removed
>   [  270.589997] refcount_t: underflow; use-after-free.
>   [  270.590019] ------------[ cut here ]------------
>   [  270.590025] WARNING: CPU: 5 PID: 3335 at
>      lib/refcount.c:128 refcount_sub_and_test+0xf4/0x110
> 
> Cc: stable@vger.kernel.org
> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/68baf692c435339e6295cb470ea554

cheers
