Return-Path: <SRS0=CCeT=4R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155BC3F2D6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 08:47:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F729246AE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 08:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F729246AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48V0QQ4184zDrGw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 19:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.50.32; helo=7.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 1024 seconds by postgrey-1.36 at bilbo;
 Sat, 29 Feb 2020 19:45:26 AEDT
Received: from 7.mo69.mail-out.ovh.net (7.mo69.mail-out.ovh.net [46.105.50.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48V0NQ0lLKzDrB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Feb 2020 19:45:25 +1100 (AEDT)
Received: from player779.ha.ovh.net (unknown [10.108.54.217])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 482D487260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Feb 2020 09:28:11 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 3E2A7FDEB05F;
 Sat, 29 Feb 2020 08:27:58 +0000 (UTC)
Subject: Re: [RFC PATCH v1] powerpc/prom_init: disable XIVE in Secure VM.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
References: <1582962844-26333-1-git-send-email-linuxram@us.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1e28fb80-7bae-8d80-1a72-f616af030aab@kaod.org>
Date: Sat, 29 Feb 2020 09:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582962844-26333-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2349471632869592038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleelgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
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
Cc: aik@ozlabs.ru, andmike@linux.ibm.com, groug@kaod.org, clg@fr.ibm.com,
 sukadev@linux.vnet.ibm.com, bauerman@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/29/20 8:54 AM, Ram Pai wrote:
> XIVE is not correctly enabled for Secure VM in the KVM Hypervisor yet.
> 
> Hence Secure VM, must always default to XICS interrupt controller.

have you tried XIVE emulation 'kernel-irqchip=off' ? 

> If XIVE is requested through kernel command line option "xive=on",
> override and turn it off.

This is incorrect. It is negotiated through CAS depending on the FW
capabilities and the KVM capabilities.

> If XIVE is the only supported platform interrupt controller; specified
> through qemu option "ic-mode=xive", simply abort. Otherwise default to
> XICS.


I don't think it is a good approach to downgrade the guest kernel 
capabilities this way. 

PAPR has specified the CAS negotiation process for this purpose. It 
comes in two parts under KVM. First the KVM hypervisor advertises or 
not a capability to QEMU. The second is the CAS negotiation process 
between QEMU and the guest OS.

The SVM specifications might not be complete yet and if some features 
are incompatible, I think we should modify the capabilities advertised 
by the hypervisor : no XIVE in case of SVM. QEMU will automatically 
use the fallback path and emulate the XIVE device, same as setting 
'kernel-irqchip=off'. 

This is how KVM operates on Boston systems today which do not have 
the right level of FW to support migration. XIVE is emulated. 

It will give SVM a working default without any changes in QEMU or the
guest. Now, if one needs more performance, accelerated xics should be
activated on the command line with 'xive=off'.


I understand that SVM requires FW support. Do we have a SVM capability  
returned to QEMU ? That might have been addressed in other patches.

Thanks,

C.

> 
> Cc: kvm-ppc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Michael Anderson <andmike@linux.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Cedric Le Goater <clg@fr.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 43 ++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5773453..dd96c82 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -805,6 +805,18 @@ static void __init early_cmdline_parse(void)
>  #endif
>  	}
>  
> +#ifdef CONFIG_PPC_SVM
> +	opt = prom_strstr(prom_cmd_line, "svm=");
> +	if (opt) {
> +		bool val;
> +
> +		opt += sizeof("svm=") - 1;
> +		if (!prom_strtobool(opt, &val))
> +			prom_svm_enable = val;
> +		prom_printf("svm =%d\n", prom_svm_enable);
> +	}
> +#endif /* CONFIG_PPC_SVM */
> +
>  #ifdef CONFIG_PPC_PSERIES
>  	prom_radix_disable = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
>  	opt = prom_strstr(prom_cmd_line, "disable_radix");
> @@ -823,23 +835,22 @@ static void __init early_cmdline_parse(void)
>  	if (prom_radix_disable)
>  		prom_debug("Radix disabled from cmdline\n");
>  
> -	opt = prom_strstr(prom_cmd_line, "xive=off");
> -	if (opt) {
> +#ifdef CONFIG_PPC_SVM
> +	if (prom_svm_enable) {
>  		prom_xive_disable = true;
> -		prom_debug("XIVE disabled from cmdline\n");
> +		prom_debug("XIVE disabled in Secure VM\n");
>  	}
> -#endif /* CONFIG_PPC_PSERIES */
> -
> -#ifdef CONFIG_PPC_SVM
> -	opt = prom_strstr(prom_cmd_line, "svm=");
> -	if (opt) {
> -		bool val;
> +#endif /* CONFIG_PPC_SVM */
>  
> -		opt += sizeof("svm=") - 1;
> -		if (!prom_strtobool(opt, &val))
> -			prom_svm_enable = val;
> +	if (!prom_xive_disable) {
> +		opt = prom_strstr(prom_cmd_line, "xive=off");
> +		if (opt) {
> +			prom_xive_disable = true;
> +			prom_debug("XIVE disabled from cmdline\n");
> +		}
>  	}
> -#endif /* CONFIG_PPC_SVM */
> +
> +#endif /* CONFIG_PPC_PSERIES */
>  }
>  
>  #ifdef CONFIG_PPC_PSERIES
> @@ -1251,6 +1262,12 @@ static void __init prom_parse_xive_model(u8 val,
>  		break;
>  	case OV5_FEAT(OV5_XIVE_EXPLOIT): /* Only Exploitation mode */
>  		prom_debug("XIVE - exploitation mode supported\n");
> +
> +#ifdef CONFIG_PPC_SVM
> +		if (prom_svm_enable)
> +			prom_panic("WARNING: xive unsupported in Secure VM\n");
> +#endif /* CONFIG_PPC_SVM */
> +
>  		if (prom_xive_disable) {
>  			/*
>  			 * If we __have__ to do XIVE, we're better off ignoring
> 

