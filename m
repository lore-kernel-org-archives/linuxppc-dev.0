Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B8ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 10:12:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E1620685
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZBPzbmxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E1620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lPJn5qdgzF3F7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:12:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZBPzbmxk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::5; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZBPzbmxk"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lPG274QfzF31W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 21:09:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540980578;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=h3+aUpYeRtVbFj/cTwtiD48wizUVMiMFbLhPDnqLohM=;
 b=ZBPzbmxkr2nOwIKRs554mcL/TLBn7/d8li3IlhmOmX1WrLJOLl9BAZWZ6XtWicWri9
 uMUKbkf/lDNwzD0TudiDUG3b9PdqsokgRjZerWG0BFCMpF14rFSIXjXDeVeD4zvyTFmw
 rbbD6cJn6GTx9XTgYgzHiJ+hyyLunf0gqCscIF+nlCkjYUy6gQXj1SnlF3seXhrAeq76
 KGoixvPsGKwNGl5LbJaK6O+KaxLZ8Nw/WHcLB0HFa114jH/Vn5/q5TFaV0hTviA3I7cS
 Es6Eo2sDRYtAalgK70wKtXtczx/+7yHikNf8qBaLwX+svHMHieYjUfpMIYZaBTsIZwbm
 fKsA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Clbhp9bayqLMHIFV3bP6ZGRVRmKHA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:d842:f065:35df:e394]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9VA9cHts
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 31 Oct 2018 11:09:38 +0100 (CET)
Subject: Re: arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH"
 redefined
To: linuxppc-dev@lists.ozlabs.org,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <009777be-1025-a309-2804-c76cd00d3947@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <a999fed3-ad83-ae96-0639-0640053cad55@xenosoft.de>
Date: Wed, 31 Oct 2018 11:09:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <009777be-1025-a309-2804-c76cd00d3947@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

I compiled the latest Git kernel today. The error 'TRACE_INCLUDE_PATH 
redefined' still exist.

Cheers,
Christian


On 29 October 2018 at 11:22AM, Christian Zigotzky wrote:
> Hello,
>
> The latest Git kernel doesn't compile currently because of the 
> following error:
>
>
> christian@christian-virtual-machine:~/Downloads/a$ env LANG=C make 
> CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc uImage
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CC      arch/powerpc/kvm/powerpc.o
> In file included from arch/powerpc/kvm/powerpc.c:51:0:
> arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined 
> [-Werror]
>  #define TRACE_INCLUDE_PATH .
>  ^
> In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
>                  from arch/powerpc/kvm/powerpc.c:48:
> ./arch/powerpc/include/asm/trace.h:224:0: note: this is the location 
> of the previous definition
>  #define TRACE_INCLUDE_PATH asm
>  ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:305: recipe for target 
> 'arch/powerpc/kvm/powerpc.o' failed
> make[2]: *** [arch/powerpc/kvm/powerpc.o] Error 1
> scripts/Makefile.build:546: recipe for target 'arch/powerpc/kvm' failed
> make[1]: *** [arch/powerpc/kvm] Error 2
> Makefile:1052: recipe for target 'arch/powerpc' failed
> make: *** [arch/powerpc] Error 2
>
> ---
>
> I deleted the definition of 'TRACE_INCLUDE_PATH' in 
> 'arch/powerpc/kvm/trace.h'. After that the kernel compiled without any 
> problems.
>
> -- Christian
>

