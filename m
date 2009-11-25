Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19212.41731.446119.833036@cargo.ozlabs.ibm.com>
Date: Wed, 25 Nov 2009 14:22:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 3/3] CPU DLPAR  handling
In-Reply-To: <4B0C8E31.9040608@austin.ibm.com>
References: <4B0C8B45.6080804@austin.ibm.com> <4B0C8E31.9040608@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot writes:

> Register the pseries specific handlers for the powerpc architecture handlers
> for the cpu probe and release files.  This also implements the cpu DLPAR
> addition and removal of CPUS from the system.

...

> +	/* configure-connector reports cpus as living in the base
> +	 * directory of the device tree.  CPUs actually live in the
> +	 * cpus directory so we need to fixup the full_name.
> +	 */
> +	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
> +			   GFP_KERNEL);
> +	if (!cpu_name) {
> +		dlpar_free_cc_nodes(dn);
> +		return -ENOMEM;
> +	}
> +
> +	sprintf(cpu_name, "/cpus/%s", dn->full_name);

I would have expected dn->full_name to start with a '/' already, in
which case this will end up with two consecutive slashes after
'cpus'.  I think that will probably cause problems.

Paul.
