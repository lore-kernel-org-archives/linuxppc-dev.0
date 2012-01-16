Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DD8F1007D2
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 00:11:52 +1100 (EST)
Subject: Re: [KVM PATCH 2/2] KVM: PPC: Book3S HV: Report stolen time to guest
 through dispatch trace log
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111220103723.GD5626@bloggs.ozlabs.ibm.com>
Date: Mon, 16 Jan 2012 14:11:46 +0100
Message-Id: <D171F452-FC1A-49BE-B15B-43A52506802B@suse.de>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220103723.GD5626@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.12.2011, at 11:37, Paul Mackerras wrote:

> This adds code to measure "stolen" time per virtual core in units of
> timebase ticks, and to report the stolen time to the guest using the
> dispatch trace log (DTL).  The guest can register an area of memory
> for the DTL for a given vcpu.  The DTL is a ring buffer where KVM
> fills in one entry every time it enters the guest for that vcpu.
> 
> Stolen time is measured as time when the virtual core is not running,
> either because the vcore is not runnable (e.g. some of its vcpus are
> executing elsewhere in the kernel or in userspace), or when the vcpu
> thread that is running the vcore is preempted.  This includes time
> when all the vcpus are idle (i.e. have executed the H_CEDE hypercall),
> which is OK because the guest accounts stolen time while idle as idle
> time.
> 
> Each vcpu keeps a record of how much stolen time has been reported to
> the guest for that vcpu so far.  When we are about to enter the guest,
> we create a new DTL entry (if the guest vcpu has a DTL) and report the
> difference between total stolen time for the vcore and stolen time
> reported so far for the vcpu as the "enqueue to dispatch" time in the
> DTL entry.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

This patch makes sense and looks good to me :)


Alex
