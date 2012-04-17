Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EDD0BB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 03:17:49 +1000 (EST)
Message-ID: <1334697467.3920.5.camel@joe2Laptop>
Subject: Re: [EDAC ABI v13 24/25] edac: change the mem allocation scheme to
 make Documentation/kobject.txt happy
From: Joe Perches <joe@perches.com>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
In-Reply-To: <1334608729-30803-25-git-send-email-mchehab@redhat.com>
References: <1334608729-30803-1-git-send-email-mchehab@redhat.com>
 <1334608729-30803-25-git-send-email-mchehab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Apr 2012 15:17:47 -0600
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

On Mon, 2012-04-16 at 17:38 -0300, Mauro Carvalho Chehab wrote:
> Kernel kobjects have rigid rules: each container object should be
> dynamically allocated, and can't be allocated into a single kmalloc.
> 
> EDAC never obeyed this rule: it has a single malloc function that
> allocates all needed data into a single kzalloc.
> 
> As this is not accepted anymore, change the allocation schema of the
> EDAC *_info structs to enforce this Kernel standard.
[]
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
[]
> @@ -2228,9 +2228,9 @@ static int init_csrows(struct mem_ctl_info *mci)
>  			edac_mode = EDAC_NONE;
>  
>  		for (j = 0; j < pvt->channel_count; j++) {
> -			csrow->channels[j].dimm->mtype = mtype;
> -			csrow->channels[j].dimm->edac_mode = edac_mode;
> -			csrow->channels[j].dimm->nr_pages = nr_pages;
> +			csrow->channels[j]->dimm->mtype = mtype;
> +			csrow->channels[j]->dimm->edac_mode = edac_mode;
> +			csrow->channels[j]->dimm->nr_pages = nr_pages;

It might be better to use an automatic for
	typeof foo dimm = csrow->channels[j]->dimm;
	dimm->mtype = mtype;
	etc...
[]
> @@ -293,39 +286,56 @@ struct mem_ctl_info *edac_mc_alloc(unsigned edac_index,
>  	mci->mem_is_per_rank = per_rank;
>  
>  	/*
> -	 * Fills the csrow struct
> +	 * Alocate and fill the csrow/channels structs
>  	 */
> +	mci->csrows = kzalloc(sizeof(*mci->csrows) * tot_csrows, GFP_KERNEL);

kcalloc

[]
> +		csr->channels = kzalloc(sizeof(*csr->channels) * tot_cschannels,
> +					GFP_KERNEL);

here too

> @@ -391,7 +401,31 @@ struct mem_ctl_info *edac_mc_alloc(unsigned edac_index,
>  
>  	trace_hw_event_init("edac", (unsigned)edac_index);
>  
> +	debugf1("EDAC MCI allocated\n");
>  	return mci;
> +
> +error:
> +	debugf1("Failed to allocate one or more EDAC MCI structs\n");

Generally, it's not necessary to have specific "OOM" messages
as allocations without GFP_NOWARN do dump_stack()s
