Message-ID: <3F65A2FD.3010904@imc-berlin.de>
Date: Mon, 15 Sep 2003 13:31:09 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems w/  CONFIG_BLK_DEV_MPC8xx_IDE
References: <3F656CFC.1050706@imc-berlin.de>
In-Reply-To: <3F656CFC.1050706@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> I just noticed that the vanilla 2.4.22 does not compile with
> CONFIG_BLK_DEV_MPC8xx_IDE:
>
> drivers/ide/idedriver.o: In function `ide_timer_expiry':
> drivers/ide/idedriver.o(.text+0xaa30): undefined reference to
> `ide_ack_intr'
> drivers/ide/idedriver.o(.text+0xaa30): relocation truncated to fit:
> R_PPC_REL24
>
> It's the same for the BK trees.

The BK linuxppc_2_4_devel tree has another problem as well:

drivers/ide/idedriver.o: In function `probe_hwif':
drivers/ide/idedriver.o(.text+0x11a30): undefined reference to `wait_hwif_ready'
drivers/ide/idedriver.o(.text+0x11a30): relocation truncated to fit: R_PPC_REL24
wait_hwif_ready

ide-probe.c contains a call for wait_hwif_ready(), which is not defined.
This function exisists in the vanilla source though!

I supposed something went wrong while merging/syncing the IDE changes from the
official tree...

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
