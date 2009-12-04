Return-Path: <duwe@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16170B7BF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 09:25:58 +1100 (EST)
From: Torsten Duwe <duwe@lst.de>
To: arun@linux.vnet.ibm.com
Subject: Re: [v10 PATCH 2/9]: cpuidle: cleanup drivers/cpuidle/cpuidle.c
Date: Fri, 4 Dec 2009 23:20:00 +0100
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<20091202095705.GC27251@linux.vnet.ibm.com>
In-Reply-To: <20091202095705.GC27251@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200912042320.01320.duwe@lst.de>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 02 December 2009, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-12-02 15:24:27]:
>
> This patch cleans up drivers/cpuidle/cpuidle.c
> Earlier cpuidle assumed pm_idle as the default idle loop. Break that
> assumption and make it more generic.

Is there a problem with the old pm_idle? Couldn't it be integrated more 
transparently, instead of replacing it this intrusively?

> --- linux.trees.git.orig/include/linux/cpuidle.h
> +++ linux.trees.git/include/linux/cpuidle.h
> @@ -41,7 +41,7 @@ struct cpuidle_state {
>  	unsigned long long	usage;
>  	unsigned long long	time; /* in US */
>
> -	int (*enter)	(struct cpuidle_device *dev,
> +	void (*enter)	(struct cpuidle_device *dev,
>  			 struct cpuidle_state *state);
>  };

While it may be a good idea to move the residency calculation to one central 
place, at least in theory a cpuidle_state->enter() function could have a 
better method to determine its value.

Either way you're implicitly introducing an API change here, and you're at 
least missing two functions on ARM and SuperH, respectively. Could you 
separate this API change out, and not take it for granted in the other 
patches?

	Torsten
