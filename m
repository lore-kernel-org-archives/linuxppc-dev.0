Return-Path: <ego@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E40CC1A0199
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 18:10:55 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 4 Aug 2014 02:10:52 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 79DE819D8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 02:10:39 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s748AoPa57671706
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Aug 2014 10:10:50 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s748AnCK002653
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Aug 2014 02:10:50 -0600
Date: Mon, 4 Aug 2014 13:40:44 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/cpufreq: Add pr_warn() on OPAL firmware failures
Message-ID: <20140804081044.GA8221@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20140803092158.20134.68818.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140803092158.20134.68818.stgit@drishya>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 03, 2014 at 02:54:05PM +0530, Vaidyanathan Srinivasan wrote:
> @@ -131,7 +136,12 @@ static unsigned int pstate_id_to_freq(int pstate_id)
>  	int i;
> 
>  	i = powernv_pstate_info.max - pstate_id;
> -	BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
> +	if (i >= powernv_pstate_info.nr_pstates || i < 0) {
> +		pr_warn("PState id %d outside of PState table, "
> +			"reporting nominal id %d instead\n",
> +			pstate_id, powernv_pstate_info.nominal);
> +		i = powernv_pstate_info.max - powernv_pstate_info.nominal;

As of now the default loglevel corresponds to KERN_WARNING so this
warning should get printed anyway. However, don't you think it would
be better if we make it a pr_err( ) since it's a platform error that's
causing the pstate_id to go out of bounds ?

Otherwise it looks ok.

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> +	}
> 
>  	return powernv_freqs[i].frequency;
>  }


--
Thanks and Regards
gautham.
