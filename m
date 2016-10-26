Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mJL6JHSzDt1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:21:06 +1100 (AEDT)
In-Reply-To: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/64: Re-fix race condition between going idle and
 entering guest
Message-Id: <3t3mJL3D45z9sf9@ozlabs.org>
Date: Wed, 26 Oct 2016 21:21:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-21-10 at 09:03:05 UTC, Paul Mackerras wrote:
> Commit 8117ac6a6c2f ("powerpc/powernv: Switch off MMU before entering
> nap/sleep/rvwinkle mode", 2014-12-10) fixed a race condition where one
> thread entering a KVM guest could switch the MMU context to the guest
> while another thread was still in host kernel context with the MMU on.
> That commit moved the point where a thread entering a power-saving
> mode set its kvm_hstate.hwthread_state field in its PACA to
> KVM_HWTHREAD_IN_IDLE from a point where the MMU was on to after the
> MMU had been switched off.  That commit also added a comment
> explaining that we have to switch to real mode before setting
> hwthread_state to avoid this race.
> 
> Nevertheless, commit 4eae2c9ae54a ("powerpc/powernv: Make
> pnv_powersave_common more generic", 2016-07-08) subsequently moved
> the setting of hwthread_state back to a point where the MMU is on,
> thus reintroducing the race, despite the comment saying that this
> should not be done being included in full in the context lines of
> the patch that did it.
> 
> This fixes the race again and adds a bigger and shoutier comment
> explaining the potential race condition.
> 
> Cc: stable@vger.kernel.org # v4.8
> Fixes: 4eae2c9ae54a
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/56c46222af0d09149fadec2a3ce9d4

cheers
