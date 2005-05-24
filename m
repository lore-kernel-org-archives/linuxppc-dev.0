Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35CB8679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 05:43:24 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded@ozlabs.org, rtai@rtai.org
Date: Tue, 24 May 2005 21:19:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505242119.29197.niklaus.giger@member.fsf.org>
Subject: Newbie question about accessing memory in kernel space
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I am working on a custom PPC405 board where I have a 2.6.10 kernel with RTAI 
patches (fusion) running.

I am trying to access some custom CPLD chip hanging at 0x7D000000. In my 
intial board (hcu3_map_io) I added a corresponding io_block_mapping.

I can see the CPLD when I access the address via my Abatron BDI debugger.

In a user space test program I did a
    map_base = mmap((void *)target, nSize, PROT_READ | PROT_WRITE, MAP_SHARED, 
fd, target);
and was able to access the CPLD, too.

In user and kernel space the procedure looks like this:
void sys_set_tick_control_register_value(uint16 value)
{
    static uint16    *tickControlRegister       = (uint16*)
					HCU_TICK_CONTROL_REGISTER_ADDRESS;   
   *tickControlRegister = value;
}

Now I compiled a module which tries to access the CPLD during the insmod phase
and I get the following output.

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C302B0C4 LR: C302B350 SP: C1DABED0 REGS: c1dabe20 TRAP: 0300    Not 
tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 7D000000, DSISR: 00800000
TASK = c1d827b0[27] 'insmod' THREAD: c1daa000
Last syscall: 128
PLB0: bear= 0x04000004 acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0xef6007ff besr0= 0x00000000 besr1= 0x00000000

GPR00: C302B348 C1DABED0 C1D827B0 0000002B 00000CAC FFFFFFFF C01C0000 00029030
GPR08: C01CBB30 C3030000 00000000 7D000000 00000000 10075308 01FFBC00 007FFF77
GPR16: 00000000 00000001 10050000 00000002 7FFFFF68 10070000 00000001 C3030000
GPR24: C3030000 C3030000 FFFFFFFF 00000000 C3030000 C3030000 C0189318 C302BEC0
NIP [c302b0c4] sys_set_tick_control_register_value+0x8/0x10 [kTickTest]
LR [c302b350] init_module+0xd0/0x10c [kTickTest]
Call trace:
 [c0030954] sys_init_module+0x218/0x328
 [c0002900] syscall_dotrace_cont+0x24/0x38
Segmentation fault

What is wrong with my code? 

Any hints would be appreciated.

Thanks in advance.
