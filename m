Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.30231.361341.295825@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 15:54:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/16 v3] powerpc: Split retrieval of processor entitlement
	data into a helper routine
In-Reply-To: <20080704125207.GE1310@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125207.GE1310@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> Split the retrieval of processor entitlement data returned in the H_GET_PPP
> hcall into its own helper routine.

This seems to change the value reported for pool_capacity radically:

>  		/* report pool_capacity in percentage */
> -		seq_printf(m, "pool_capacity=%ld\n",
> -			   ((h_resource >> 2 * 8) & 0xffff) * 100);
> +		seq_printf(m, "pool_capacity=%d\n", ppp_data.group_num * 100);

On a Power6 partition here with your patch series applied, I see

pool_capacity=3277200

in /proc/ppc64/lparcfg.  Without your patches, I get

pool_capacity=400
pool_idle_time=0
pool_num_procs=0

This looks like an incompatible user-visible change to me, and we
haven't even changed the lparcfg version number at the beginning of
the /proc/ppc64/lparcfg output.  Why is the pool_capacity so
different, and why do the pool_idle_time and pool_num_procs lines
disappear?

Regards,
Paul.
