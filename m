Date: Fri, 2 Nov 2001 09:20:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.14-pre7
Message-ID: <20011102092032.F26147@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BE2C0A5.7080707@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BE2C0A5.7080707@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 02, 2001 at 04:49:57PM +0100, David M?ller (ELSOFT AG) wrote:

>   - include/asm-ppc/ibm4xx.h
>      missing include file  (I'm not sure if this is the correct fix)
>
>   - drivers/net/ppc405_enet.h
>      missing include file  (ditto)

What's broken right now?  <asm/ibm405gp.h> gets included by CONFIG_FOO,
if FOO is a 405GP board.


>   - arch/ppc/kernel/ppc4xx_setup.c
>      added call to board_setup_irq() in ppc4xx_init_IRQ()
>      added call to board_setup_rtc_access() in platform_init()
>
>   - arch/ppc/kernel/walnut.c
>   - arch/ppc/kernel/redwood.c
>   - arch/ppc/kernel/cpci405.c
>   - arch/ppc/kernel/ep405.c
>      added necessary board_setup_irq() and
>      board_setup_rtc_access() functions

Shouldn't board_setup_rtc_access() do all of the RTC stuff, not just
changing the nvram bits?  If your board needs a different way to get
nvram access, we should rename board_setup_rtc_access() to
board_setup_nvram_access()

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
