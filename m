Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F319C14009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 20:11:16 +1000 (EST)
Message-ID: <536B5841.2050603@suse.de>
Date: Thu, 08 May 2014 12:11:13 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] KVM: PPC: BOOK3S: HV: Prefer CMA region for hash page
 table allocation
References: <1399391658-1308-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399391658-1308-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On 05/06/2014 05:54 PM, Aneesh Kumar K.V wrote:
> Today when KVM tries to reserve memory for the hash page table it
> allocates from the normal page allocator first. If that fails it
> falls back to CMA's reserved region. One of the side effects of
> this is that we could end up exhausting the page allocator and
> get linux into OOM conditions while we still have plenty of space
> available in CMA.
>
> This patch addresses this issue by first trying hash page table
> allocation from CMA's reserved region before falling back to the normal
> page allocator. So if we run out of memory, we really are out of memory.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue.


Alex
