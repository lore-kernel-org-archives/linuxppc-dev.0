Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 43C57DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 11:49:17 +1000 (EST)
Date: Thu, 24 Jul 2008 11:49:15 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 4/6] kvmppc: magic page hypercall - host part
Message-ID: <20080724014914.GK20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

On Wed, Jul 23, 2008 at 10:36:45AM +0200, ehrhardt@linux.vnet.ibm.com wrote:

Hi Christian,

>  long kvm_arch_dev_ioctl(struct file *filp,
>                          unsigned int ioctl, unsigned long arg)
>  {
> -	return -EINVAL;
> +	long r = -EINVAL;
> +
> +	switch (ioctl) {
> +	case KVM_GET_PPCPV_MAGICPAGE_SIZE:
> +		r = -EINVAL;

Not needed you set it on the declaration.

> +		if (arg)
> +			goto out;
> +		r = 1024;

Ummm what does 1024 represent? can it me #defined? or at least add a
comment.

> +		break;
> +	default:
> +		r = -EINVAL;

Not needed you set it on the declaration.

> +	}
> +out:
> +	return r;
>  }

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
