Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E318AB7127
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 06:14:20 +1100 (EST)
Date: Tue, 1 Feb 2011 13:13:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 5/6] powerpc/44x: boot wrapper: allow kernel to load
	into non-zero address
Message-ID: <20110201131357.59fc4445@udp111988uds.am.freescale.net>
In-Reply-To: <1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-6-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 1 Feb 2011 12:48:45 -0600
Dave Kleikamp <shaggy@linux.vnet.ibm.com> wrote:

> For AMP, different kernel instances load into separate memory regions.
> Read the start of memory from the device tree and limit the memory to what's
> specified in the device tree.
> 
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/boot/treeboot-iss4xx.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
> index fcc4495..868c8b4 100644
> --- a/arch/powerpc/boot/treeboot-iss4xx.c
> +++ b/arch/powerpc/boot/treeboot-iss4xx.c
> @@ -34,9 +34,28 @@
>  
>  BSS_STACK(4096);
>  
> +static ibm4xx_memstart;

type?

> +static void *iss_4xx_vmlinux_alloc(unsigned long size)
> +{
> +	return ibm4xx_memstart;
>  }

Doesn't this generate a warning for implicitly casting int to void *?

-Scott
