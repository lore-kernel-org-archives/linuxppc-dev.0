Message-ID: <021e01c2dbc6$87e08100$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "okisoftxman" <okisoftxman@hotmail.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <OE23ugEzUfctANq8qTF0000e377@hotmail.com>
Subject: Re: problem about RAM assigned
Date: Mon, 24 Feb 2003 13:35:24 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "okisoftxman" <okisoftxman@hotmail.com>
To: "linux-emb" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Callebaut, Benoit" <benoit.callebaut@barco.com>
Sent: Monday, February 24, 2003 11:10 AM
Subject: problem about RAM assigned


>
> Hi,
>     I have some problem about allocate RAM on MBX860 board.Who can tell me
> ,Thank you.
TRY to let the user manunal tell you first!

> 1.when we power-up the system and PPCBOOT run successfully,I find there
are
> some codes in the top of the RAM(the address about 0x0--0x2000).I guess it
If you mean the bottom of the RAM(<0x3000), then it's exception vector. Yes,
you can say it's part of the PPCBoot. In fact, the PPCBoot & Stack & Malloc
pool
are relocated to the end of the RAM finally.

> is the PPCBOOT's code.But my "PPCBOOT.BIN"in FLASH is about 150kbytes,and
> the size is bigger than the codes in RAM,why?
Oh!

>
> 2.Someone told me that after LINUX booted,PPCBOOT is invalid and the RAM
> will relocate.But as I known,some functions of PPCBOOT (e.g.FLASH WRITE
> ,SDRAM control)is most important and there is no similar functions in
Linux of course can control everything if you do want it to do! But
1. PPCBoot inits the SDRAM and other low level stuff for Linux, so there is
no need to do so again for Linux.

2. Linux doesn't depend on FLASH for running. Though you can use MTD to
access it,
even more, you can build JFFS2 or other rom fs on the MTD partitions.


Shenrong


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
