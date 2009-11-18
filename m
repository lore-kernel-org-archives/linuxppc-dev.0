Return-Path: <mlei@Brocade.COM>
Received: from hq-exedge.brocade.com (hq-exedge.brocade.com [66.243.153.83])
	by ozlabs.org (Postfix) with ESMTP id 9C4741007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 10:59:02 +1100 (EST)
From: Ming Lei <mlei@Brocade.COM>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 18 Nov 2009 15:53:27 -0800
Subject: watchdog exception on 8548CDS during cpu_idle
Message-ID: <7301F255FCB62048851F165FFAAF9BD106E9B3F0E5@HQ-EXCH-7.corp.brocade.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I used the vanilla linux 2.6.30 and compiled with mpc85xx_defconfig(enable =
CONFIG_BOOK_WDT) and then ran on 8548CDS and soon after I saw the prompt I =
hit this watchdog.
=20
bash-2.04# PowerPC Book-E Watchdog Exception
NIP: c000b740 LR: c00088dc CTR: c000b6b0
REGS: cfffbf10 TRAP: 3202   Not tainted  (2.6.30)
MSR: 00029000 <EE,ME,CE>  CR: 28028048  XER: 20000000
TASK =3D c04f4458[0] 'swapper' THREAD: c052c000
GPR00: c000b6b0 c052df90 c04f4458 00800000 80804080 0000001d c053af48 00069=
000=20
GPR08: ffffffff 00000000 08954400 00000000 002167ee 7f652f31 0ffad800 0fff0=
000=20
GPR16: 00000000 00000000 00000000 00000000 00000000 f30a620b 0ff50450 00000=
000=20
GPR24: 00000000 00000000 c053506c c0534fa0 c0534fa0 c052c034 00000008 c052c=
000=20
NIP [c000b740] e500_idle+0x90/0x94
LR [c00088dc] cpu_idle+0x98/0xec
Call Trace:
[c052df90] [c000889c] cpu_idle+0x58/0xec (unreliable)
[c052dfb0] [c00023ec] rest_init+0x5c/0x70
[c052dfc0] [c04c16f4] start_kernel+0x22c/0x290
[c052dff0] [c0000398] skpinv+0x2b0/0x2ec
Instruction dump:
7c90faa6 548402ce 7c841b78 4c00012c 7c90fba6 4c00012c 7ce000a6 64e70004=20
60e78000 7c0004ac 7ce00124 4c00012c <48000000> 812b00a0 912b0090 39600000=20

Have anyone seen this before? Why the EE bit is on in the stack trace? I pu=
t show_regs in watchdog exception handler in traps.c. I verified that EE is=
 off when entering the watchdog exception handler. Can I trust this stack t=
race?

Thanks
Ming
