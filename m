Return-Path: <wilbur512@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 24DA61007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 10:10:41 +1000 (EST)
Received: by vws11 with SMTP id 11so1651946vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 17:10:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <47F80BE0-6596-4A3D-B95F-72ABE2E0228C@kernel.crashing.org>
References: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
	<356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
	<20100630004633.GB12417@yookeroo>
	<AANLkTikyNZ5gCpuRPIZ-CJ6ClNZI_UDsmGF7xTzsv9vB@mail.gmail.com>
	<47F80BE0-6596-4A3D-B95F-72ABE2E0228C@kernel.crashing.org>
Date: Thu, 1 Jul 2010 08:10:39 +0800
Message-ID: <AANLkTilNpYjhM5NRevXBcsAb-MFw55A8iSrDcRvTgoLO@mail.gmail.com>
Subject: Re: kernel init exception
From: "wilbur.chan" <wilbur512@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"chen.yu10" <chen.yu10@zte.com.cn>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/7/1 Segher Boessenkool <segher@kernel.crashing.org>:
>> Maybe it was caused by floating exception.I found that,system received
>> a program check exception,the reason for it was REASON_ILLEGAL.
>>
>> I also use show_regs to print the NIP in exception,it seemed that
>> ,this exception was caused by 'vmhaddshs' instruction in user mode of
>> init process .
>>
>> Is vmhaddshs avaliable on e500mc? My cross compile tool is
>> gcc-4.1.2-glibc-2.5.0
>
> This isn't vmhaddshs (which is an AltiVec instruction), but something else
> that also uses primary opcode 4.
>
> It sounds like your toolchain isn't set up correctly for e500mc.
>
>
> Segher
>
>

I 've used cross_tool (powerpc_mc)  that freescale provided,  to
compile the kernel image, and

use an ordinary powerpc cross tool to compile busybox into cpio ramdisk.
