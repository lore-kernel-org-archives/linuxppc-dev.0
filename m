Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ZTQ4j1CzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 16:06:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A646uF064488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:06:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bjujyr0sc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:05:59 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 10 Jul 2017 02:05:59 -0400
Date: Sun, 9 Jul 2017 23:05:44 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <d9030b2c-493b-94c4-8c97-8aaec3be34ba@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d9030b2c-493b-94c4-8c97-8aaec3be34ba@linux.vnet.ibm.com>
Message-Id: <20170710060544.GF5713@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 11:13:23AM +0530, Anshuman Khandual wrote:
> On 07/06/2017 02:51 AM, Ram Pai wrote:
> > Memory protection keys enable applications to protect its
> > address space from inadvertent access or corruption from
> > itself.
> > 
> > The overall idea:
> > 
> >  A process allocates a   key  and associates it with
> >  an  address  range  within    its   address   space.
> >  The process  then  can  dynamically  set read/write 
> >  permissions on  the   key   without  involving  the 
> >  kernel. Any  code that  violates   the  permissions
> >  of  the address space; as defined by its associated
> >  key, will receive a segmentation fault.
> > 
> > This patch series enables the feature on PPC64 HPTE
> > platform.
> > 
> > ISA3.0 section 5.7.13 describes the detailed specifications.
> > 
> > 
> > Testing:
> > 	This patch series has passed all the protection key
> > 	tests available in  the selftests directory.
> > 	The tests are updated to work on both x86 and powerpc.
> > 
> > version v5:
> > 	(1) reverted back to the old design -- store the 
> > 	    key in the pte, instead of bypassing it.
> > 	    The v4 design slowed down the hash page path.
> > 	(2) detects key violation when kernel is told to 
> > 		access user pages.
> > 	(3) further refined the patches into smaller consumable
> > 		units
> > 	(4) page faults handlers captures the faulting key 
> > 	    from the pte instead of the vma. This closes a
> > 	    race between where the key update in the vma and
> > 	    a key fault caused cause by the key programmed
> > 	    in the pte.
> > 	(5) a key created with access-denied should
> > 	    also set it up to deny write. Fixed it.
> > 	(6) protection-key number is displayed in smaps
> > 		the x86 way.
> 
> Hello Ram,
> 
> This patch series has now grown a lot. Do you have this
> hosted some where for us to pull and test it out ? BTW

https://github.com/rampai/memorykeys.git
branch memkey.v5.3

> do you have data points to show the difference in
> performance between this version and the last one where
> we skipped the bits from PTE and directly programmed the
> HPTE entries looking into VMA bits.

No. I dont. I am hoping you can help me out with this.
RP
