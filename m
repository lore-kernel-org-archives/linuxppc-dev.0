Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 627302C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:58:59 +1000 (EST)
Message-ID: <1372046300.3944.131.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Jun 2013 13:58:20 +1000
In-Reply-To: <20130624035426.GE25265@voom.fritz.box>
References: <E63966E3-336F-4CB8-96EC-24D2C1644E62@suse.de>
 <1371653443.21896.291.camel@pasglop>
 <1371656989.22659.98.camel@ul30vt.home> <51C28BEA.8050501@ozlabs.ru>
 <20130620052822.GB3140@voom.redhat.com> <1371714449.3944.14.camel@pasglop>
 <51C2C1CC.9000003@ozlabs.ru> <1371740113.32709.22.camel@ul30vt.home>
 <20130622120304.GB25265@voom.fritz.box> <1371943693.3944.104.camel@pasglop>
 <20130624035426.GE25265@voom.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Joerg Roedel <joro@8bytes.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-24 at 13:54 +1000, David Gibson wrote:
> > DDW means an API by which the guest can request the creation of
> > additional iommus for a given device (typically, in addition to the
> > default smallish 32-bit one using 4k pages, the guest can request
> > a larger window in 64-bit space using a larger page size).
> 
> So, would a PAPR gest requesting this expect the new window to have
> a new liobn, or an existing liobn?

New liobn or there is no way to H_PUT_TCE it (it exists in addition
to the legacy window).

Cheers,
Ben.
