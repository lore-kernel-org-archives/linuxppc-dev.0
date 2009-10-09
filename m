Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Oct 2009 17:35:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device
	tree representation
Message-ID: <20091009063534.GC12948@yookeroo.seuss>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091007043052.16890.15975.stgit@angua>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2009 at 10:30:59PM -0600, Grant Likely wrote:
> Add a common header file for working with the flattened device tree
> data structure and merge the shared data tags used by Microblaze and
> PowerPC
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/include/asm/prom.h |   12 +-----------
>  arch/powerpc/include/asm/prom.h    |   12 +-----------
>  include/linux/of_fdt.h             |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/of_fdt.h
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index 64e8b3a..5f461f0 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -17,20 +17,10 @@
>  #ifndef _ASM_MICROBLAZE_PROM_H
>  #define _ASM_MICROBLAZE_PROM_H
>  #ifdef __KERNEL__
> -
> -/* Definitions used by the flattened device tree */
> -#define OF_DT_HEADER		0xd00dfeed /* marker */
> -#define OF_DT_BEGIN_NODE	0x1 /* Start of node, full name */
> -#define OF_DT_END_NODE		0x2 /* End node */
> -#define OF_DT_PROP		0x3 /* Property: name off, size, content */
> -#define OF_DT_NOP		0x4 /* nop */
> -#define OF_DT_END		0x9
> -
> -#define OF_DT_VERSION		0x10


So, if you're merging all these, I guess the question is do we also
want to merge them with scripts/dtc/libfdt/fdt.h, and by extension
with the upstream libfdt header file which defines the same things.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
