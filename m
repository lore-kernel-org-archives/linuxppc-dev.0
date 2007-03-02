Return-Path: <tnt@246tNt.com>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BACDDDF75
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 08:35:39 +1100 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l22LZX0k024099
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Mar 2007 22:35:33 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45E89887.1070604@246tNt.com>
Date: Fri, 02 Mar 2007 22:35:03 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 0/7] MPC5200 and Lite5200b low power modes
References: <20070301075323.GP4397@moe.telargo.com>
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,

Thanks for providing theses.
I hadn't a chance to test them yet, I'll try that this week end. A
couple of comments already though :

 - Is saving the SDMA / PIC registers necessary ? Doesn't the cpu keep
those when at sleep ?
 - And if it is, won't a memcpy_io of the whole zone do the trick ?
 - On a more general note, there seem to be a lot of stuff decided by
#ifdef ... that's not really good as we can build a single kernel that
could run on several platform so those need to somehow be enable
disabled dynamically.
 - I may miss something but turning port power off for USB seem like a
sane thing to do for every one. Isn't that implemented somehow for all
controller somewhere ?


Sylvain

 
Domen Puncer wrote:
> Hi!
>
> Patches are based on latest mainline git tree + fec patches:
> Fec_MPC5200_eth_driver.patch
> Copy_bestcomm_support_files_into_arch_powerpc.patch
> Make_FEC_work_on_the_lite5200.patch
>
>
> This patchset includes the following patches:
> - [PATCH 1/7] mpc52xx suspend: bestcomm
> - [PATCH 2/7] mpc52xx suspend: UART
> - [PATCH 3/7] mpc52xx suspend: FEC (ethernet)
> - [PATCH 4/7] mpc52xx suspend: USB
> - [PATCH 5/7] mpc52xx suspend: deep-sleep
> - [PATCH 6/7] lite5200b suspend: PIC
> - [u-boot patch] support lite5200b wakeup in u-boot
> - [PATCH 7/7] lite5200b suspend: low-power mode
>
>
> I would appreaciate any comments, suggestions etc.
>
>
> 	Domen
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
