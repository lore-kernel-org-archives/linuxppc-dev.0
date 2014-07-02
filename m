Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9D5B1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 14:50:07 +1000 (EST)
Date: Wed, 2 Jul 2014 14:50:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] KVM: PPC: BOOK3S: HV: Deny virtual page class key
 update via h_protect
Message-ID: <20140702045002.GC16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404040655-12076-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 29, 2014 at 04:47:31PM +0530, Aneesh Kumar K.V wrote:
> This makes it consistent with h_enter where we clear the key
> bits. We also want to use virtual page class key protection mechanism
> for indicating host page fault. For that we will be using key class
> index 30 and 31. So prevent the guest from updating key bits until
> we add proper support for virtual page class protection mechanism for
> the guest. This will not have any impact for PAPR linux guest because
> Linux guest currently don't use virtual page class key protection model

As things stand, without this patch series, we do actually have
everything we need in the kernel for guests to use virtual page class
keys.  Arguably we should have a capability to tell userspace how many
storage keys the guest can use, but that's the only missing piece as
far as I can see.

If we add such a capability, I can't see any reason why we should need
to disable guest use of storage keys in this patchset.

Paul.
