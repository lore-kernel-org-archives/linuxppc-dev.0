Message-ID: <3BD77667.2060406@ixiacom.com>
Date: Wed, 24 Oct 2001 19:18:15 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: akuster@mvista.com
Subject: http_load causes 405GP kernel panic w/ linux_2_4_devel
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Looks like linux_2_4_devel is very unstable under high TCP/IP loads
and low amounts of memory on the Walnut.

Here's how to get a *double* kernel panic:

1) download http_load from http://www.acme.com/software/http_load/

2) cross compile for ppc405 using MontaVista JE 2.0 (very easy to do,
just change CC in the Makefile)

3) setup fast webserver on same network as Walnut, with one large page
availible (I used the linux kernel tarball and khttpd on a x86 box).

4) boot Walnut with "mem=8M" or "mem=4M" -- it's probably possible to
make this panic happen with larger amounts of physical memory, but it
is much faster and easier if you restrict mem via cmdline.

5) run "http_load -parallel 200 -fetches 1000 urls" where "urls"
is a file in cwd containing something like
"http://192.168.1.1:8080/linux.tar.gz"

6) sit back and wait a few seconds. you should see something like this:

http://192.168.3.126:8080/foo.htm: check-connect SUCCEEDED, ignoring


http://192.168.3.126:8080/foo.htm: check-connect SUCCEEDED, ignoring


...
http://192.168.3.126:8080/foo.htm: check-connect SUCCEEDED, ignoring


http:/Oops: kernel access of bad area, sig: 11


NIP: C009CB00 XER: 00000000 LR: C009CAD8 SP: C0E25DC0 REGS: c0e25d00
TRAP: 0800    Not tainted

MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11


TASK = c0e24000[47] 'http_load' Last syscall: 4


last math 00000000 last altivec 00000000


PLB0: bear= 0x00aff17c acr=   0x00000000 besr=  0x00000000


PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000





GPR00: C009CAD8 C0E25DC0 C0E24000 00000000 00001030 C012A514 C0222F38
45442C20

GPR08: C01D6140 00000001 00000010 C0187380 00000018 1001FB04 00000000
00000000

GPR16: 00000000 00000000 10010000 FFFFFFFF 00001032 00E25E40 00000000
C0002860

GPR24: C0003964 00000180 C01E6200 C0FFC028 000005EE C0FF1010 C0FFC000
00000000

Call backtrace:


C009CAD8 C00038C0 C00039F4 C0002860 C003365C C000263C 946ECA52


0FF3C1EC 0FF3CE20 0FF2E280 0FF29558 0FF31C58 10002468 100017F8


0FF06298 00000000


ppc405_eth_serr: Receive channel 0


   -----  latched error  -----


   DE: descriptor error


   -----  cumulative errors  -----


   DEI: descriptor error interrupt


PPC405 Ethernet driver received a receive descriptor error


EMAC DEBUG **********


EMAC_M0  ==> 0x18000000


EMAC_M1  ==> 0x8788000


EMAC_TXM0==> 0x0


EMAC_TXM1==> 0x380f0000


EMAC_RXM ==> 0x580000


EMAC_ISR ==> 0x42


EMAC_IER ==> 0x1af0000


EMAC_IAH ==> 0x4


EMAC_IAL ==> 0xace310b1


EMAC_VLAN_TPID_REG ==> 0x8808





  MAL DEBUG **********


  MCR      ==> 0x7c082


  ESR      ==> 0x40100000


  IER      ==> 0x1f


  DBR      ==> 0x0


  TXCASR   ==> 0x80000000


  TXCARR   ==> 0x80000000


  TXEOBISR ==> 0x0


  TXDEIR   ==> 0x0


  RXCASR   ==> 0x0


  RXCARR   ==> 0x0


  RXEOBISR ==> 0x80000000


  RXDEIR   ==> 0x80000000


  TXCTP0R  ==> 0xff6000


  TXCTP1R  ==> 0xf80000


  RXCTP0R  ==> 0xff1000


  RCBS0    ==> 0x80








dumping the receive descriptors:  current slot is 2


Desc 00: status 0x1c00, length  70, addr 0x224010


Desc 01: status 0x1c00, length  70, addr 0x223010


Desc 02: status 0x1c00, length 1518, addr 0x780010


Desc 03: status 0x1c00, length 1518, addr 0x25f010


Desc 04: status 0x1c00, length 1518, addr 0x25e010


Desc 05: status 0x1c00, length 1518, addr 0x25d010


Desc 06: status 0x1c00, length 1518, addr 0x25c010


Desc 07: status 0x1c00, length  70, addr 0x25b010


Desc 08: status 0x1c00, length  70, addr 0x259010


Desc 09: status 0x1c00, length  70, addr 0x258010


Desc 10: status 0x1c00, length  70, addr 0x257010


Desc 11: status 0x1c00, length  70, addr 0x256010


Desc 12: status 0x1c00, length  70, addr 0x255010


Desc 13: status 0x1c00, length  70, addr 0x254010


Desc 14: status 0x1c00, length  70, addr 0x253010


Desc 15: status 0x1c00, length  70, addr 0x252010


Desc 16: status 0x1c00, length  70, addr 0x251010


Desc 17: status 0x1c00, length  70, addr 0x250010


Desc 18: status 0x1c00, length  70, addr 0x24f010


Desc 19: status 0x1c00, length  70, addr 0x74e010


Desc 20: status 0x1c00, length  70, addr 0x2a3010


Desc 21: status 0x1c00, length  70, addr 0x24e010


Desc 22: status 0x1c00, length  70, addr 0x24d010


Desc 23: status 0x1c00, length  70, addr 0x24c010


Desc 24: status 0x1c00, length  70, addr 0x24b010


Desc 25: status 0x1c00, length  70, addr 0x24a010


Desc 26: status 0x1c00, length  70, addr 0x249010


Desc 27: status 0x1c00, length  70, addr 0x248010


Desc 28: status 0x1c00, length  70, addr 0x247010


Desc 29: status 0x1c00, length  70, addr 0x246010


Desc 30: status 0x1c00, length  70, addr 0x245010


Desc 31: status 0x1c00, length  70, addr 0x244010


Desc 32: status 0x1c00, length  70, addr 0x243010


Desc 33: status 0x1c00, length  70, addr 0x242010


Desc 34: status 0x1c00, length  70, addr 0x241010


Desc 35: status 0x1c00, length  70, addr 0x240010


Desc 36: status 0x1c00, length  70, addr 0x602010


Desc 37: status 0x1c00, length  70, addr 0x23f010


Desc 38: status 0x1c00, length  70, addr 0x23e010


Desc 39: status 0x1c00, length  70, addr 0x23c010


Desc 40: status 0x1c00, length  70, addr 0x23b010


Desc 41: status 0x1c00, length  70, addr 0x23a010


Desc 42: status 0x1c00, length  70, addr 0x239010


Desc 43: status 0x1c00, length  70, addr 0x238010


Desc 44: status 0x1c00, length 247, addr 0x237010


Desc 45: status 0x1c00, length  70, addr 0x236010


Desc 46: status 0x1c00, length  70, addr 0x358010


Desc 47: status 0x1c00, length  70, addr 0x235010


Desc 48: status 0x1c00, length  70, addr 0x234010


Desc 49: status 0x1c00, length  70, addr 0x233010


Desc 50: status 0x1c00, length  70, addr 0x232010


Desc 51: status 0x1c00, length  70, addr 0x231010


Desc 52: status 0x1c00, length  70, addr 0x230010


Desc 53: status 0x1c00, length  70, addr 0x22f010


Desc 54: status 0x1c00, length  70, addr 0x22e010


Desc 55: status 0x1c00, length  70, addr 0x22d010


Desc 56: status 0x1c00, length  70, addr 0x22c010


Desc 57: status 0x1c00, length  70, addr 0x22b010


Desc 58: status 0x1c00, length  70, addr 0x22a010


Desc 59: status 0x1c00, length  70, addr 0x229010


Desc 60: status 0x1c00, length  70, addr 0x228010


Desc 61: status 0x1c00, length  70, addr 0x227010


Desc 62: status 0x1c00, length  70, addr 0x226010


Desc 63: status 0x5c00, length  70, addr 0x225010


Oops: kernel access of bad area, sig: 11


NIP: C009CD8C XER: 20000000 LR: C009CD38 SP: C0E25AB0 REGS: c0e259f0
TRAP: 0800    Not tainted

MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11


TASK = c0e24000[47] 'http_load' Last syscall: 4


last math 00000000 last altivec 00000000


PLB0: bear= 0x00aff17c acr=   0x00000000 besr=  0x00000000


PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000





GPR00: 00001C00 C0E25AB0 C0E24000 00000035 00001030 00000001 00000020
C0160000

GPR08: 00001E7A 00000000 000005EE 00000010 00000018 1001FB04 00000000
00000000

GPR16: 00000000 00000000 10010000 FFFFFFFF 00001032 00E25B30 00000000
C0002860

GPR24: C0003964 00000002 C01E6200 00000010 C0FFC000 C0FFC020 00000002
00000008

Call backtrace:


C009CD38 C00038C0 C00039F4 C0002860 C00029F0 C000B020 C000AE98


C0002868 C009CAD8 C00038C0 C00039F4 C0002860 C003365C C000263C


946ECA52 0FF3C1EC 0FF3CE20 0FF2E280 0FF29558 0FF31C58 10002468


100017F8 0FF06298 00000000


Kernel panic: Aiee, killing interrupt handler!


In interrupt handler - not syncing


  <0>Rebooting in 180 seconds..



---

This panic looks like a PPC 405GP ethernet driver issue,
perhaps with some VM interaction thrown in. I have
access to a BDI2000 and may be able to help debug.

Feel free to e-mail me privately if you'd like my
kernel configuration or any additional info... should
be fairly easy to reproduce with the above recipe, though.

Regards,

-Bryan

--
Bryan Rittmeyer
mailto:bryan@ixiacom.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
