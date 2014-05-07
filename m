Return-Path: <paulus@ozlabs.org>
Date: Wed, 7 May 2014 15:56:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: PR: Fix WARN_ON with debug options on
Message-ID: <20140507055626.GA26650@iris.ozlabs.ibm.com>
References: <1399224368-22122-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399224368-22122-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 04, 2014 at 10:56:08PM +0530, Aneesh Kumar K.V wrote:
> With debug option "sleep inside atomic section checking" enabled we get
> the below WARN_ON during a PR KVM boot. This is because upstream now
> have PREEMPT_COUNT enabled even if we have preempt disabled. Fix the
> warning by adding preempt_disable/enable around floating point and altivec
> enable.

This worries me a bit.  In this code:

>  	if (msr & MSR_FP) {
> +		preempt_disable();
>  		enable_kernel_fp();
>  		load_fp_state(&vcpu->arch.fp);
>  		t->fp_save_area = &vcpu->arch.fp;
> +		preempt_enable();

What would happen if we actually did get preempted at this point?
Wouldn't we lose the FP state we just loaded?

In other words, how come we're not already preempt-disabled at this
point?

Paul.
