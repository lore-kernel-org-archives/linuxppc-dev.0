Message-ID: <001101c2c383$6000c330$5e207aa1@fish>
From: "Jason Park" <jason@amadeus.kist.re.kr>
To: "Shen Rong" <rshen@udtech.com.cn>
Cc: "LINUX MAILING LIST" <linuxppc-embedded@lists.linuxppc.org>
References: <001701c2c33f$298715f0$5e207aa1@fish> <025b01c2c355$199c8600$e600a8c0@udtech.net>
Subject: Re: How do you change the program counter (PC)
Date: Fri, 24 Jan 2003 17:33:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> go 0xffc00100
> or
> ti  0xffc00100

starting address for flash is 0xff00 0000 where there is a hardware reset
word .  even when i type in "go 0xffc00100", it still jumps to the part in
the flash where the embedded planetcore bootloader is stored (0xfff00100).
so, i decided to delete the hardware reset word... and now BDI cant even
connect to the target, as i get this output:

*** TARGET: resetting target failed
# PPC: unexpected response from target
- TARGET: target will be restarted in 10 sec
- TARGET: processing user reset request
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x55 => 0xAA
- Bypass check: 0x55 => 0xAA
- JTAG exists check passed
- Target PVR is 0x00810101
- COP status is 0x05
- Check running state failed
- TARGET: Target PVR is 0x00810101
*** TARGET: resetting target failed
# PPC: unexpected response from target
- TARGET: target will be restarted in 10 sec

and it goes on and on... having some major regrets about deleting that
hardware reset word...  now i cant even connect to the embedded board.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
