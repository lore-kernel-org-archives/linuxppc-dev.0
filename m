Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 3A821DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 11:59:26 +1000 (EST)
Date: Thu, 24 Jul 2008 11:59:25 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] kvmppc: magic page paravirtualization - guest part
Message-ID: <20080724015925.GL20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-6-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-6-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

On Wed, Jul 23, 2008 at 10:36:46AM +0200, ehrhardt@linux.vnet.ibm.com wrote:

Hi Christian,

<snip>

> +/*
> + * this is guest memory granted to the hypervisor;
> + * the hypervisor can place data in this area and rewrite
> + * privileged instructions to read from this area without
> + * trapping.
> + * Only the Hypervisor needs to be aware of the structure layout
> + * which makes the guest more felxible - the guest only guarantees
> + * the size which is requested by the hypervisor and read from a
> + * device tree entry.
> + */
> +void *kvm_magicpage;

static?

<snip>

> +/* reads the specified data field out of the hypervisor node */
> +static inline int kvmppc_pv_read_data(char *dtcell)
> +{
> +	struct device_node *dn;
> +	const int *dtval;
> +
> +	dn = of_find_node_by_path("/hypervisor");
> +	if (!dn)
> +		return -EINVAL;
> +
> +	dtval = of_get_property(dn, dtcell, NULL);
> +	if (dtval)
> +		return *dtval;
> +	else
> +		return -EINVAL;

You need an of_node_put(dn) in this function somewhere.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
