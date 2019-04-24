Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BDC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 08:53:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAF9218DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF9218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pvHP3CKNzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.com
 (client-ip=195.135.221.5; helo=smtp.nue.novell.com;
 envelope-from=mbrugger@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
X-Greylist: delayed 1210 seconds by postgrey-1.36 at bilbo;
 Wed, 24 Apr 2019 18:52:05 AEST
Received: from smtp.nue.novell.com (smtp.nue.novell.com [195.135.221.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pvFd3Dk9zDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 18:52:05 +1000 (AEST)
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
 by smtp.nue.novell.com with ESMTP (TLS encrypted);
 Wed, 24 Apr 2019 10:31:49 +0200
Received: from ziggy.stardust (nwb-a10-snat.microfocus.com [10.120.13.201])
 by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted);
 Wed, 24 Apr 2019 09:31:39 +0100
Subject: Re: [PATCHv2] kernel/crash: make parse_crashkernel()'s return value
 more indicant
To: Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
References: <1556087581-14513-1-git-send-email-kernelfans@gmail.com>
From: Matthias Brugger <mbrugger@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <10dc5468-6cd9-85c7-ba66-1dfa5aa922b7@suse.com>
Date: Wed, 24 Apr 2019 10:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556087581-14513-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Julien Thierry <julien.thierry@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Stefan Agner <stefan@agner.ch>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
 James Hogan <jhogan@kernel.org>, Dave Young <dyoung@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Borislav Petkov <bp@alien8.de>,
 David Hildenbrand <david@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Paul Burton <paul.burton@mips.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 24/04/2019 08:33, Pingfan Liu wrote:
> At present, both return and crash_size should be checked to guarantee the
> success of parse_crashkernel().
> 
> Take a close look at the cases, which causes crash_size=0. Beside syntax
> error, three cases cause parsing to get crash_size=0.
> -1st. in parse_crashkernel_mem(), the demanded crash size is bigger than
>  system ram.
> -2nd. in parse_crashkernel_mem(), the system ram size does not match any
>  item in the range list.
> -3rd. "crashkernel=0MB", which is impractical.
> 
> All these cases can be treated as invalid argument.
> 
> By this way, only need a simple check on return value of
> parse_crashkernel().
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
> v1 -> v2: On error, return -EINVAL for all failure cases
> 
>  arch/arm/kernel/setup.c             |  2 +-
>  arch/arm64/mm/init.c                |  2 +-
>  arch/ia64/kernel/setup.c            |  2 +-
>  arch/mips/kernel/setup.c            |  2 +-
>  arch/powerpc/kernel/fadump.c        |  2 +-
>  arch/powerpc/kernel/machine_kexec.c |  2 +-
>  arch/s390/kernel/setup.c            |  2 +-
>  arch/sh/kernel/machine_kexec.c      |  2 +-
>  arch/x86/kernel/setup.c             |  4 ++--
>  kernel/crash_core.c                 | 10 +++++++++-
>  10 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 5d78b6a..2feab13 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -997,7 +997,7 @@ static void __init reserve_crashkernel(void)
>  	total_mem = get_total_mem();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
>  				&crash_size, &crash_base);
> -	if (ret)
> +	if (ret < 0)
>  		return;
>  
>  	if (crash_base <= 0) {
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6bc1350..240918c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -79,7 +79,7 @@ static void __init reserve_crashkernel(void)
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
>  	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> +	if (ret < 0)
>  		return;
>  
>  	crash_size = PAGE_ALIGN(crash_size);
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 583a374..3bbb58b 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
>  
>  	ret = parse_crashkernel(boot_command_line, total,
>  			&size, &base);
> -	if (ret == 0 && size > 0) {
> +	if (!ret) {
>  		if (!base) {
>  			sort_regions(rsvd_region, *n);
>  			*n = merge_regions(rsvd_region, *n);
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 8d1dc6c..168571b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -715,7 +715,7 @@ static void __init mips_parse_crashkernel(void)
>  	total_mem = get_total_mem();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
>  				&crash_size, &crash_base);
> -	if (ret != 0 || crash_size <= 0)
> +	if (ret < 0)
>  		return;
>  
>  	if (!memory_region_available(crash_base, crash_size)) {
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 45a8d0b..3571504 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  	 */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&size, &base);
> -	if (ret == 0 && size > 0) {
> +	if (!ret) {
>  		unsigned long max_size;
>  
>  		if (fw_dump.reserve_bootvar)
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 63f5a93..1697ad2 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
>  	/* use common parsing */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  			&crash_size, &crash_base);
> -	if (ret == 0 && crash_size > 0) {
> +	if (!ret) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
>  	}
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 2c642af..d4bd61b 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -671,7 +671,7 @@ static void __init reserve_crashkernel(void)
>  
>  	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
>  	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
> -	if (rc || crash_size == 0)
> +	if (rc < 0)
>  		return;
>  
>  	if (memblock.memory.regions[0].size < crash_size) {
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
> index 63d63a3..3c03240 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  			&crash_size, &crash_base);
> -	if (ret == 0 && crash_size > 0) {
> +	if (!ret) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
>  	}
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..592d5ad 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
>  
>  	/* crashkernel=XM */
>  	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> -	if (ret != 0 || crash_size <= 0) {
> +	if (ret < 0) {
>  		/* crashkernel=X,high */
>  		ret = parse_crashkernel_high(boot_command_line, total_mem,
>  					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		if (ret < 0)
>  			return;
>  		high = true;
>  	}
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 093c9f9..83ee4a9 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -108,8 +108,10 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  				return -EINVAL;
>  			}
>  		}
> -	} else
> +	} else {
>  		pr_info("crashkernel size resulted in zero bytes\n");
> +		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> @@ -139,6 +141,8 @@ static int __init parse_crashkernel_simple(char *cmdline,
>  		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
>  		return -EINVAL;
>  	}
> +	if (*crash_size == 0)
> +		return -EINVAL;

This covers the case where I pass an argument like "crashkernel=0M" ?
Can't we fix that by using kstrtoull() in memparse and check if the return value
is < 0? In that case we could return without updating the retptr and we will be
fine.

>  
>  	return 0;
>  }
> @@ -181,6 +185,8 @@ static int __init parse_crashkernel_suffix(char *cmdline,
>  		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
>  		return -EINVAL;
>  	}
> +	if (*crash_size == 0)
> +		return -EINVAL;

Same here.

>  
>  	return 0;
>  }
> @@ -266,6 +272,8 @@ static int __init __parse_crashkernel(char *cmdline,
>  /*
>   * That function is the entry point for command line parsing and should be
>   * called from the arch-specific code.
> + * On success 0. On error for either syntax error or crash_size=0, -EINVAL is
> + * returned.
>   */
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
> 
