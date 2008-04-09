Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5D638DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 04:19:56 +1000 (EST)
Date: Wed, 9 Apr 2008 13:30:32 -0500
From: Olof Johansson <olof@lixom.net>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
Message-ID: <20080409183032.GA2360@lixom.net>
References: <47FAB221.7050406@austin.ibm.com>
	<20080408024352.GA32761@lixom.net>
	<47FCFEEF.6020607@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FCFEEF.6020607@austin.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 12:37:51PM -0500, Manish Ahuja wrote:
> Olof Johansson wrote:
> >> +static inline unsigned long phyp_dump_calculate_reserve_size(void)
> >> +{
> >> +	unsigned long tmp;
> >> +
> >> +	if (phyp_dump_info->phyp_dump_reserve_bootvar)
> >> +		return phyp_dump_info->phyp_dump_reserve_bootvar;
> >> +
> >> +	/* divide by 20 to get 5% of value */
> >> +	tmp = lmb_end_of_DRAM();
> >> +	do_div(tmp, 20);
> >> +
> >> +	/* round it down in multiples of 256 */
> >> +	tmp = tmp & ~0x000000001FFFFFFF;
> > 
> > That's 512MB, isn't it?
> 
> My calculations in the example I gave in the last email were wrong.
> 
> In mentally did 10% instead of 5%. But the premise is same.
> 
> So assuming 5% of some memory is 400 MB, it rounds it down to 256MB etc.

But 0x1fffffff is 512MB, not 256MB. So you're rounding it down to a
multiple of 512MB.


-Olof
