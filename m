Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 19:59:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
Message-ID: <20130314085905.GE9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB457.9000409@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
> This patch adds a platform_has_feature() function to check features selected
> by firmware and reported via the device tree 'ibm,architecture-vec5'
> property. As part of this the #defines used for the architecture vector are
> moved to prom.h and re-defined such that the vector 5 options have the vector
> index and the feature bits encoded into them. This allows for callers of
> platform_has_feature() to pass in a single pre-defined value.

One other comment...

> +#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> +bool platform_has_feature(unsigned int feature)
> +{
> +	struct device_node *chosen;
> +	const char *vec5;
> +	bool has_option;
> +
> +	chosen = of_find_node_by_path("/chosen");
> +	if (!chosen)
> +		return false;
> +
> +	vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
> +	has_option = vec5 && (vec5[OV5_INDX(feature)] & OV5_FEAT(feature));

You access vec5[index] without checking that the vector is at least
index+1 bytes long, according to either the length byte at the
beginning of the vector, or the total length of the property.
Checking both would be a good idea.

Paul.
