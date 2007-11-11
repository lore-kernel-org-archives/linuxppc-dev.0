Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8750CDDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 11:00:13 +1100 (EST)
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc8xx_wdt.c : piscr is 16bit in linux2.4 but 32bit in linux2.6
	?!?!?!
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 11 Nov 2007 00:03:23 +0100."
	<F1F6EC0C8B75034F9E3A79FC85122E8E2649ED@aquib01a>
Date: Sun, 11 Nov 2007 01:00:10 +0100
Sender: wd@denx.de
Message-Id: <20071111000010.E51B3248D3@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <F1F6EC0C8B75034F9E3A79FC85122E8E2649ED@aquib01a> you wrote:
> 
> in mpc8xx_wdt.c in linux2.4 (denx distribution) piscr is 16bit long but

According the UM, the PISCR is indeed a 16 bit register.

The current header files also declare a 16 bit register:

include/asm-ppc/8xx_immap.h:    ushort  sit_piscr;

> in the same file in linux 2.6.19-2 (denx distribution) is read and
> written with in_be32 and out_be32. It's strange.

We don't support MPC8xx in the 2.6 kernel  tree  yet.  What  you  see
there,  is  original kernel.org code - the code in question is commit
ID 398f6858.

I think you are right - this is a bug in the code.  Please  submit  a
patch.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Question: How does one get fresh air into a Russian church?
Answer:   One clicks on an icon, and a window opens!
