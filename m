Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJqD92bNLzDqdj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:17:13 +1000 (AEST)
In-Reply-To: <1463052404-18092-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
Subject: Re: powerpc: Fix definition of SIAR and SDAR registers
Message-Id: <3rJqD91lxcz9t3s@ozlabs.org>
Date: Tue, 31 May 2016 20:17:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 11:26:44 UTC, Thomas Huth wrote:
> The SIAR and SDAR registers are available twice, one time as SPRs
> 780 / 781 (unprivileged, but read-only), and one time as the SPRs
> 796 / 797 (privileged, but read and write). The Linux kernel code
> currently uses the unprivileged  SPRs - while this is OK for reading,
> writing to that register of course does not work.
> Since the KVM code tries to write to this register, too (see the mtspr
> in book3s_hv_rmhandlers.S), the contents of this register sometimes get
> lost for the guests, e.g. during migration of a VM.
> To fix this issue, simply switch to the privileged SPR numbers instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d23fac2b27d94aeb7b65536a50

cheers
