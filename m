Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id 5B6DEDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 19:10:17 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash on ep8248e standard motherboards
Date: Wed, 12 Sep 2007 11:10:12 +0200
References: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
In-Reply-To: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121110.12296.laurentp@cse-semaphore.com>
Cc: Alan Bennett <embedded@akb.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alan,

On Tuesday 04 September 2007 20:08, Alan Bennett wrote:
> Please accept my apologies for sending the last email and accept this
> email address and question.  without the disclaimer.
> ---------------------------------------------------
>
> Hello;
> We have a custom board based on the ep8248e design from Embedded
> Planet and I'm trying to use something other than codewarrior to flash
> u-boot srec's
>
> I'm not sure where the problem is, but I'm unable to flash the
> u-boot.srec onto the Embedded Planet board (using the BDI2000), let
> alone our custom board.
>    1. Embedded Planet ep8248E
>         64 MB SDRAM
>         64 MB Flash (x2 Am29LV256M)
>    2. Custom
>        128 MB SDRAM
>        128 MB Flash (X2 Spansion S29GL512N)
>
> NOTE: CW successfully flashes both parts, but then again, it's CW.
>
>
> BDI 2000 Config File:
>   ;  initialize - FLASH BR0 & OR0 (64 Mbyte)
>   ;*******************************************
>   WM32    0xf0010100     0xfc001801
>   WM32     0xf0010104     0xfc0008c2
>   [FLASH]
>   CHIPTYPE    MIRRORX16
>   CHIPSIZE    0x2000000
>   BUSWIDTH    16
>
> I then attempt to unlock/erase/program
> Check for Sanity (NOTE: using BDI 2000 PROMPT)
>   md 0xf0010100 2
>   f0010100 : 0xf8001801  - 134211583  ....
>   f0010104 : 0xf80008b2  - 134215502  ....
>   md 0xfff00000 2
>   fff00000 : 0x10101010    269488144  ....
>   fff00004 : 0x10101010    269488144  ....
> All looks good.  (10101010 is the existing planet core header)
>
> TRY TO UNLOCK
>   unlock 0xfff00000 1000
>   Unlocking flash at 0xfff00000
>   # Invalid parameter for flash programming
>
> TRY TO ERASE
>   erase 0xfff00000 UNLOCK 1000
>   Erasing flash at 0xfff00000
>   # Erasing flash memory failed
> BUT
>   erase 0xffff0000 UNLOCK 1000
>   Erasing flash at 0xffff0000
>   Erasing flash passed
> HOWEVER
>   mm 0xffff0000 0xdeadbeef
>   md 0xffff0000 1
>   ffff0000 : 0xffffffff
> SO it doesn't seem to allow write access afterall...

You need to use the 'prog' command to write to flash. 'md' won't do.

> Is there anyone that has a BDI 2000 config file for flashing the
> ep8248e motherboard the 8MB Flash Version (64 MB flash version)

Regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
