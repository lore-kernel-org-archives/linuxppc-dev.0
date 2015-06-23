Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 136B31A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 11:16:50 +1000 (AEST)
Date: Tue, 23 Jun 2015 11:16:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
Message-ID: <20150623111648.1e31a497@kryten>
In-Reply-To: <87lhfs5ewc.fsf@linux.vnet.ibm.com>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87lhfs5ewc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nikunj,

> From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> 
> powerpc/numa: initialize distance lookup table from drconf path
> 
> In some situations, a NUMA guest that supports
> ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
> distances between nodes. This is because of two problems in the
> current code.

Thanks for the patch. Have we tested that this doesn't regress the
non dynamic representation?

Regards,
Anton

> 1) Different representations of associativity lists.
> 
>    There is an assumption about the associativity list in
>    initialize_distance_lookup_table(). Associativity list has two
> forms:
> 
>    a) [cpu,memory]@x/ibm,associativity has following
>       format:
>            <N> <N integers>
> 
>    b)
> ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays
> 
>            <M> <N> <M associativity lists each having N integers>
>            M = the number of associativity lists
>            N = the number of entries per associativity list
> 
>    Fix initialize_distance_lookup_table() so that it does not assume
>    "case a". And update the caller to skip the length field before
>    sending the associativity list.
> 
> 2) Distance table not getting updated from drconf path.
> 
>    Node distance table will not get initialized in certain cases as
>    ibm,dynamic-reconfiguration-memory path does not initialize the
>    lookup table.
> 
>    Call initialize_distance_lookup_table() from drconf path with
>    appropriate associativity list.
> 
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 5e80621..8b9502a 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -225,7 +225,7 @@ static void initialize_distance_lookup_table(int
> nid, for (i = 0; i < distance_ref_points_depth; i++) {
>  		const __be32 *entry;
>  
> -		entry =
> &associativity[be32_to_cpu(distance_ref_points[i])];
> +		entry =
> &associativity[be32_to_cpu(distance_ref_points[i]) - 1];
> distance_lookup_table[nid][i] = of_read_number(entry, 1); }
>  }
> @@ -248,8 +248,12 @@ static int associativity_to_nid(const __be32
> *associativity) nid = -1;
>  
>  	if (nid > 0 &&
> -	    of_read_number(associativity, 1) >=
> distance_ref_points_depth)
> -		initialize_distance_lookup_table(nid, associativity);
> +		of_read_number(associativity, 1) >=
> distance_ref_points_depth) {
> +		/*
> +		 * Skip the length field and send start of
> associativity array
> +		 */
> +		initialize_distance_lookup_table(nid, associativity
> + 1);
> +	}
>  
>  out:
>  	return nid;
> @@ -507,6 +511,12 @@ static int of_drconf_to_nid_single(struct
> of_drconf_cell *drmem, 
>  		if (nid == 0xffff || nid >= MAX_NUMNODES)
>  			nid = default_nid;
> +
> +		if (nid > 0) {
> +			index = drmem->aa_index * aa->array_sz;
> +			initialize_distance_lookup_table(nid,
> +
> &aa->arrays[index]);
> +		}
>  	}
>  
>  	return nid;
