Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 7BF6CDDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 14:07:04 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	47E3280386
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 22:06:57 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id D4C6880384
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 22:06:54 -0500 (EST)
Date: Fri, 21 Nov 2008 21:06:53 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: badness in xics_set_cpu_giq on JS20 blade
Message-ID: <20081122030653.GU6830@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With 2.6.28-rc5 the WARN_ON in xics_set_cpu_giq is triggering on a
JS20.  I changed it to a WARN to get the actual status returned:

[boot]0020 XICS Init
set-indicator returned -22
------------[ cut here ]------------
Badness at arch/powerpc/platforms/pseries/xics.c:733
NIP: c000000000047454 LR: c000000000047450 CTR: 0000000000033070
REGS: c0000000006b3a20 TRAP: 0700   Not tainted  (2.6.28-rc5-autokern1)
MSR: 8000000000021032 <ME,IR,DR>  CR: 22000022  XER: 00000000
TASK = c0000000005f0fe0[0] 'swapper' THREAD: c0000000006b0000 CPU: 0
GPR00: c000000000047450 c0000000006b3ca0 c0000000006af710 000000000000001e 
GPR04: 0000000000000000 ffffffffffffffff 0a000000006b39d0 000000000920224a 
GPR08: 0000000000000001 c00000000060f5b0 c00000000070b49c c00000000070b498 
GPR12: 8000000000001032 c0000000006ef300 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000001c00000 c0000000004e0ed8 
GPR20: c0000000005adb70 00000000021adde0 c0000000005adde0 0000000000000000 
GPR24: 0000000000250800 0000000001a1f900 c000000000700950 c0000000005aaed8 
GPR28: c0000000006ec030 c00000001dffc3f8 c000000000655940 0000000000000001 
NIP [c000000000047454] .xics_set_cpu_giq+0x54/0x68
LR [c000000000047450] .xics_set_cpu_giq+0x50/0x68
Call Trace:
[c0000000006b3ca0] [c000000000047450] .xics_set_cpu_giq+0x50/0x68 (unreliable)
[c0000000006b3d10] [c0000000005927b8] .xics_init_IRQ+0x2f4/0x338
[c0000000006b3de0] [c000000000591bcc] .pseries_xics_init_IRQ+0x14/0x2c
[c0000000006b3e60] [c000000000580488] .init_IRQ+0x40/0x5c
[c0000000006b3ee0] [c0000000005787d8] .start_kernel+0x250/0x478
[c0000000006b3f90] [c0000000000083b8] .start_here_common+0x1c/0x64
Instruction dump:
7c832050 3860232d 3884ffff 7c8407b4 4bfd7521 60000000 2f830000 7c641b78 
40bc0014 e8629f60 4801e32d 60000000 <0fe00000> 38210070 e8010010 7c0803a6 
[boot]0021 XICS Done


-22 is -EINVAL, which maps to a -3 return code from RTAS (see
rtas_error_rc).

The system appears to boot and function normally after this, though.
FWIW, it looks like its firmware is up to date (FW08401160 from March
2008).
