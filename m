Message-Id: <200212060932.DAA27493@lists.linuxppc.org>
Date: Fri, 6 Dec 2002 17:38:48 +0800
From: "Li Xiangrong" <lixiangrong@china.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: boot flash problem,
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, all,
I meet a strange problem of boot flash and want some advice here. I have searched the archives but with no result. So bear with me if this is too silly question.
I designed a mpc860T(D4, 50Mhz)board. I used the ppcboot 0.9.2 as bootloader and the hardhat linux pe 2.1(with the kernel of 2.4.17). My board has a 2MB flash(intel te28f160c3-90) as bootrom,and everything works okay. Now i want to use a larger flash(intel te28f320c3-110, which is pin-to-pin compatible to te28f160 ).I mounted the flash on the board, and prog the ppcboot (in elf format) with my bdi2000.The erasing and programming operation works with no error found.Then i restart the board without bdi', i find minicom has no response. I check the board and find that the cpu's clockout is 25Mhz(i use a 5M clock in, and mf=5). It seems that the ppcboot in flash has not work at all. I then check the board with my bdi2000. Everything works okay.
I read the datasheet of intel 28f160/320 c3 carefully, and do not find anything special to be treated. Here is my seting of bdi and in ppcboot,any suggestion is appreciated.

bdi configuration file:
..
WM32    0xFF000100      0xFFE00801      ;BR0
WM32    0xFF000104      0xFFC00160      ;OR0 : 2MB, all accesses, CS early negate, 6ws, time relax
..
;unlock intel flash here
WM16 0xFFe00000 0x0060 ;unlock block 0
WM16 0xFFe00000 0x00D0
WM16 0XFFE02000 0x0060 ;unlock block 0
WM16 0XFFE02000 0x00D0
WM16 0XFFE04000 0x0060 ;unlock block 0
WM16 0XFFE04000 0x00D0
WM16 0XFFE06000 0x0060 ;unlock block 0
WM16 0XFFE06000 0x00D0
WM16 0XFFE08000 0x0060 ;unlock block 0
WM16 0XFFE08000 0x00D0
WM16 0XFFE0a000 0x0060 ;unlock block 0
WM16 0XFFE0a000 0x00D0
WM16 0XFFE0c000 0x0060 ;unlock block 0
WM16 0XFFE0c000 0x00D0
WM16 0XFFE0e000 0x0060 ;unlock block 0
WM16 0XFFE0e000 0x00D0
WM16 0XFFE10000 0x0060 ;unlock block 0
WM16 0XFFE10000 0x00D0
WM16 0xFFe00000 0x0060 ;unlock block 0
WM16 0xFFe00000 0x00D0

WM16 0xFFe10000 0x0060 ;unlock block 1
WM16 0xFFe10000 0x00D0
WM16 0xFFe20000 0x0060 ;unlock block 0
WM16 0xFFe20000 0x00D0
WM16 0xFFe30000 0x0060 ;unlock block 1
WM16 0xFFe30000 0x00D0
..
[FLASH]
CHIPTYPE    I28BX16       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16|I28BX32)
CHIPSIZE    0x400000     ;The size of one flash chip in bytes (e.g. AM29F010 = 0x20000)
BUSWIDTH    16          ;The width of the flash memory bus in bits (8 | 16 | 32)

configuration of ppcboot:
#define CFG_REMAP_OR_AM		0xFFE00000	/* OR addr mask */
#define CFG_PRELIM_OR_AM	0xFFC00000	/* OR addr mask */

#define CFG_OR_TIMING_FLASH	(OR_BI | OR_SCY_6_CLK)

#define CFG_OR0_REMAP	(CFG_REMAP_OR_AM  | CFG_OR_TIMING_FLASH)
#define CFG_OR0_PRELIM	(CFG_PRELIM_OR_AM | CFG_OR_TIMING_FLASH)
/* 16 bit, bank valid */
#define CFG_BR0_PRELIM	((FLASH_BASE & BR_BA_MSK) | BR_PS_16 | BR_V )

i make modification only in my configuration file, shall i change settings in other files?

Best regards.

Li Xiangrong
lixiangrong@china.com
2002-12-06

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
