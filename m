Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 18:30:12 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/11] Add PRRN Event Handler
Message-ID: <20130410083012.GD24786@concordia>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CF0.10200@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509CF0.10200@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:52:32PM -0500, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> A PRRN event is signaled via the RTAS event-scan mechanism, which
> returns a Hot Plug Event message "fixed part" indicating "Platform
> Resource Reassignment". In response to the Hot Plug Event message,
> we must call ibm,update-nodes to determine which resources were
> reassigned and then ibm,update-properties to obtain the new affinity
> information about those resources.
..

> Index: powerpc/arch/powerpc/kernel/rtasd.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-03-20 08:24:14.000000000 -0500
> +++ powerpc/arch/powerpc/kernel/rtasd.c	2013-03-20 08:52:08.000000000 -0500
> @@ -87,6 +87,8 @@
>  			return "Resource Deallocation Event";
>  		case RTAS_TYPE_DUMP:
>  			return "Dump Notification Event";
> +		case RTAS_TYPE_PRRN:
> +			return "Platform Resource Reassignment Event";
>  	}
>  
>  	return rtas_type[0];
> @@ -265,7 +267,38 @@
>  		spin_unlock_irqrestore(&rtasd_log_lock, s);
>  		return;
>  	}
> +}
> +
> +static s32 update_scope;
> +
> +static void prrn_work_fn(struct work_struct *work)
> +{
> +	/*
> +	 * For PRRN, we must pass the negative of the scope value in
> +	 * the RTAS event.
> +	 */
> +	pseries_devicetree_update(-update_scope);
> +}
> +static DECLARE_WORK(prrn_work, prrn_work_fn);

This breaks the 32-bit build (ppc6xx_defconfig):

arch/powerpc/kernel/rtasd.c:280: undefined reference to `pseries_devicetree_update'

cheers
