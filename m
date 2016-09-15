Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZLlc6fGGzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:43:08 +1000 (AEST)
Date: Thu, 15 Sep 2016 11:43:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-ima-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave
 Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Baoquan He
 <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Stewart Smith
 <stewart@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the
 kexec image checksum.
Message-ID: <20160915114308.19195f71@canb.auug.org.au>
In-Reply-To: <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
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

Hi Thiago,

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2a1f0ce7c59a..dcd1679f3005 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1792,6 +1792,11 @@ config SECCOMP
>  
>  source kernel/Kconfig.hz
>  
> +# x86 needs to relocate the purgatory after the checksum is calculated,
> +# therefore the purgatory cannot be part of the kexec image checksum.
> +config ARCH_MODIFIES_KEXEC_PURGATORY
> +	bool
> +

The above should probably be in arch/Kconfig (with an appropriately
changed comment) since it is used in generic code.
-- 
Cheers,
Stephen Rothwell
