Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.26545.726786.184525@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 14:53:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/16 v3] powerpc: Add collaborative memory manager
In-Reply-To: <20080704125357.GJ1310@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125357.GJ1310@linux.vnet.ibm.com>
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

> From: Brian King <brking@linux.vnet.ibm.com>
> 
> Adds a collaborative memory manager, which acts as a simple balloon driver
> for System p machines that support cooperative memory overcommitment
> (CMO).

> +config CMM
> +	tristate "Collaborative memory management"
> +	depends on PPC_PSERIES

So CMM doesn't depend on LPARCFG, yet h_get_mpp is only defined if
LPARCFG=y, which makes this blow up if CMM=y and LPARCFG=n:

> +static void cmm_get_mpp(void)
> +{
> +	int rc;
> +	struct hvcall_mpp_data mpp_data;
> +	unsigned long active_pages_target;
> +	signed long page_loan_request;
> +
> +	rc = h_get_mpp(&mpp_data);

Similarly, the call to h_get_mpp in vio_cmo_bus_init fails to link if
PPC_PSERIES=y and LPARCFG=n, which is a possible configuration.
Please think about and fix up the config dependencies.

Paul.
