Return-Path: <fboudra@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 95F2EB7B77
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 00:36:47 +1100 (EST)
MIME-Version: 1.0
Date: Thu, 15 Oct 2009 15:36:44 +0200
Message-ID: <6a2e33620910150636o7e58423cqef1dddba0a880aae@mail.gmail.com>
Subject: kernel oops issue in localbus driver
From: Fathi Boudra <fboudra@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: fboudra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a FPGA connected to a MPC8347 through localbus.

The following kernel oops occurs sometimes:

Unable to handle kernel paging request for data at address 0x7ddfecb0
Faulting instruction address: 0xc00145f4
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: ath_pci ath_rate_minstrel ath_hal wlan_acl
wlan_ccmp wlan_scan_ap wlan_scan_sta wlan_tkip wlan_wep wlan_xauth
wlan gpio localbus
NIP: C00145F4 LR: D1083C74 CTR: 000001C3
REGS: c700ddb0 TRAP: 0300   Tainted: P       (2.6.18)
MSR: 00009032 <EE,ME,IR,DR>  CR: 20024042  XER: 20000000
DAR: 7DDFECB0, DSISR: 22000000
TASK = c7786810[345] 'femain' THREAD: c700c000
GPR00: 00000000 C700DE60 C7786810 7DDFEBC8 C90620EC 00000F00 7DDFECAC
7196E7E0
GPR08: 0EECA261 D1090000 0021ED00 C00145D0 00001000 704C6206 00000000
1005924D
GPR16: C0034D7C 7DDFEBC8 C700DE9C 00000F00 00000000 C787A3C0 D1090000
00000000
GPR24: 00000000 D1090000 7DDFEBC8 D1090000 000003C0 C9062000 7DDFEBC8
D108E954
NIP [C00145F4] memcpy+0x24/0x9c
LR [D1083C74] lbp_memcpy32_fromio+0x54/0x98 [localbus]
Call Trace:
[C700DE60] [C019B780] preempt_schedule_irq+0x64/0xa4 (unreliable)
[C700DE80] [D10813C0] fpgadecenc_read+0x3ac/0x4b0 [localbus]
--- Exception: 7ddfebc8 at 0xc700df40
    LR = _start+0x40000000/0xc
[C700DEF0] [C005F4DC] vfs_read+0x9c/0x140 (unreliable)
[C700DF10] [C005F840] sys_read+0x4c/0x90
[C700DF40] [C000F89C] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0x300bb7dc
    LR = 0x3001ed40
Instruction dump:
4e800020 7c032040 418100a0 54a7e8ff 38c3fffc 3884fffc 41820028
70c00003
7ce903a6 40820054 80e40004 85040008 <90e60004> 95060008 4200fff0 70a50007

It seems there's an issue in the localbus driver (lbp_memcpy32_fromio
is a wrapper function for the localbus memory access):

ssize_t lbp_memcpy_fromio(void *dest, void *source, __u32 count32)
{
	/* attempt to acquire the semaphore */
	down(&sem_lb);
	/* critical region */
	mb();
	memcpy_fromio(dest, source, count32 * 4);
	mb();
	/* release the given semaphore */
	up(&sem_lb);
}

Aren't we supposed to use down_interruptible() instead ?
I didn't write the driver and would like to fix it.
Any hints will be appreciated.

cheers,

Fathi
