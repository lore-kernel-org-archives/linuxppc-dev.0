Return-Path: <shd@zakalwe.fi>
Date: Thu, 16 Nov 2006 16:02:31 +0200
From: Heikki Orsila <shd@zakalwe.fi>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: [RFC,
	Patch 1/1] OProfile for Cell: Initial profiling support -- new patch
Message-ID: <20061116140231.GA12227@zakalwe.fi>
References: <455B619C.7040904@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <455B619C.7040904@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 12:51:08PM -0600, Maynard Johnson wrote:
> +/* This function is called once for all cpus combined */
> +static void
> +cell_reg_setup(struct op_counter_config *ctr,
> +	       struct op_system_config *sys, int num_ctrs)
> +{
> [SNIP]
> +	for (i = 0; i < num_ctrs; ++i) {
> +
> +		if ((ctr[i].event >= 2100) && (ctr[i].event <= 2111))
> +			pmc_cntrl[1][i].evnts = ctr[i].event + 19;
> +		else if (ctr[i].event == 2203)
> +			pmc_cntrl[1][i].evnts = ctr[i].event;
> +		else if ((ctr[i].event >= 2200) && (ctr[i].event <= 2215))
> +			pmc_cntrl[1][i].evnts = ctr[i].event + 16;
> +		else
> +			pmc_cntrl[1][i].evnts = ctr[i].event;
> +

I think the previous code would be more readable with a switch() 
statement. 

	switch (ctr[i].event) {
	case 2100 ... 2111:
		pmc_cntrl[1][i] = ctr[i].event + 19;
		break;
	case 2200 ... 2202:
	case 2204 ... 2215:
		pmc_cntrl[1][i] = ctr[i].event + 16;
		break;
	default:
		pmc_cntrl[1][i] = ctr[i].event;
	}

 - Heikki
