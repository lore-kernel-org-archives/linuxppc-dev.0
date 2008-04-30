Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E47FADE295
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 May 2008 04:28:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3UISJEe024800 for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Apr 2008 11:28:20 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3UISFLS029979
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Apr 2008 13:28:15 -0500 (CDT)
Date: Wed, 30 Apr 2008 13:28:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: ??? <yuyongbao@126.com>
Subject: Re: mpc8379e rdb nand flash support
Message-ID: <20080430182815.GA8639@ld0162-tx32.am.freescale.net>
References: <mailman.2018.1208895004.11702.linuxppc-embedded@ozlabs.org>
	<FD78E578AB254426A3B97E7B65553E65@baby>
	<20080423163538.GA32452@ld0162-tx32.am.freescale.net>
	<2F9EE17A2D4D48458F49220889E0FAAD@baby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2F9EE17A2D4D48458F49220889E0FAAD@baby>
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

On Thu, Apr 24, 2008 at 09:52:25AM +0800, ??? wrote:
>    Since our projects need more capability to store filesystems,I changed nand flash to 1G byte.
>     I think it is the same to operate nand flash both in u-boot and linux kernel ,because the code about FCM nand flash control is almost the same.So I just test it in u-boot.
>     From the mpc8379e reference manual page 484 :
>      21        PGS NAND Flash E2PROM page size, buffer size, and block size.
>           0   Page size of 512 main area bytes plus 16 spare area bytes (small page devices);
>               FCM RAM buffers are 1 Kbyte each; Flash block size of 16 Kbytes.
>           1   Page size of 2048 main area bytes plus 64 spare area bytes (large page devices);
>               FCM RAM buffers are 4 Kbytes each; Flash block size of 128 Kbytes.
> 
>     Because the 32M nand flash block size is just the 16Kbytes,and it
> works well.But the block size of the 1G bytes nand flash is
> 256Kbytes,when every time I tried to write to it ,It just can be writed
> the first 128kbytes of every 256kbytes.As I wrote in last email.
>     Below is the linux kernel information when I operate nand flash.

Try changing set_addr() to hardcode the shift applied before writing to
FBAR to the width of FPAR[PI], rather than basing it on the actual erase
block size.

-Scott
