Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71F902C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 14:39:14 +1000 (EST)
Message-ID: <1371530335.21896.169.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 18 Jun 2013 14:38:55 +1000
In-Reply-To: <1371522772.22681.140.camel@ul30vt.home>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
 <1371422343.21896.143.camel@pasglop>
 <1371438800.22681.38.camel@ul30vt.home>
 <1371441361.21896.152.camel@pasglop>
 <1371522772.22681.140.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Rusty Russell <rusty@rustcorp.com.au>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, 2013-06-17 at 20:32 -0600, Alex Williamson wrote:

> Right, we don't want to create dependencies across modules.  I don't
> have a vision for how this should work.  This is effectively a complete
> side-band to vfio, so we're really just dealing in the iommu group
> space.  Maybe there needs to be some kind of registration of ownership
> for the group using some kind of token.  It would need to include some
> kind of notification when that ownership ends.  That might also be a
> convenient tag to toggle driver probing off for devices in the group.
> Other ideas?  Thanks,

All of that smells nasty like it will need a pile of bloody
infrastructure.... which makes me think it's too complicated and not the
right approach.

How does access control work today on x86/VFIO ? Can you give me a bit
more details ? I didn't get a good grasp in your previous email....

>From the look of it, the VFIO file descriptor is what has the "access
control" to the underlying iommu, is this right ? So we somewhat need to
transfer (or copy) that ownership from the VFIO fd to the KVM VM.

I don't see a way to do that without some cross-layering here...

Rusty, are you aware of some kernel mechanism we can use for that ?

Cheers,
Ben.
