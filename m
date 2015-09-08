Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB1B21A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 22:05:01 +1000 (AEST)
In-Reply-To: <1441621360-1536-1-git-send-email-bharata.rao@gmail.com>
To: Bharata B Rao <bharata.rao@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: nfont@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [FIX,
 v1] powerpc/pseries: Release DRC when configure_connector fails
Message-Id: <20150908120501.A458B1402ED@ozlabs.org>
Date: Tue,  8 Sep 2015 22:05:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-09 at 10:22:40 UTC, Bharata B Rao wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> Commit f32393c943e2 ("powerpc/pseries: Correct cpu affinity for
> dlpar added cpus") moved dlpar_acquire_drc() call to before
> dlpar_configure_connector() call in dlpar_cpu_probe(), but missed
> to release the DRC if dlpar_configure_connector() failed.
> During CPU hotplug, if configure-connector fails for any reason,
> then this will result in subsequent CPU hotplug attempts to fail.
> 
> Release the acquired DRC if dlpar_configure_connector() call fails
> so that the DRC is left in right isolation and allocation state
> for the subsequent hotplug operation to succeed.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/daebaabb5cfbe4a6f09ca0e0

cheers
