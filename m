Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5351B6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 05:27:33 +1100 (EST)
References: <1330481769-24390-1-git-send-email-agraf@suse.de>
 <4F4E6574.5050604@freescale.com>
In-Reply-To: <4F4E6574.5050604@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <39AA9511-4D56-4087-BC98-4BB32EF048AA@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Don't sync timebase when inside KVM
Date: Wed, 29 Feb 2012 19:28:20 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 29.02.2012, at 18:50, Scott Wood <scottwood@freescale.com> wrote:

> On 02/28/2012 08:16 PM, Alexander Graf wrote:
>> When we know that we're running inside of a KVM guest, we don't have to
>> worry about synchronizing timebases between different CPUs, since the
>> host already took care of that.
>> 
>> This fixes CPU overcommit scenarios where vCPUs could hang forever trying
>> to sync each other while not being scheduled.
>> 
>> Reported-by: Stuart Yoder <B08248@freescale.com>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> This should apply to any hypervisor, not just KVM.  

Sure, but do you have a generic function to evaluate that? :)

> On book3e, Power ISA
> says timebase is read-only on virtualized implementations.  My
> understanding is that book3s is paravirt-only (guest state is not
> considered an implementation of the Power ISA), and it says "Writing the
> Time Base is privileged, and can be done only in hypervisor state".

For PR non-PAPR KVM, we are non-paravirt, but ignore tb writes iirc.

> 
> Which platforms are you seeing this on?  If it's on Freescale chips,
> U-Boot should be doing the sync and Linux should never do it, even in
> the absence of a hypervisor.

This is on e500mc.

Alex

> 
> -Scott
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
