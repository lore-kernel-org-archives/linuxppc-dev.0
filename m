Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LHw33RJFzF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 20:55:46 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au
Subject: Re: [PATCH v3 0/2] powernv/cpuidle Device-tree parsing cleanup
Date: Wed, 04 Jul 2018 12:54:16 +0200
Message-ID: <1970525.ZJ2QEpmLmV@aspire.rjw.lan>
In-Reply-To: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 3, 2018 11:20:54 AM CEST Akshay Adiga wrote:
> 
> Device-tree parsed multiple time in powernv cpuidle and powernv
> hotplug code. 
> 
> First to identify supported flags. Second time, to identify deepest_state
> and first deep state. Third time, during cpuidle init to find the available
> idle states. Any change in device-tree format will lead to make changes in
> these 3 places. Errors in device-tree can be handled in a better manner.
> 
> This series adds code to parse device tree once and save in global structure.
> 
> Changes from v2 :
>  - Fix build error (moved a hunk from patch 1 to patch 2)
> Changes from v1 :
>  - fold first 2 patches into 1
>  - rename pm_ctrl_reg_* as psscr_*
>  - added comment stating removal of pmicr parsing code
>  - removed parsing code for pmicr
>  - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
> are valid combination,
>  - Change function description of pnv_parse_cpuidle_dt
>  - Added error handling code.
> 
> 
> Akshay Adiga (2):
>   powernv/cpuidle: Parse dt idle properties into global structure
>   powernv/cpuidle: Use parsed device tree values for cpuidle_init
> 
>  arch/powerpc/include/asm/cpuidle.h    |  13 ++
>  arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
>  drivers/cpuidle/cpuidle-powernv.c     | 154 ++++--------------
>  3 files changed, 177 insertions(+), 206 deletions(-)
> 
> 

I am assuming that this series will go in via the powerpc tree.

Thanks,
Rafael
