Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5bB56NCTzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 13:36:29 +1000 (AEST)
Date: Fri, 13 May 2016 13:35:46 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix definition of SIAR and SDAR registers
Message-ID: <20160513033546.GA22018@oak.ozlabs.ibm.com>
References: <1463052404-18092-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463052404-18092-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 01:26:44PM +0200, Thomas Huth wrote:
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

Acked-by: Paul Mackerras <paulus@ozlabs.org>
