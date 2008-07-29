Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-11.bluehost.com (outbound-mail-11.bluehost.com
	[69.89.18.111]) by ozlabs.org (Postfix) with SMTP id ED919DDFDF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 12:22:16 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: pci-current tree build failure
Date: Mon, 28 Jul 2008 19:15:23 -0700
References: <20080729105213.0ac2acbd.sfr@canb.auug.org.au>
In-Reply-To: <20080729105213.0ac2acbd.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807281915.24018.jbarnes@virtuousgeek.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, July 28, 2008 5:52 pm Stephen Rothwell wrote:
> Hi Jesse,
>
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
>
> arch/powerpc/kernel/iommu.c:54: error: static declaration of
> 'iommu_num_pages' follows non-static declaration
> include/linux/iommu-helper.h:11: error: previous declaration of
> 'iommu_num_pages' was here
>
> Caused by commit 3bc9f79ee1ddc913be0a6d3592036683ef8a3148 ("iommu: add
> iommu_num_pages helper function") which introduced a global version of a
> function that powerpc has a different version of.  I am not sure that the
> two do the same thing - in fact they don't since powerpc can have a 64k
> page size and still need to use a 4k iommu pages.  I applied the
> patch below (which I personally hate :-))

Hopefully my ppc machine will arrive soon and I can build & test boot things 
so this won't happen in the future.

Joerg, what do you think here?

Thanks,
Jesse
