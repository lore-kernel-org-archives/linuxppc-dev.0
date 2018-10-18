Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F59C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2E32145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bNpS3YmkzF3Rc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 20:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bNmG5N5FzF3G1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:19:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bNmB2b5Qz9ttC1;
 Thu, 18 Oct 2018 11:19:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sOxzyRvrlBZn; Thu, 18 Oct 2018 11:19:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bNmB1yFcz9ttBy;
 Thu, 18 Oct 2018 11:19:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 25CA28B8B0;
 Thu, 18 Oct 2018 11:19:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9V9ufNzhy7Bx; Thu, 18 Oct 2018 11:19:38 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FD518B8AB;
 Thu, 18 Oct 2018 11:19:37 +0200 (CEST)
Subject: Re: [PATCH] powerpc/uaccess: fix warning/error with access_ok()
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <40873f45f922b28c727c013e3883be467fc31c56.1539852411.git.christophe.leroy@c-s.fr>
Message-ID: <4d7c00d5-f42f-1eff-c5c5-34903f342d40@c-s.fr>
Date: Thu, 18 Oct 2018 11:19:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <40873f45f922b28c727c013e3883be467fc31c56.1539852411.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/10/2018 à 10:48, Christophe Leroy a écrit :
> With the following peace of code, the following compilation warning
> is encountered:
> 
> 	if (_IOC_DIR(ioc) != _IOC_NONE) {
> 		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;
> 
> 		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {
> 
> drivers/platform/test/dev.c: In function ‘my_ioctl’:
> drivers/platform/test/dev.c:219:7: warning: unused variable ‘verify’ [-Wunused-variable]
>     int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;
> 
> This patch fixes it by handing the type to __access_ok(), changing it
> to an inline function for PPC64 as already done for PPC32

Oops, not that easy, there are places using __access_ok() directly, 
those need to be modified as well.

Christophe

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/uaccess.h | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 15bea9a0f260..97faf0353919 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -47,13 +47,16 @@ static inline void set_fs(mm_segment_t fs)
>    * This check is sufficient because there is a large enough
>    * gap between user addresses and the kernel addresses
>    */
> -#define __access_ok(addr, size, segment)	\
> -	(((addr) <= (segment).seg) && ((size) <= (segment).seg))
> +static inline int __access_ok(int type, unsigned long addr, unsigned long size,
> +			      mm_segment_t seg)
> +{
> +	return addr <= seg.seg && size <= seg.seg;
> +}
>   
>   #else
>   
> -static inline int __access_ok(unsigned long addr, unsigned long size,
> -			mm_segment_t seg)
> +static inline int __access_ok(int type, unsigned long addr, unsigned long size,
> +			      mm_segment_t seg)
>   {
>   	if (addr > seg.seg)
>   		return 0;
> @@ -64,7 +67,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
>   
>   #define access_ok(type, addr, size)		\
>   	(__chk_user_ptr(addr),			\
> -	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
> +	 __access_ok((type), (__force unsigned long)(addr), (size), get_fs()))
>   
>   /*
>    * These are the main single-value transfer routines.  They automatically
> 
