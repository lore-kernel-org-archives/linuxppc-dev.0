Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 983712C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 08:39:18 +1000 (EST)
Message-ID: <1371422343.21896.143.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 17 Jun 2013 08:39:03 +1000
In-Reply-To: <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
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

On Wed, 2013-06-05 at 16:11 +1000, Alexey Kardashevskiy wrote:
> +long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
> +               struct kvm_create_spapr_tce_iommu *args)
> +{
> +       struct kvmppc_spapr_tce_table *tt = NULL;
> +       struct iommu_group *grp;
> +       struct iommu_table *tbl;
> +
> +       /* Find an IOMMU table for the given ID */
> +       grp = iommu_group_get_by_id(args->iommu_id);
> +       if (!grp)
> +               return -ENXIO;
> +
> +       tbl = iommu_group_get_iommudata(grp);
> +       if (!tbl)
> +               return -ENXIO;

So Alex Graf pointed out here, there is a security issue here, or are we
missing something ?

What prevents a malicious program that has access to /dev/kvm from
taking over random iommu groups (including host used ones) that way?

What is the security model of that whole iommu stuff to begin with ?

Cheers,
Ben.
