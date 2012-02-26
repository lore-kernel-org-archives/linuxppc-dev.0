Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31338B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 10:22:38 +1100 (EST)
Message-ID: <1330298534.20389.53.camel@pasglop>
Subject: Re: [PATCH] powerpc/prom: bump up maximum size of properties
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Mon, 27 Feb 2012 10:22:14 +1100
In-Reply-To: <1330129422-2648-1-git-send-email-nacc@us.ibm.com>
References: <1330129422-2648-1-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Robert Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-24 at 16:23 -0800, Nishanth Aravamudan wrote:
> On a 16TB system (using AMS/CMO), I get:
> 
> WARNING: ignoring large property [/ibm,dynamic-reconfiguration-memory] ibm,dynamic-memory length 0x000000000017ffec
> 
> and significantly less memory is thus shown to the partition. As far as
> I can tell, the constant used is arbitrary, but bump it up to 2MB, which
> covers the above property (approximately 1.5MB).
> 
> With this patch, the kernel does see all of the system memory on the
> 16TB system.

Why not go all the way to either removing the limit, or setting it to
something much bigger ? That's just asking to break again when we get an
even bigger system.

The limit was originally set because of Apple machines carrying ROM
images in the device-tree, at a time where we were much more memory
constrained than we are now.

But even then, it never represented such a large gain and in the end,
was probably not -that- useful.

I'd say bump it to something really large like 16M or remove the limit
alltogether.

Cheers,
Ben.

> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Cc: Anton Blanchard <anton@au1.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/prom_init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index eca626e..0bf0ccc 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -53,7 +53,7 @@
>   * ensure that we don't lose things like the interrupt-map property
>   * on a PCI-PCI bridge.
>   */
> -#define MAX_PROPERTY_LENGTH	(1UL * 1024 * 1024)
> +#define MAX_PROPERTY_LENGTH	(2UL * 1024 * 1024)
>  
>  /*
>   * Eventually bump that one up
