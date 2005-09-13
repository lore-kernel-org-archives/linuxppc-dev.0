Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A008682AC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 04:20:55 +1000 (EST)
Date: Tue, 13 Sep 2005 15:04:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050913180440.GC14889@dmt.cnet>
References: <4326968F.5030609@2net.co.uk>
	<20050913122541.GB9076@cathedrallabs.org>
	<20050913151132.GF10602@dmt.cnet>
	<20050913172213.GA3964@oops.ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050913172213.GA3964@oops.ghostprotocols.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2005 at 02:22:13PM -0300, Aristeu Sergio Rozanski Filho wrote:
> Hi Marcelo,
> 	after the last Chris post, I decided to double check if I wasn't doing
> something wrong. vanilla 2.6.13 hangs in the same way my patched 2.6.10 does.
> 
> > How does the disassemble of __switch_to looks like? 
> from 2.6.13 kernel
> Dump of assembler code for function __switch_to:
> 0xc00055a4 <__switch_to+0>:     mflr    r0
> 0xc00055a8 <__switch_to+4>:     stwu    r1,-16(r1)
> 0xc00055ac <__switch_to+8>:     stw     r31,12(r1)
> 0xc00055b0 <__switch_to+12>:    mr      r11,r4
> 0xc00055b4 <__switch_to+16>:    stw     r0,20(r1)
> 0xc00055b8 <__switch_to+20>:    mfmsr   r31
> 0xc00055bc <__switch_to+24>:    rlwinm  r0,r31,0,17,15
> 0xc00055c0 <__switch_to+28>:    mtmsr   r0
> 0xc00055c4 <__switch_to+32>:    lwz     r10,460(r4)
> 0xc00055c8 <__switch_to+36>:    addi    r3,r2,456
> 0xc00055cc <__switch_to+40>:    addi    r4,r4,456
> 0xc00055d0 <__switch_to+44>:    cmpwi   cr7,r10,0
> 0xc00055d4 <__switch_to+48>:    beq-    cr7,0xc00055e8 <__switch_to+68>
> 0xc00055d8 <__switch_to+52>:    lis     r9,-16354
> 0xc00055dc <__switch_to+56>:    lwz     r0,28880(r9)
> 0xc00055e0 <__switch_to+60>:    cmpw    cr7,r0,r11
> 0xc00055e4 <__switch_to+64>:    beq-    cr7,0xc0005604 <__switch_to+96>
> 0xc00055e8 <__switch_to+68>:    bl      0xc0003024 <_switch>
> 0xc00055ec <__switch_to+72>:    mtmsr   r31
> 0xc00055f0 <__switch_to+76>:    lwz     r0,20(r1)
> 0xc00055f4 <__switch_to+80>:    lwz     r31,12(r1)
> 0xc00055f8 <__switch_to+84>:    addi    r1,r1,16
> 0xc00055fc <__switch_to+88>:    mtlr    r0
> 0xc0005600 <__switch_to+92>:    blr
> 0xc0005604 <__switch_to+96>:    lwz     r0,132(r10)
> 0xc0005608 <__switch_to+100>:   oris    r0,r0,512
> 0xc000560c <__switch_to+104>:   stw     r0,132(r10)
> 0xc0005610 <__switch_to+108>:   b       0xc00055e8 <__switch_to+68>
> End of assembler dump.
> 
> > Chris oopsen is exactly what the 'icbi' patch fixes.
> notice that what I'm having here is not an oops
> 
> but if for Chris works, I must be doing something wrong, sorry for the noise

Hi Aris,

 gdb           S 30106778     0   691    687   692               (NOTLB)
 Call trace:
  [c0005330] __switch_to+0x44/0x78
  [c015beb0] schedule+0x30c/0x730
  [c015c888] schedule_timeout+0xdc/0xe0
  [c0068918] sys_poll+0x27c/0x404
  [c0002810] syscall_dotrace_cont+0x24/0x38
 flash_test    t 100009E4     0   692    691                     (NOTLB)
 Call trace:
  [c0005330] __switch_to+0x44/0x78
  [c015beb0] schedule+0x30c/0x730
  [c0026248] ptrace_stop+0x68/0x88
  [c0026604] get_signal_to_deliver+0x130/0x2b4
  [c00063dc] do_signal+0x38/0x464
  [c0003034] do_user_signal+0x74/0xc4

flash_test is trying to handle a signal, can you print some information
about it in get_signal_to_deliver (before ptrace_stop), such as si_signo:

typedef struct siginfo {
        int si_signo;
        int si_errno;
        int si_code;

ptrace_stop() calls do_notify_parent_cldstop() to wakeup gdb, maybe
there's something wrong during wakeup?

The box locks up completly or its just gdb that freezes? 
