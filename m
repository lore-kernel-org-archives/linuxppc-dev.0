Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 16:59:03 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 11/11] Add /proc interface to control topology updates
Message-ID: <20130410065902.GA24786@concordia>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509F31.8010300@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509F31.8010300@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 02:02:09PM -0500, Nathan Fontenot wrote:
> There are instances in which we do not want topology updates to occur.
> In order to allow this a /proc interface (/proc/powerpc/topology_updates)
> is introduced so that topology updates can be enabled and disabled.
> 
> This patch also adds a prrn_is_enabled() call so that PRRN events are
> handled in the kernel only if topology updating is enabled.

Hi Nathan,
 
> Index: powerpc/arch/powerpc/mm/numa.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-20 12:27:48.000000000 -0500
> +++ powerpc/arch/powerpc/mm/numa.c	2013-03-20 12:27:52.000000000 -0500
> @@ -1577,4 +1579,62 @@
>  
>  	return rc;
>  }
> +
> +inline int prrn_is_enabled(void)
> +{
> +	return prrn_enabled;
> +}

...

> Index: powerpc/arch/powerpc/include/asm/topology.h
> ===================================================================
> --- powerpc.orig/arch/powerpc/include/asm/topology.h	2013-03-20 12:25:37.000000000 -0500
> +++ powerpc/arch/powerpc/include/asm/topology.h	2013-03-20 12:27:52.000000000 -0500
> @@ -71,6 +71,7 @@
>  #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
>  extern int start_topology_update(void);
>  extern int stop_topology_update(void);
> +extern inline int prrn_is_enabled(void);

This doesn't compile for me, with:

arch/powerpc/kernel/rtasd.c: In function 'rtas_event_scan':
arch/powerpc/include/asm/topology.h:74:19: sorry, unimplemented: inlining failed in call to 'prrn_is_enabled': function body not available
arch/powerpc/kernel/rtasd.c:299:22: sorry, unimplemented: called from here


cheers
