Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CACCB7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 13:51:35 +1000 (EST)
Date: Mon, 12 Apr 2010 20:49:49 -0400
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <abounine@tundra.com>
Subject: Re: [PATCH v3 3/6] RapidIO: Add Port-Write handling for EM
Message-Id: <20100412204949.862b3fab.akpm@linux-foundation.org>
In-Reply-To: <20100406212238.GC26292@amak.tundra.com>
References: <20100406212238.GC26292@amak.tundra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Apr 2010 17:22:38 -0400 Alexandre Bounine <abounine@tundra.com> wrote:

> 
> From: Alexandre Bounine <alexandre.bounine@idt.com>
> 
> Add RapidIO Port-Write message handling in the context
> of Error Management Extensions Specification Rev.1.3.
>
> ...
>
> +static struct rio_dev *rio_get_comptag(u32 comp_tag, struct rio_dev *from)
> +{
> +	struct list_head *n;
> +	struct rio_dev *rdev;
> +
> +	WARN_ON(in_interrupt());

The check should be unneeded - lockdep will warn about this.

> +	spin_lock(&rio_global_list_lock);
> +	n = from ? from->global_list.next : rio_devices.next;
> +
> +	while (n && (n != &rio_devices)) {
> +		rdev = rio_dev_g(n);
> +		if (rdev->comp_tag == comp_tag)
> +			goto exit;
> +		n = n->next;
> +	}
> +	rdev = NULL;
> +exit:
> +	spin_unlock(&rio_global_list_lock);
> +	return rdev;
> +}
> +
