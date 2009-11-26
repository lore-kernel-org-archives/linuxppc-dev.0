Return-Path: <anton@ozlabs.org>
Date: Thu, 26 Nov 2009 16:10:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: [PATCH v5 2/4] pSeries: Add hooks to put the CPU into an
	appropriate offline state
Message-ID: <20091126051036.GA12086@kryten>
References: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
	<20091030052253.25493.65063.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091030052253.25493.65063.stgit@sofia.in.ibm.com>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Gautham,

> +	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
> +				NULL,
> +				CEDE_LATENCY_TOKEN,
> +				__pa(cede_parameters),
> +				CEDE_LATENCY_PARAM_MAX_LENGTH);
> +
> +	if (call_status != 0)
> +		printk(KERN_INFO "CEDE_LATENCY: \
> +			%s %s Error calling get-system-parameter(0x%x)\n",
> +			__FILE__, __func__, call_status);
> +	else
> +		printk(KERN_INFO "CEDE_LATENCY: \
> +			get-system-parameter successful.\n");

I'm seeing this on a POWER6 box:


CEDE_LATENCY: 			arch/powerpc/platforms/pseries/hotplug-cpu.c parse_cede_parameters Error calling get-system-parameter(0xfffffffd)


Seems overly verbose. Do we need to print success/fail on this call? Perhaps
a summary line if anything during initialisation failed:

Cede latency not supported

and

Cede latency supported

If it all worked.

Anton
