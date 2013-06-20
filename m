Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 84A702C02A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 17:47:48 +1000 (EST)
Message-ID: <1371714449.3944.14.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 20 Jun 2013 17:47:29 +1000
In-Reply-To: <20130620052822.GB3140@voom.redhat.com>
References: <1371422343.21896.143.camel@pasglop>
 <1371438800.22681.38.camel@ul30vt.home>
 <1371441361.21896.152.camel@pasglop>
 <1371522772.22681.140.camel@ul30vt.home> <87txkun568.fsf@rustcorp.com.au>
 <1371617970.21896.232.camel@pasglop>
 <E63966E3-336F-4CB8-96EC-24D2C1644E62@suse.de>
 <1371653443.21896.291.camel@pasglop>
 <1371656989.22659.98.camel@ul30vt.home> <51C28BEA.8050501@ozlabs.ru>
 <20130620052822.GB3140@voom.redhat.com>
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

On Thu, 2013-06-20 at 15:28 +1000, David Gibson wrote:
> > Just out of curiosity - would not get_file() and fput_atomic() on a
> group's
> > file* do the right job instead of vfio_group_add_external_user() and
> > vfio_group_del_external_user()?
> 
> I was thinking that too.  Grabbing a file reference would certainly be
> the usual way of handling this sort of thing.

But that wouldn't prevent the group ownership to be returned to
the kernel or another user would it ?

Ben.
