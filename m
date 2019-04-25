Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77400C43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 17:06:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C2120684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Lt7Nhwg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C2120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qk972dB7zDqcQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 03:06:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Lt7Nhwg7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qk703w4jzDqZ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 03:04:07 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qk6n3t2gz9v18Z;
 Thu, 25 Apr 2019 19:04:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Lt7Nhwg7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id emNOBApvscWJ; Thu, 25 Apr 2019 19:04:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qk6n2r4Fz9v18X;
 Thu, 25 Apr 2019 19:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556211841; bh=tBB6gaRp4u0cegNF1f/y0894RHx/stiSzyY2C2u9AUU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Lt7Nhwg7nU3ZzEIoYNLU6tL+lxy5KUmxaPKi8ivtB5QwUAy7WNB86ke8jUnnM+bNz
 mSBA/dPJBp+aGp2JyANRtwV0Uma23XwI/fRKWw7c2D5ubM5aas03IpdNl5cl00zeCM
 I+aTmJCA3Dh+X5PZ8pxBOKQ5nOt/IHG2ulwmJHTQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F6478B939;
 Thu, 25 Apr 2019 19:04:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Zvv4njkYDmJq; Thu, 25 Apr 2019 19:04:03 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B09AA8B923;
 Thu, 25 Apr 2019 19:04:02 +0200 (CEST)
Subject: Re: [PATCH v2 3/4] powerpc/boot: Add bzip2 support for uImage
To: Adam Borowski <kilobyte@angband.pl>
References: <2d3a59015307d368d6ac1a62fe7e47f5b39e2fe2.1556028978.git.christophe.leroy@c-s.fr>
 <ce215ac5f428b7fd01bf73a543f3db087e5a537e.1556028978.git.christophe.leroy@c-s.fr>
 <20190425143706.GA28476@angband.pl>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1a5bf1cf-f278-3667-6d33-c89efb4e2865@c-s.fr>
Date: Thu, 25 Apr 2019 17:03:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190425143706.GA28476@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 04/25/2019 02:37 PM, Adam Borowski wrote:
> On Tue, Apr 23, 2019 at 02:20:43PM +0000, Christophe Leroy wrote:
>> This patch allows to generate bzip2 compressed uImage
> 
> Please don't add bzip2 support, that's a waste of your time as we're trying
> to remove it kernel-wide.  There's a patchset to retire compressors beaten
> by alternatives on the whole speed-to-size curve; reposting it is overdue.
> 
> It does:
> * add ZSTD (fast and strong)
> * remove BZIP2 (obsolete, only user in kernel)
> * remove LZMA (redundant with XZ, uses a private copy of its library)
> * makes Kconfig prose talk badly about LZO (used elsewhere in the kernel)
> 
> I believe only three compressors are worth using here: XZ, ZSTD, LZ4.
> GZIP must stay because of ubiquitous support, the rest should go.

Ok. Initially the purpose was to add lzma, then I took the opportunity 
to add all compressors supported by u-boot uImage files which are 'none, 
bzip2, gzip, lzma, lzo':

[root@po16846vm linux-powerpc]# mkimage -C -h

Invalid Compression Type - valid names are: none, bzip2, gzip, lzma, lzo
Usage: mkimage -l image
           -l ==> list image header information
        mkimage [-x] -A arch -O os -T type -C comp -a addr -e ep -n name 
-d data_file[:data_file...] image


So I can leave bzip2 aside.

xz, zstd and lz4 are not supported by the uImage format as far as I know 
so we have to keep lzma which gives a far better compression ratio than 
gzip (gzipped uImage don't fit in my board's NOR Flash while lzmaed 
uImage does).

Christophe


> 
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -199,6 +199,7 @@ config PPC
>> +	select HAVE_KERNEL_BZIP2		if DEFAULT_UIMAGE
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -23,6 +23,7 @@ all: $(obj)/zImage
>> +compress-$(CONFIG_KERNEL_BZIP2)   := CONFIG_KERNEL_BZIP2
>> @@ -259,6 +260,7 @@ endif
>> +compressor-$(CONFIG_KERNEL_BZIP2) := bz2
>> --- a/arch/powerpc/boot/wrapper
>> +++ b/arch/powerpc/boot/wrapper
>> @@ -137,7 +137,7 @@ while [ "$#" -gt 0 ]; do
>> -        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "none" ] || usage
>> +        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "bz2" -o "$1" != "none" ] || usage
>> @@ -149,6 +149,9 @@ while [ "$#" -gt 0 ]; do
>> +	if [ $uboot_comp = "bz2" ]; then
>> +		uboot_comp=bzip2
>> +	fi
>> @@ -377,6 +380,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
>> +    .bz2)
>> +        bzip2 -f "$vmz.$$"
>> +	;;
> 
> 
> Meow!
> 
