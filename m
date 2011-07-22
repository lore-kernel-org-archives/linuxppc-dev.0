Return-Path: <Hollis_Blanchard@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C01CB6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 05:39:59 +1000 (EST)
Message-ID: <4E29CB58.10103@mentor.com>
Date: Fri, 22 Jul 2011 12:11:20 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [openmcapi-dev] [PATCH] powerpc: Exporting boot_cpuid_phys
References: <4E219085.8000709@mentor.com>
In-Reply-To: <4E219085.8000709@mentor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: openmcapi-dev@googlegroups.com,
	Andrew Gabbasov <andrew_gabbasov@mentor.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2011 06:22 AM, Andrew Gabbasov wrote:
> Kernel loadable module can use hard_smp_processor_id() if building with SMP
> kernel. In order to make it work for UP kernels too, boot_cpuid_phys
> symbol (which is what hard_smp_processor_id() macro resolves to
> in non-SMP configuration) must be exported.
>
> Signed-off-by: Andrew Gabbasov<andrew_gabbasov@mentor.com>
> ---
>   arch/powerpc/kernel/setup_32.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 1d2fbc9..3dffce6 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -49,6 +49,7 @@ extern void bootx_init(unsigned long r4, unsigned long phys);
>   int boot_cpuid = -1;
>   EXPORT_SYMBOL_GPL(boot_cpuid);
>   int boot_cpuid_phys;
> +EXPORT_SYMBOL_GPL(boot_cpuid_phys);
>
>   int smp_hw_index[NR_CPUS];

Ben, ping?

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
