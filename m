Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A1A1A001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 22:16:07 +1000 (EST)
Message-ID: <53FDCC04.9000605@suse.de>
Date: Wed, 27 Aug 2014 14:16:04 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4 5/6] KVM: PPC: Booke: Add setter functions for IVPR,
 IVOR2 and IVOR8 emulation
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
 <1408541787-24625-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-6-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20.08.14 15:36, Mihai Caraman wrote:
> Add setter functions for IVPR, IVOR2 and IVOR8 emulation in preparation
> for ONE_REG support.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

What about the other GIVORs?

Also, I would prefer to have a common helper for IVOR setting that
simply covers SPRN_GIVOR setting along the way. Something like

void kvmppc_set_ivor(struct kvm_vcpu *vcpu, int irqprio_ivor, u16 new_ivor)
{
    vcpu->arch.ivor[irqprio_ivor] = new_ivor;
    switch (irqprio_ivor) {
    case BOOKE_IRQPRIO_DATA_STORAGE:
        mtspr(SPRN_GIVOR2, new_ivor);
        break;
    ...
    }
}

which you can just call from all the IVOR setters. In fact, you can
probably combine all of the ONE_REG handlers into a single handler that
just does a quick table lookup for its irqprio.


Alex
