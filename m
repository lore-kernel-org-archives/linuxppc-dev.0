Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6147E2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 04:39:44 +1000 (EST)
Date: Thu, 27 Jun 2013 13:39:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1372309356-28320-9-git-send-email-aik@ozlabs.ru> (from
 aik@ozlabs.ru on Thu Jun 27 00:02:36 2013)
Message-ID: <1372358363.8183.53@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "Paul E .
 McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2013 12:02:36 AM, Alexey Kardashevskiy wrote:
> +/*
> + * The KVM guest can be backed with 16MB pages.
> + * In this case, we cannot do page counting from the real mode
> + * as the compound pages are used - they are linked in a list
> + * with pointers as virtual addresses which are inaccessible
> + * in real mode.
> + *
> + * The code below keeps a 16MB pages list and uses page struct
> + * in real mode if it is already locked in RAM and inserted into
> + * the list or switches to the virtual mode where it can be
> + * handled in a usual manner.
> + */
> +#define KVMPPC_HUGEPAGE_HASH(gpa)	hash_32(gpa >> 24, 32)
> +
> +struct kvmppc_iommu_hugepage {
> +	struct hlist_node hash_node;
> +	unsigned long gpa;	/* Guest physical address */
> +	unsigned long hpa;	/* Host physical address */
> +	struct page *page;	/* page struct of the very first =20
> subpage */
> +	unsigned long size;	/* Huge page size (always 16MB at the =20
> moment) */
> +};

Shouldn't this be namespaced to something like "book3s" or "spapr"?

-Scott=
