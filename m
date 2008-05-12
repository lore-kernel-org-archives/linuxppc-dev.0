Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 989E8DE181
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 01:56:25 +1000 (EST)
Message-ID: <482868B1.9090005@freescale.com>
Date: Mon, 12 May 2008 10:56:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sanal Kumar V K <sanalvk@centillium.com>
Subject: Re: Running a section of code from internal memory
References: <4822E5CE.3090701@centillium.com>
	<20080508153315.GC18740@ld0162-tx32.am.freescale.net>
	<48285544.7040908@centillium.com>
In-Reply-To: <48285544.7040908@centillium.com>
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

Sanal Kumar V K wrote:
> Now if I make the following entry in the linker script,
>   /* define L2 scratch here */
>   . = 0x9FC16800;
>   .l2_scratch         : { *(.l2_scratch) }
> 
> it says "collect2: ld returned 1 exit status".

I'm guessing there was an earlier error message printed by ld?

You probably located the L2 section too far away from the main section, 
and it's trying to do short branches or other limited relocations.

-Scott
