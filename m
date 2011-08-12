Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Aug 2011 13:35:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 07/10] KVM: PPC: Add PAPR hypercall code for PR mode
Message-ID: <20110812033529.GS30552@yookeroo.fritz.box>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-8-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312907508-14599-8-git-send-email-agraf@suse.de>
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

On Tue, Aug 09, 2011 at 06:31:45PM +0200, Alexander Graf wrote:
> When running a PAPR guest, we need to handle a few hypercalls in kernel space,
> most prominently the page table invalidation (to sync the shadows).
> 
> So this patch adds handling for a few PAPR hypercalls to PR mode KVM. I tried
> to share the code with HV mode, but it ended up being a lot easier this way
> around, as the two differ too much in those details.

Are these strictly necessary, or just an optimization?  Because you're
using the space allocated by qemu for the guest hash table, it seems
to be you could just let h_enter fall through to qemu which will put
the right thing into the guest hash table which you can then walk in
the kernel translation code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
