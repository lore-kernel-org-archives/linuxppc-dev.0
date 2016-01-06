Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7B0B1A15DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 01:23:20 +1100 (AEDT)
Date: Wed, 6 Jan 2016 15:23:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 9/9] Enable LIVEPATCH to be configured on ppc64le and
 add livepatch.o if it is selected.
Message-ID: <20160106142315.GM3178@pathway.suse.cz>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20151204152858.2EE5C691D2@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204152858.2EE5C691D2@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2015-12-04 15:13:44, Torsten Duwe wrote:
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  arch/powerpc/Kconfig         | 5 +++++
>  arch/powerpc/kernel/Makefile | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 89b1a2a..62a3f54 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -163,6 +163,9 @@ config PPC
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK
>  	select HAVE_ARCH_SECCOMP_FILTER
>  
> +config HAVE_LIVEPATCH
> +       def_bool PPC64 && CPU_LITTLE_ENDIAN
> +

Just a small nitpicking. HAVE_LIVEPATCH is defined in
kernel/livepatch/Kconfig. I would move this to the
config PPC section and use:

	select HAVE_LIVEPATCH if PPC64 && CPU_LITTLE_ENDIAN


Or did I miss something, please?

Best Regards,
Petr
