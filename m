Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: gianfranco.morandi@euro-studio.it
Cc: linuxppc-embedded@lists.linuxppc.org
From: "Allen Curtis" <acurtis@directvinternet.com>
Subject: Re: EST sbc8260 Local bus SDRAM
Date: Wed, 31 Jul 2002 11:56:29 -0700 (PDT)
Message-Id: <20020731115631.28731.h006.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm looking for the initialization code to program the
> chip select and start
> the refresh timer.

Here is a snippet from our BDI configuration file.

; Configure /CS5 to be local bus SDRAM
;   CHIP SELECT     BASE ADDRESS    SIZE   COMMENTS
;   -----------     ------------    ----   --------
;     /CS5           0x10000000      8MB   32-BIT LOCAL
SDRAM
;
WM32    0xF001012C      0xFF803280      ; OR5		(OPTION
REGISTER 5)
WM32    0xF0010128      0xF7001861      ; BR5		(BASE
REGISTER 5)

;------------------------------------------------------
; LOCAL SDRAM INITIALIZATION
;------------------------------------------------------

WM32    0xF0010194      0xEA46A552      ; LSDMR		(LOCAL
SDRAM MODE REGISTER)
WM8     0x10000000      0xFF            ; Access local
SDRAM

WM32    0xF0010194      0xCA46A552      ; LSDMR		(LOCAL
SDRAM MODE REGISTER)
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM
WM8     0x10000000      0xFF            ; Access local
SDRAM

WM32    0xF0010194      0xDA46A552      ; LSDMR		(LOCAL
SDRAM MODE REGISTER)
WM8     0x10000000      0xFF            ; Access local
SDRAM

WM32    0xF0010194      0xC246A552      ; LSDMR		(LOCAL
SDRAM MODE REGISTER)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
