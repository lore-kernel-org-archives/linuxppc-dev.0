Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 59EB4DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 22:50:43 +1100 (EST)
Message-ID: <45F9330F.60500@smiths-aerospace.com>
Date: Thu, 15 Mar 2007 07:50:39 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: RFI instruction not working as expected...
References: <D83235F0F3C86D4D889D8B9A0DA8C6D746E3A5@corpexc01.corp.networkrobots.com>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D746E3A5@corpexc01.corp.networkrobots.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Siva Prasad wrote:
> Hi,
> 
> I am trying to boot my 8641D based PowerPC board. I am having trouble 
> booting it.
> 
> Following code snippet is from /head_32.S/…..
> 
>         lis     r4,2f@h
>         ori     r4,r4,2f@l
>         tophys(r4,r4)
>         li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
>         FIX_SRR1(r3,r5)
>         mtspr   SPRN_SRR0,r4
>         mtspr   SPRN_SRR1,r3
>         SYNC
>         RFI
> /* Load up the kernel context */
> 2:    bl      load_up_mmu
> 
> My code successfully reaches up to the RFI instruction, but never to 
> “*/2: bl load_up_mmu/*”. I am not using any debugger (used an LED write 
> to address to figure it out) in this situation.
> 
> Any suggestions on why my execution sequence never reaches the “*/2:/* “?
> 
> I exhausted all types of debug information and appreciate any help.
> 
> Thanks
> Siva

Please don't post HTML.

If you are debugging with an LED, you really don't know if you are 
getting past the RFI or not.

This is the point where the MMU gets enabled and you are transitioning 
from physical mapping to MMU-controlled (virtual) mapping.  After the 
RFI and before the MMU is set up, you have a *VERY MINIMAL* memory map 
and a *VERY DELICATE* system.  If your LED is not mapped via something 
like a spare BAT, trying to toggle the LED after the RFI and before the 
LED is (re)mapped in your virtual address space *will* crash your system.

Likely problems for crashing:
* Your MMU-controlled memory map is not set up correctly.
   * Big unknown, lots of ways to screw this up
* You are inadvertently accessing something that isn't mapped yet
   * Debug LED
   * Board-specific hardware
   * Other hardware

This is the #1 hardest part of getting linux to run, magnified 10x 
because you don't have a hardware debugger (it is very tricky _with_ a 
hardware debugger).

On the positive side, lots of people have done this successfully.  If 
you limit your initial changes to the absolute bare minimum and review 
each one carefully, you can get past this even with just a LED for 
debugging.  If you cannot acquire a debugger (or while you are waiting 
for FedEx to deliver it tomorrow ;-), review what is mapped and how it 
is mapped between the RFI that turns on the MMU and when the MMU is 
fully set up.   During this delicate period, your code is likely 
accessing something that is not mapped.

Good luck,
gvb
