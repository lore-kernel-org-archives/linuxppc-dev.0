Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59E8714009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 20:12:35 +1000 (EST)
Message-ID: <536B5890.1090806@suse.de>
Date: Thu, 08 May 2014 12:12:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] KVM: PPC: BOOK3S: HV: Add mixed page-size support
 for guest
References: <1399399296-17711-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399399296-17711-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 08:01 PM, Aneesh Kumar K.V wrote:
> On recent IBM Power CPUs, while the hashed page table is looked up using
> the page size from the segmentation hardware (i.e. the SLB), it is
> possible to have the HPT entry indicate a larger page size.  Thus for
> example it is possible to put a 16MB page in a 64kB segment, but since
> the hash lookup is done using a 64kB page size, it may be necessary to
> put multiple entries in the HPT for a single 16MB page.  This
> capability is called mixed page-size segment (MPSS).  With MPSS,
> there are two relevant page sizes: the base page size, which is the
> size used in searching the HPT, and the actual page size, which is the
> size indicated in the HPT entry. [ Note that the actual page size is
> always >= base page size ].
>
> We use "ibm,segment-page-sizes" device tree node to advertise
> the MPSS support to PAPR guest. The penc encoding indicates whether
> we support a specific combination of base page size and actual
> page size in the same segment. We also use the penc value in the
> LP encoding of HPTE entry.
>
> This patch exposes MPSS support to KVM guest by advertising the
> feature via "ibm,segment-page-sizes". It also adds the necessary changes
> to decode the base page size and the actual page size correctly from the
> HPTE entry.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue.


Alex
