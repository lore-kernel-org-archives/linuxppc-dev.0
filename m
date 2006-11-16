Return-Path: <leisun124@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id A32FF67BE2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 02:44:33 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so624013wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 07:44:31 -0800 (PST)
Message-ID: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
Date: Thu, 16 Nov 2006 10:44:31 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: memory corruption after MMU turned on
MIME-Version: 1.0
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

Hi all:
   I am trying to bring up customized board based on MPC8270, the
kernel version is 2.4.30, it works fine on one of the Eval board
(PQ2FADS-VR, which use MPC8275).
   The kernel hangs after uncompressing is done, further debug shows
that it hangs right after "rfi " instruction of the turn_on_mmu:
function in head.S

 turn_on_mmu:
    240     mfmsr   r0
    241     ori r0,r0,MSR_DR|MSR_IR
    242     mtspr   SRR1,r0
    243     lis r0,start_here@h
    244     ori r0,r0,start_here@l
    245     mtspr   SRR0,r0
    246     SYNC
    247     RFI             /* enables MMU */

After i step over the RFI instruction, the PC points to C000XXX , but
all memory content is 0 by then.
my BATU0 is 0xC000FFE0  BATL0 is 0x00000002, I have 128MB RAM. The
u-boot works fine, without MMU turned on. We do have some hardware
problem, such that i have to lower the bus frequency to make the SDRAM
stable. What physical parameter could cause the board not working with
MMU on?

Any suggestion?

Thanks
lei
