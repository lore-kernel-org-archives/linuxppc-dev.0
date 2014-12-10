Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 341961A0271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 21:03:44 +1100 (AEDT)
Message-ID: <1418205823.9279.8.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 5/8] perf probe powerpc: Allow matching against dot
 symbols
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 21:03:43 +1100
In-Reply-To: <d23252a0bb8a34b2eac9049b34d674aa2d6a2b6a.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <d23252a0bb8a34b2eac9049b34d674aa2d6a2b6a.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> Allow perf probe to work on powerpc ABIv1 without the need to specify the
> leading dot '.' for functions. 'perf probe do_fork' works with this patch.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/probe-event.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index d465f7c..174c22e 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2221,6 +2221,15 @@ static int probe_function_filter(struct map *map __maybe_unused,
>  		num_matched_functions++;
>  		return 0;
>  	}
> +#ifdef __powerpc64__
> +	/* Allow matching against the dot variant */
> +	if (sym->name[0] == '.' && looking_function_name[0] != '.' &&
> +	    (sym->binding == STB_GLOBAL || sym->binding == STB_LOCAL) &&
> +	    strcmp(looking_function_name, sym->name+1) == 0) {
> +		num_matched_functions++;
> +		return 0;
> +	}
> +#endif

As for the previous patch, I think this should be in an arch helper.

cheers
