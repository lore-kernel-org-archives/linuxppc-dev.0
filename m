Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLP48FLzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:25 +1000 (AEST)
In-Reply-To: <1492475079-10740-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sachinp@linux.vnet.ibm.com, devicetree@vger.kernel.org,
 sudeep.karkadanagesha@arm.com, stable@vger.kernel.org, robh+dt@kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, bharata@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] powerpc/sysfs: fix reference leak of cpu device_nodes
 present at boot
Message-Id: <3wBhLP3Qv3z9s8W@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 00:24:39 UTC, Tyrel Datwyler wrote:
> For cpus present at boot each logical cpu acquires a reference to the
> associated device node of the core. This happens in register_cpu() which
> is called by topology_init(). The result of this is that we end up with
> a reference held by each thread of the core. However, these references
> are never freed if the cpu core is dlpar removed.
> 
> This patch fixes the reference leaks by acquiring and releasing the
> references in the cpu hotplug callbacks un/register_cpu_online().
> With this patch symmetric reference counting is observed with both cpus
> present at boot, and those dlpar added after boot.
> 
> Cc: stable@vger.kernel.org
> fixes: f86e4718f24b ("driver/core: cpu: initialize of_node in cpu's device struture")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e76ca27790a514590af782f83f6eae

cheers
