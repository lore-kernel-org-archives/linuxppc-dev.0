Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0987514136B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 01:06:53 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 20:36:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0CA58394005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 20:36:48 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46F6q2o30474318
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 20:36:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46F6kE7008401
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 20:36:46 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
In-Reply-To: <5368ADE3.1050503@suse.de>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5368A78D.4070509@suse.de> <1399368400.18906.9.camel@pasglop>
 <5368ADE3.1050503@suse.de>
Date: Tue, 06 May 2014 20:36:46 +0530
Message-ID: <87oazbq73t.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05/06/2014 11:26 AM, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-05-06 at 11:12 +0200, Alexander Graf wrote:
>>

.....


I updated the commit message as below. Let me know if this is ok.

    KVM: PPC: BOOK3S: HV: THP support for guest
    
    On recent IBM Power CPUs, while the hashed page table is looked up using
    the page size from the segmentation hardware (i.e. the SLB), it is
    possible to have the HPT entry indicate a larger page size.  Thus for
    example it is possible to put a 16MB page in a 64kB segment, but since
    the hash lookup is done using a 64kB page size, it may be necessary to
    put multiple entries in the HPT for a single 16MB page.  This
    capability is called mixed page-size segment (MPSS).  With MPSS,
    there are two relevant page sizes: the base page size, which is the
    size used in searching the HPT, and the actual page size, which is the
    size indicated in the HPT entry. [ Note that the actual page size is
    always >= base page size ].
    
    We advertise MPSS feature to guest only if the host CPU supports the
    same. We use "ibm,segment-page-sizes" device tree node to advertise
    the MPSS support. The penc encoding indicate whether we support
    a specific combination of base page size and actual page size
    in the same segment. It is also the value used in the L|LP encoding
    of HPTE entry.
    
    In-order to support MPSS in guest, KVM need to handle the below details
    * advertise MPSS via ibm,segment-page-sizes
    * Decode the base and actual page size correctly from the HPTE entry
      so that we know what we are dealing with in H_ENTER and and can do
      the appropriate TLB invalidation in H_REMOVE and evictions.
    


>
> yes. When / if people can easily get their hands on p7/p8 bare metal 
> systems I'll be more than happy to remove 970 support as well, but for 
> now it's probably good to keep in.
>

This should handle that.

+	/*
+	 * Add 16MB MPSS support if host supports it
+	 */
+	if (linux_psize != MMU_PAGE_16M && def->penc[MMU_PAGE_16M] != -1) {
+		(*sps)->enc[1].page_shift = 24;
+		(*sps)->enc[1].pte_enc = def->penc[MMU_PAGE_16M];
+	}
 	(*sps)++;

-aneesh
