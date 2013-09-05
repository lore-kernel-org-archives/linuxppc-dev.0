Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F2492C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 14:05:24 +1000 (EST)
Message-ID: <1378353909.4321.126.camel@pasglop>
Subject: Re: [PATCH v9 12/13] KVM: PPC: Add support for IOMMU in-kernel
 handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Thu, 05 Sep 2013 14:05:09 +1000
In-Reply-To: <20130903105315.GY22899@redhat.com>
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
 <1377679841-3822-1-git-send-email-aik@ozlabs.ru>
 <20130901120609.GJ22899@redhat.com> <52240295.7050608@ozlabs.ru>
 <20130903105315.GY22899@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-03 at 13:53 +0300, Gleb Natapov wrote:
> > Or supporting all IOMMU links (and leaving emulated stuff as is) in on
> > "device" is the last thing I have to do and then you'll ack the patch?
> > 
> I am concerned more about API here. Internal implementation details I
> leave to powerpc experts :)

So Gleb, I want to step in for a bit here.

While I understand that the new KVM device API is all nice and shiny and that this
whole thing should probably have been KVM devices in the first place (had they
existed or had we been told back then), the point is, the API for handling
HW IOMMUs that Alexey is trying to add is an extension of an existing mechanism
used for emulated IOMMUs.

The internal data structure is shared, and fundamentally, by forcing him to
use that new KVM device for the "new stuff", we create a oddball API with
an ioctl for one type of iommu and a KVM device for the other, which makes
the implementation a complete mess in the kernel (and you should care :-)

So for something completely new, I would tend to agree with you. However, I
still think that for this specific case, we should just plonk-in the original
ioctl proposed by Alexey and be done with it.

Cheers,
Ben.
