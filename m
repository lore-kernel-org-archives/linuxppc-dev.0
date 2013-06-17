Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D37D22C016F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 13:56:17 +1000 (EST)
Message-ID: <1371441361.21896.152.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 17 Jun 2013 13:56:01 +1000
In-Reply-To: <1371438800.22681.38.camel@ul30vt.home>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
 <1371422343.21896.143.camel@pasglop>
 <1371438800.22681.38.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 21:13 -0600, Alex Williamson wrote:

> IOMMU groups themselves don't provide security, they're accessed by
> interfaces like VFIO, which provide the security.  Given a brief look, I
> agree, this looks like a possible backdoor.  The typical VFIO way to
> handle this would be to pass a VFIO file descriptor here to prove that
> the process has access to the IOMMU group.  This is how /dev/vfio/vfio
> gains the ability to setup an IOMMU domain an do mappings with the
> SET_CONTAINER ioctl using a group fd.  Thanks,

How do you envision that in the kernel ? IE. I'm in KVM code, gets that
vfio fd, what do I do with it ?

Basically, KVM needs to know that the user is allowed to use that iommu
group. I don't think we want KVM however to call into VFIO directly
right ?

Cheers,
Ben.
