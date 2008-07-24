Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6FCE1DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 11:43:53 +1000 (EST)
Date: Thu, 24 Jul 2008 11:43:53 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 2/6] kvmppc: add hypercall infrastructure - host part
Message-ID: <20080724014352.GI20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 10:36:43AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

Hi Christian,
	A few comments 

> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -203,6 +203,24 @@
>  	kvmppc_set_msr(vcpu, vcpu->arch.srr1);
>  }
>  
> +static int kvmppc_do_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	int ret = 0;
> +
> +	switch (vcpu->arch.gpr[0]) {
> +	default:
> +		printk(KERN_ERR"unknown hypercall %d\n", vcpu->arch.gpr[0]);

I think the preffered style is printk(KERN_ERR "...)  You've made the
same style mistake in most of you printk()'s in your other patches
aswell.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
