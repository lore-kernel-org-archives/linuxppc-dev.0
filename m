Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2A012C00FD
 for <linuxppc-dev@ozlabs.org>; Tue,  7 May 2013 00:56:09 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 7 May 2013 00:40:27 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EF42D2CE9000
 for <linuxppc-dev@ozlabs.org>; Mon,  6 May 2013 22:26:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46CPuk820512804
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 22:25:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46CQ2m6010742
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 22:26:02 +1000
Message-ID: <5187A144.9080307@linux.vnet.ibm.com>
Date: Mon, 06 May 2013 17:55:40 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc, perf: Fix processing conditions for invalid
 BHRB entries
References: <1367831206-16331-1-git-send-email-khandual@linux.vnet.ibm.com>
 <24261.1367838705@ale.ozlabs.ibm.com>
In-Reply-To: <24261.1367838705@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2013 04:41 PM, Michael Neuling wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> Fixing some conditions during BHRB entry processing.
> 
> I think we can simplify this a lot more... something like the below.
> 

I feel that the conditional handling of the invalid BHRB entries should be
present which would help us during the debug and also could be used for more
granular branch classification or error handling later on.

> Also, this marks the "to" address as all 1s, which is better poison
> value since it's possible to branch to/from 0x0.
>

Agreed.


> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index c627843..d410d65 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1463,65 +1463,45 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>  {
>  	u64 val;
>  	u64 addr;
> -	int r_index, u_index, target, pred;
> +	int r_index, u_index, pred;
> 
>  	r_index = 0;
>  	u_index = 0;
>  	while (r_index < ppmu->bhrb_nr) {
>  		/* Assembly read function */
> -		val = read_bhrb(r_index);
> +		val = read_bhrb(r_index++);
> 
>  		/* Terminal marker: End of valid BHRB entries */
> -		if (val == 0) {
> +		if (!val) {
>  			break;
>  		} else {
>  			/* BHRB field break up */
>  			addr = val & BHRB_EA;
>  			pred = val & BHRB_PREDICTION;
> -			target = val & BHRB_TARGET;
> 
> -			/* Probable Missed entry: Not applicable for POWER8 */
> -			if ((addr == 0) && (target == 0) && (pred == 1)) {
> -				r_index++;
> +			if (!addr)
> +				/* invalid entry */
>  				continue;
> -			}
> -
> -			/* Real Missed entry: Power8 based missed entry */
> -			if ((addr == 0) && (target == 1) && (pred == 1)) {
> -				r_index++;
> -				continue;
> -			}
> 
> -			/* Reserved condition: Not a valid entry  */
> -			if ((addr == 0) && (target == 1) && (pred == 0)) {
> -				r_index++;
> -				continue;
> -			}
> -
> -			/* Is a target address */
>  			if (val & BHRB_TARGET) {
>  				/* First address cannot be a target address */
> -				if (r_index == 0) {
> -					r_index++;
> +				if (r_index == 0)
>  					continue;
> -				}
> 
>  				/* Update target address for the previous entry */
>  				cpuhw->bhrb_entries[u_index - 1].to = addr;
>  				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
>  				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
> -
> -				/* Dont increment u_index */
> -				r_index++;
>  			} else {
>  				/* Update address, flags for current entry */
>  				cpuhw->bhrb_entries[u_index].from = addr;
> +				cpuhw->bhrb_entries[u_index].to =
> +					0xffffffffffffffff;
>  				cpuhw->bhrb_entries[u_index].mispred = pred;
>  				cpuhw->bhrb_entries[u_index].predicted = ~pred;
> 
>  				/* Successfully popullated one entry */
>  				u_index++;
> -				r_index++;
>  			}
>  		}
>  	}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
