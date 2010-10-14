Return-Path: <R58472@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0C4C1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 18:25:22 +1100 (EST)
Received: from mail40-va3 (localhost.localdomain [127.0.0.1])	by
	mail40-va3-R.bigfish.com (Postfix) with ESMTP id A3C7812D01AA	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 07:10:10 +0000 (UTC)
Received: from VA3EHSMHS001.bigfish.com (unknown [10.7.14.236])	by
	mail40-va3.bigfish.com (Postfix) with ESMTP id D65B71720056	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 07:10:09 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9E7A5QM023661	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 00:10:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9E7A481020420	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 02:10:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
Date: Thu, 14 Oct 2010 15:10:09 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F633346A7@zch01exm26.fsl.freescale.net>
In-Reply-To: <7F0756F8-8297-43A6-913A-6DA2634E18E5@kernel.crashing.org>
References: <1287021866-22095-1-git-send-email-b21989@freescale.com>
	<7F0756F8-8297-43A6-913A-6DA2634E18E5@kernel.crashing.org>
From: Li Yang-R58472 <r58472@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Xie Shaohui-B21989
	<B21989@freescale.com>
Cc: alexandre.bounine@idt.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
>
>
>On Oct 13, 2010, at 9:04 PM, Shaohui Xie wrote:
>
>> From: Li Yang <leoli@freescale.com>
>>
>> The access to HID1 register is only legitimate for e500 v1/v2 cores.
>> Also fixes magic number.
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Shaohui Xie <b21989@freescale.com>
>> ---
>> arch/powerpc/sysdev/fsl_rio.c |    9 ++++++---
>> 1 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_rio.c
>> b/arch/powerpc/sysdev/fsl_rio.c index 4127636..dfff3b7 100644
>> --- a/arch/powerpc/sysdev/fsl_rio.c
>> +++ b/arch/powerpc/sysdev/fsl_rio.c
>> @@ -1537,9 +1537,12 @@ int fsl_rio_setup(struct platform_device *dev)
>> #ifdef CONFIG_E500
>> 	saved_mcheck_exception =3D ppc_md.machine_check_exception;
>> 	ppc_md.machine_check_exception =3D fsl_rio_mcheck_exception; -#endif
>> -	/* Ensure that RFXE is set */
>> -	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
>> +
>> +#ifndef CONFIG_PPC_E500MC
>> +	/* Ensure that RFXE is set on e500 v1/v2 */
>> +	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | HID1_RFXE)); #endif /*
>> +!PPC_E500MC */ #endif /* E500 */
>
>I've never really been happy with this code.  We really should set
>HID1_RFXE in cpu_setup_fsl_booke.S instead.

But this bit is not recommended to be set unless necessary.  And it is =
only required by SRIO for now.

- Leo
