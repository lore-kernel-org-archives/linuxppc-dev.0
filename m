Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (mx0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61329B7D89
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 20:05:12 +1000 (EST)
Message-ID: <56DDBA2A78704E7CAD416326DFCE97F2@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <u-boot@lists.denx.de>, <linuxppc-dev@ozlabs.org>
References: <19C9E63006DB43CBA8CD5BA6EDA1E832@itd210>
In-Reply-To: <19C9E63006DB43CBA8CD5BA6EDA1E832@itd210>
Subject: Re: [U-Boot] random exception on ppc based board
Date: Thu, 17 Jun 2010 15:34:52 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- Original Message ----- 
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <u-boot@lists.denx.de>; <linuxppc-dev@ozlabs.org>
Sent: Saturday, June 12, 2010 10:40 AM
Subject: [U-Boot] random exception on ppc based board


> Hi,
>    I am having a ppc based target on which linux-2.4.20 kernel is running
> with u-boot 1.3.4 as boot loader. The target is having MPC7410 as 
> processor
> and MPC107 as system controller. Regarding memory it is having 128 MB of 
> ram
> and 16 MB of Flash memory. Also the kernel is patched with RTLinux-3.2 for
> realtime performance. I am getting a random Program and DSI exception on 
> the
> target. Normally the exeption occurs during loading of rtl_time.o. The 
> panic
> message is given below.
>
> ==================
> Using /usr/rtlinux/modules/rtl_time.okernel BUG at page_alloc.c:221!
> Oops: Exception in kernel mode, sig: 4
> NIP: C0032980 XER: 00000000 LR: C0032980 SP: C7CEDBA0 REGS: c7cedaf0 TRAP:
> 0700    Not tainted
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c7cec000[366] 'exe' Last syscall: 3
> last math c7cec000 last altivec 00000000
> GPR00: C0032980 C7CEDBA0 C7CEC000 00000020 00000001 00000001 00001137
> 00000000
> GPR08: 00000002 00000000 CD879EC0 C7CEDAB0 CD876108 C0011934 00000000
> 00000000
> GPR16: 00000004 00000001 C002A0E8 C789E840 00009032 07CEDD90 C01A2C70
> C01A2C70
> GPR24: 00000001 00000000 C016E080 00000000 C79966E0 00000000 C016E0B8
> C016E0C4
> Call backtrace:
> C0032980 C0033020 C0032C4C C0025A18 C0025B58 C0025D8C C000EF88
> C0005D48 C03A8B28 C0029B28 C002A258 C003A99C C0005AFC 00000000
> 0FF15DBC 0FF175DC 0FF09894 10012190 100127D0 100356AC 100352A4
> 0FEBCF6C 00000000
>
> Oops: kernel access of bad area, sig: 11
> NIP: C00326DC XER: 00000000 LR: C0032588 SP: C7CED880 REGS: c7ced7d0 TRAP:
> 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 42000000
> TASK = c7cec000[366] 'exe' Last syscall: 3
> last math c7cec000 last altivec 00000000
> GPR00: 00000000 C7CED880 C7CEC000 C7CED888 FFFFFFFF 30026000 C0388250
> 00000000
> GPR08: 00008000 00000000 00155210 00000000 CD876CD4 C0032588 00000000
> 00000000
> GPR16: 00000004 00000001 C002A0E8 C789E840 00009032 C01A2C70 C01A2C70
> C016E130
> GPR24: C0233024 C0388234 00003E06 00007C0C C016E080 FFFFFFFE C016E0B8
> C0388260
> Call backtrace:
> C003249C C0033398 C0033B18 C00243D8 C0026234 C00246D0 C0027A70
> C001326C C00187D4 C0005ED4 C0005F44 C00062B0 C0005D48 C0032980
> C0033020 C0032C4C C0025A18 C0025B58 C0025D8C C000EF88 C0005D48
> C03A8B28 C0029B28 C002A258 C003A99C C0005AFC 00000000 0FF15DBC
> 0FF175DC 0FF09894 10012190 100127D0 100356AC
> Illegal instruction
> ========
> Sometimes i am getting the following panic message.
> ===========
> Oops: kernel access of bad area, sig: 11
> NIP: C0033360 XER: 20000000 LR: C00DE9A8 SP: C016C0D0 REGS: c016c020 TRAP:
> 0300    Tainted: P
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 03910018, DSISR: 40000000
> TASK = c016a480[0] 'swapper' Last syscall: 120
> last math c505c000 last altivec 00000000
> GPR00: C00DE9A8 C016C0D0 C016A480 03910000 00000000 00000000 C5A469DC
> FFFFFFFF
> GPR08: 00000001 03910014 00000043 C5A2FE20 2490C022 C0030A04 07FF0D00
> 00000000
> GPR16: 00044008 00000000 00000000 00000000 00001032 00000003 FFFFFFFF
> 0A050393
> GPR24: C5A46980 C5A2F842 00000040 00000000 C5A2F842 C01C0000 C5A46980
> 00000001
> Call backtrace:
> 00000040 C00DE9A8 C00DE9DC C00DEB28 C01163D4 C01166EC C00F4898
> C00F44E4 C00F4AC8 C00F468C C00E3664 C00E3810 C00E397C C001A200
> C0007620 CD876CAC C0005D40 C000744C C0007460 C0003918 C01815E0
> 000035F0
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> <0>Rebooting in 180 seconds..
> ================
>
>
> How to debug this???
>
> -Thirumalai
>
> _______________________________________________
> U-Boot mailing list
> U-Boot@lists.denx.de
> http://lists.denx.de/mailman/listinfo/u-boot

Hi all,
    We fixed this problem. When we ran e2fsck -f ramdisk.img it shown me 
0.9% non-contiguos block. So we tried to defragment the ramdisk image using 
e2defrag utility. After this the problem disappeared. But i don't know how 
an ext2 file system is getting fragmented ? Also how this particular file 
(rtl_time.o) is getting fragmented?

Any clue?
-Thirumalai 
