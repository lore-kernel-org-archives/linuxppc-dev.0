Return-Path: <mbello@tcc.com.pe>
Received: from localhost.localdomain (mail.tcc.com.pe [200.41.110.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAF72679FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Apr 2006 09:48:30 +1000 (EST)
Received: from [192.168.0.3] (desarrollo.tcc.com.pe [192.168.0.3])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id k34NRYhC027159
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Apr 2006 18:27:35 -0500
Message-ID: <4433016C.1020100@tcc.com.pe>
Date: Tue, 04 Apr 2006 18:29:48 -0500
From: Miguel Bello <mbello@tcc.com.pe>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Cardctl Netgear Problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a TQM8xxL board with cvs linux 2.4 devel.

I am testing Netgear wireless card MA401
When execute command "cardctl ident" I have an kernel oops

Machine check in kernel mode.
Caused by (from SRR1=9032): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00CC2C0 XER: 00000000 LR: C00CC29C SP: C0371B80 REGS: c0371ad0 
TRAP: 0200    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0370000[338] 'cardctl' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: C30C1000 C0371B80 C0370000 C30C0000 C018AC30 C30C0000 FDFB3000 
00000000
GPR08: C30C0000 C30C0000 C039D000 00001000 84004042 1001D334 00000000 
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00371F40 00000000 
C0004768
GPR24: C00044C0 C0371BEA 00000002 C03E6844 C0371BEA 00000002 C03E6800 
00000000
Call backtrace:
C00CC29C C00CC978 C00CCE90 C00CCC58 C00D19E0 C0048224 C000451C
3000B124 10001394 10001478 10001834 100023E0 0FEBCEF4 00000000
Bus error

Using ksymoops I get the following

 >>NIP; c00cc2c0 <read_cis_mem+174/1e8>
 >>GPR4; c018ac30 <swapper_pg_dir+c30/1000>
 >>GPR23; c0004768 <ret_from_except+0/34>
 >>GPR24; c00044c0 <DoSyscall+0/5c>

Trace; c00cc29c <read_cis_mem+150/1e8>
Trace; c00cc978 <read_cis_cache+e8/160>
Trace; c00cce90 <pcmcia_get_next_tuple+ac/2dc>
Trace; c00ccc58 <pcmcia_get_first_tuple+f0/104>
Trace; c00d19e0 <ds_ioctl+43c/7e0>
Trace; c0048224 <sys_ioctl+364/388>
Trace; c000451c <ret_from_syscall_1+0/b4>
Trace; 3000b124 Before first symbol
Trace; 10001394 Before first symbol
Trace; 10001478 Before first symbol
Trace; 10001834 Before first symbol
Trace; 100023e0 Before first symbol
Trace; 0febcef4 Before first symbol
Trace; 00000000 Before first symbol

Does anyone have an idea  what is wrong ?

Many thanks in advance


Miguel
