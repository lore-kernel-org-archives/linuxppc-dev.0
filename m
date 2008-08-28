Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28B4BDE436
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 02:24:55 +1000 (EST)
Message-ID: <48B6D107.30106@freescale.com>
Date: Thu, 28 Aug 2008 11:23:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: bhanu jampala <adams.ppc@gmail.com>
Subject: Re: cpm_dpalloc questions
References: <4a21eaea0808272212y6be97789nb6b94dd1d4987881@mail.gmail.com>
In-Reply-To: <4a21eaea0808272212y6be97789nb6b94dd1d4987881@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

bhanu jampala wrote:
> I am working on MCC HDLC controller on MCC8260. I have two important questions:
> 
> 1. What is the range of DPRAM from which the cpm_dpalloc allocates memory?
>     How does the cpm_dpalloc work?

Assuming you're using arch/powerpc on a recent kernel version, it 
allocates from the memory specified in the muram node of the device tree.

>     I need this because, I need to reserve the DPRAM memory for MCC2
> from (128 * 60) to (255 * 60)
>     for channels ranging from 128 - 255.

Why do you need to reserve a specific address?

> 2. PROFF_SMC1 pointer placed at 0 , 64 offsets. is this not an area of
> MCC1 controller?

No, MCC1 PRAM starts at offset 0x8700.  Any other areas used are under 
software control.

>     how if I want to use the MCC channel on MCC1.
> 
>  In file include/asm-powerpc/cpm2.h.
> 
>  /* The SMCs are relocated to any of the first eight DPRAM pages.
>   * We will fix these at the first locations of DPRAM, until we
>   * get some microcode patches :-).
>   * The parameter ram space for the SMCs is fifty-some bytes, and
>   * they are required to start on a 64 byte boundary.
>   */
>  #define PROFF_SMC1      (0)
>  #define PROFF_SMC2      (64)

This is obsolete arch/ppc stuff and should be removed; the SMC pram is 
now dynamically allocated and relocated (and before that, it came from 
the device tree).

-Scott
