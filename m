Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFEB0B7D30
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 May 2010 03:28:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4LHSJPx007692 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 10:28:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o4LHdIKe001538
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 12:39:18 -0500 (CDT)
Message-ID: <4BF6C2B2.6030705@freescale.com>
Date: Fri, 21 May 2010 12:28:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: hellohello <hellohello008@163.com>
Subject: Re: Problem of PowerPc 82xx  when using smc
References: <042201caf7fa$9d038a20$a51cbcc0@sfdomain.com>
	<20100520170608.GA10712@schlenkerla.am.freescale.net>
	<051501caf896$5c954630$a51cbcc0@sfdomain.com>
In-Reply-To: <051501caf896$5c954630$a51cbcc0@sfdomain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2010 10:33 PM, hellohello wrote:
>> No, it shouldn't -- rx_bd_base is of type "cbd_t *", so the multiplication
>> already happens as part of pointer arithmetic.
> ---Yes, you are right. I made a basic mistake.
>
> But now I have another question.
> The SMC1 params can be relocated to any offset of the DPRAM on a 64 byte boundary, not as the SCC1, which must be  at 0x8000 offset of the DPRAM.
> The SMC1 params base is set at 0x87FC offset of the DPRAM.
>
> So if  I want SMC1 params start at  0x200 in DPRAM  , I should set 0x200 to the 0x87FC offset of the DPRAM.
> I have see this code in u-boot, but I can not find this code in neither cpm_uart_cpm2.c nor cpm_uart_core.c.
>
> Should I add these code to  cpm_uart_core.c?

Newer kernels support dynamically allocating this parameter RAM.  Older 
kernels use whatever u-boot chose.

Why do you want to set it to a particular address?

-Scott
