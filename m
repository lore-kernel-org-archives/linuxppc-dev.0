Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE9B4B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 04:10:31 +1000 (EST)
Message-ID: <1335076630.13194.6.camel@joe2Laptop>
Subject: Re: [EDAC ABI v13 24/25] edac: change the mem allocation scheme to
 make Documentation/kobject.txt happy
From: Joe Perches <joe@perches.com>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
In-Reply-To: <4F900FB3.6000607@redhat.com>
References: <1334608729-30803-1-git-send-email-mchehab@redhat.com>
 <1334608729-30803-25-git-send-email-mchehab@redhat.com>
 <1334697467.3920.5.camel@joe2Laptop> <4F900FB3.6000607@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Apr 2012 01:37:10 -0500
Mime-Version: 1.0
Cc: "Arvind R." <arvino55@gmail.com>, Michal Marek <mmarek@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, Mark Gross <mark.gross@intel.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Jason Uhlenkott <juhlenko@akamai.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Egor Martovetsky <egor@pasemi.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tim Small <tim@buttersideup.com>,
 Hitoshi Mitake <h.mitake@gmail.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-04-19 at 10:14 -0300, Mauro Carvalho Chehab wrote:
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
[]
> @@ -296,7 +296,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned edac_index,
>  	/*
>  	 * Alocate and fill the csrow/channels structs
>  	 */
> -	mci->csrows = kzalloc(sizeof(*mci->csrows) * tot_csrows, GFP_KERNEL);
> +	mci->csrows = kcalloc(sizeof(*mci->csrows), tot_csrows, GFP_KERNEL);

trivia:  the first 2 args to kcalloc should be swapped.

static inline void *kcalloc(size_t n, size_t size, gfp_t flags)

	kcalloc(tot_csrows, sizeof(*mci->csrows), GFP_KERNEL);
[]
> @@ -307,7 +307,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned edac_index,
>  		csr->csrow_idx = row;
>  		csr->mci = mci;
>  		csr->nr_channels = tot_cschannels;
> -		csr->channels = kzalloc(sizeof(*csr->channels) * tot_cschannels,
> +		csr->channels = kcalloc(sizeof(*csr->channels), tot_cschannels,

and here.

[]
> @@ -323,7 +323,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned edac_index,
>  	/*
>  	 * Allocate and fill the dimm structs
>  	 */
> -	mci->dimms  = kzalloc(sizeof(*mci->dimms) * tot_dimms, GFP_KERNEL);
> +	mci->dimms  = kcalloc(sizeof(*mci->dimms), tot_dimms, GFP_KERNEL);

and here too.
