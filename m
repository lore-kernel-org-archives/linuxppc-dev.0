Return-Path: <srs0=rtz9=hp=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WxvP3gQ0zF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 22:58:25 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40WxvP1sS7z8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 22:58:25 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40WxvN22KHz9s06
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 22:58:23 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id o76so13589206pfi.5
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 05:58:23 -0700 (PDT)
Date: Thu, 26 Apr 2018 22:58:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Hari
 Bathini <hbathini@linux.vnet.ibm.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/fadump: un-register fadump on kexec path.
Message-ID: <20180426225757.2a8552e0@roar.ozlabs.ibm.com>
In-Reply-To: <152474292369.5697.4957552670306451723.stgit@jupiter.in.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
 <152474292369.5697.4957552670306451723.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Apr 2018 17:12:03 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> otherwise the fadump registration in new kexec-ed kernel complains that
> fadump is already registered. This makes new kernel to continue using
> fadump registered by previous kernel which may lead to invalid vmcore
> generation. Hence this patch fixes this issue by un-registering fadump
> in fadump_cleanup() which is called during kexec path so that new kernel
> can register fadump with new valid values.

I assume this series is for 4.17, but it might be good to get this one
into the 4.16 fixes branch? Should it go to stable kernels?

> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8ceabef40d3d..07e8396d472b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1180,6 +1180,9 @@ void fadump_cleanup(void)
>  		init_fadump_mem_struct(&fdm,
>  			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
>  		fadump_invalidate_dump(&fdm);
> +	} else if (fw_dump.dump_registered) {
> +		/* Un-register Firmware-assisted dump if it was registered. */
> +		fadump_unregister_dump(&fdm);
>  	}
>  }
>  
> 
