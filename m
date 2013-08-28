Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A44CC2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 11:26:45 +1000 (EST)
Message-ID: <1377653191.3819.146.camel@pasglop>
Subject: Re: [PATCH v8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 28 Aug 2013 11:26:31 +1000
In-Reply-To: <521D4977.7060803@ozlabs.ru>
References: <1376552966-8529-1-git-send-email-aik@ozlabs.ru>
 <20130827075600.GE22899@redhat.com> <521C666A.3020508@ozlabs.ru>
 <20130827105832.GH22899@redhat.com> <521D4977.7060803@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-28 at 10:51 +1000, Alexey Kardashevskiy wrote:
> The ioctl I made up is basically a copy of KVM_CREATE_SPAPR_TCE which does
> the same thing for emulated devices and it is there for quite a while but
> it is not really extensible. And these two ioctls share some bits of code.
> Now we will have 2 pieces of code which do almost the same thing but in a
> different way. Kinda sucks :(

Right. Thus the question, Gleb, we can either:

 - Keep Alexey patch as-is allowing us to *finally* merge that stuff
that's been around for monthes

 - Convert *both* existing TCE objects to the new 
KVM_CREATE_DEVICE, and have some backward compat code for the old one.

I don't think it makes sense to have the "emulated TCE" and "IOMMU TCE"
objects use a fundamentally different API and infrastructure.

> >> So my stuff is not going to upstream again. Heh. Ok. I'll implement it.
> >>
> > Thanks! Should I keep KVM_CAP_SPAPR_MULTITCE capability patch or can I
> > drop it for now?
> 
> Please keep it, it is unrelated to the IOMMU-VFIO thing.
