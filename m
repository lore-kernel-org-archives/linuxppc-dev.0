Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1476FDDDDF
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 07:56:51 +1100 (EST)
Subject: Re: linux-next: scsi-post-merge tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081223012545.5b1e7f5e.sfr@canb.auug.org.au>
References: <20081223012545.5b1e7f5e.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 07:56:32 +1100
Message-Id: <1229979392.4360.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-23 at 01:25 +1100, Stephen Rothwell wrote:
> Hi Paul, Ben,
> 
> Today's linux-next build (powerpc ppc44x_config) failed like this:
> 
> arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_put':
> arch/powerpc/kvm/powerpc.c:333: error: implicit declaration of function '_tlbil_all'
> 
> Probably caused by commit 2a4aca1144394653269720ffbb5a325a77abd5fa
> ("powerpc/mm: Split low level tlb invalidate for nohash processors").
> Reverting just that commit was too difficult, so I have reverted the
> powerpc tree for today.

You can't revert that without reverting my whole series.

Adding a #include ../mm/mmu_decl.h to the kvm code should fix it for
now.

I need to talk to hollis about the right way to do that stuff in
the long run but it might be it... those _tlbil things are low level
stuff that aren't supposed to be used by the outside world which is
why I moved the declarations there, but KVM is also low level :-)

Cheers,
Ben.
