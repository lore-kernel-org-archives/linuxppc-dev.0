Message-ID: <02f901c2c386$7e219800$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Jason Park" <jason@amadeus.kist.re.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001701c2c33f$298715f0$5e207aa1@fish> <025b01c2c355$199c8600$e600a8c0@udtech.net> <001101c2c383$6000c330$5e207aa1@fish>
Subject: Re: How do you change the program counter (PC)
Date: Fri, 24 Jan 2003 16:56:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> starting address for flash is 0xff00 0000 where there is a hardware reset
> word .  even when i type in "go 0xffc00100", it still jumps to the part in
> the flash where the embedded planetcore bootloader is stored (0xfff00100).
You should make sure that your ppcboot is linked to another address (not
the 0xfff00000), where your new ppcboot is located(whether in RAM or FLASH).
Change TEXT_BASE in your board directory to what you want. Be sure your
CFG_MONITOR_BASE is set to TEXT_BASE or hard coded to the same address.

> so, i decided to delete the hardware reset word... and now BDI cant even
> connect to the target, as i get this output:
No!!! Contact your HW engineer to help you to reprogram the HRCW.
Or if you are luck, and if your board had a switch to control /RSTCONF, you
can let 8260 use the default setting, and use the BDI program the HRCW.

> and it goes on and on... having some major regrets about deleting that
> hardware reset word...  now i cant even connect to the embedded board.
Good luck!


Shenrong

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
