Return-Path: <srs0=3rgh=hl=gmail.com=nicholas.piggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40TCSc1SzfzF21F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 11:59:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40TCSc0jWrz8tGJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 11:59:12 +1000 (AEST)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40TCSb3qP1z9s15
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2018 11:59:11 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id m21so2927391pgv.8
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2018 18:59:11 -0700 (PDT)
Date: Sun, 22 Apr 2018 11:58:58 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Ananth Narayan
 <ananth@in.ibm.com>, kernelfans@gmail.com, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Hari Bathini
 <hbathini@linux.vnet.ibm.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/7] powerpc/fadump: un-register fadump on kexec path.
Message-ID: <20180422115858.776bac02@roar.ozlabs.ibm.com>
In-Reply-To: <152420067500.31037.2795727017934578072.stgit@jupiter.in.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
 <152420067500.31037.2795727017934578072.stgit@jupiter.in.ibm.com>
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

On Fri, 20 Apr 2018 10:34:35 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> otherwise the fadump registration in new kexec-ed kernel complains that
> fadump is already registered. This makes new kernel to continue using
> fadump registered by previous kernel which may lead to invalid vmcore
> generation. Hence this patch fixes this issue by un-registering fadump
> in fadump_cleanup() which is called during kexec path so that new kernel
> can register fadump with new valid values.

Is this a bug fix that should go to previous kernels as well?

> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 43bfa535d0ea..16b3e8c5cae0 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1276,6 +1276,9 @@ void fadump_cleanup(void)
>  	/* Invalidate the registration only if dump is active. */
>  	if (fw_dump.dump_active) {
>  		fadump_invalidate_dump(fdm_active);
> +	} else if (fw_dump.dump_registered) {
> +		/* Un-register Firmware-assisted dump if it was registered. */
> +		fadump_unregister_dump(&fdm);
>  	}
>  }
>  
> 
