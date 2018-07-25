Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bCYQ6TSNzF0XQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 21:24:26 +1000 (AEST)
Date: Wed, 25 Jul 2018 21:24:21 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au, clg@kaod.org
Subject: Re: [PATCH v4 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180725112421.GA25494@fergus>
References: <dc8e985d05d7de08cce080dfe6e70beeed2a50a1.1532499120.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dc8e985d05d7de08cce080dfe6e70beeed2a50a1.1532499120.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2018 at 04:12:02PM +1000, Sam Bobroff wrote:
> From: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> It is not currently possible to create the full number of possible
> VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
> threads per core than it's core stride (or "VSMT mode"). This is
> because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
> even though the VCPU ID is less than KVM_MAX_VCPU_ID.
> 
> To address this, "pack" the VCORE ID and XIVE offsets by using
> knowledge of the way the VCPU IDs will be used when there are less
> guest threads per core than the core stride. The primary thread of
> each core will always be used first. Then, if the guest uses more than
> one thread per core, these secondary threads will sequentially follow
> the primary in each core.
> 
> So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
> VCPUs are being spaced apart, so at least half of each core is empty
> and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
> into the second half of each core (4..7, in an 8-thread core).
> 
> Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
> each core is being left empty, and we can map down into the second and
> third quarters of each core (2, 3 and 5, 6 in an 8-thread core).
> 
> Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
> threads are being used and 7/8 of the core is empty, allowing use of
> the 1, 5, 3 and 7 thread slots.
> 
> (Strides less than 8 are handled similarly.)
> 
> This allows the VCORE ID or offset to be calculated quickly from the
> VCPU ID or XIVE server numbers, without access to the VCPU structure.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
