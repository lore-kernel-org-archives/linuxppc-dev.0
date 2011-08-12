Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Aug 2011 13:33:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 09/10] KVM: PPC: Support SC1 hypercalls for PAPR in PR mode
Message-ID: <20110812033343.GR30552@yookeroo.fritz.box>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-10-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312907508-14599-10-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 06:31:47PM +0200, Alexander Graf wrote:
> PAPR defines hypercalls as SC1 instructions. Using these, the guest modifies
> page tables and does other privileged operations that it wouldn't be allowed
> to do in supervisor mode.
> 
> This patch adds support for PR KVM to trap these instructions and route them
> through the same PAPR hypercall interface that we already use for HV style
> KVM.

This will work on a powermac or bare metal host.  Unfortunately, it's
not enough on a pSeries LPAR host - the sc 1 instruction from the
guest problem state will go direct to the hypervisor, which will
return an error rather than trapping to the guest kernel.

The only way around this I can see is for qemu to search for and patch
up sc 1 instructions to something else.  Obviously that would also
need some kernel support, and probably a capability to let it know if
it's necessary.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
