Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id A7099DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 23:31:12 +1000 (EST)
Date: Wed, 27 Aug 2008 14:30:47 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
In-Reply-To: <48B43C42.5040407@freescale.com>
Message-ID: <Pine.LNX.4.62.0808271413001.14220@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
	<48B43C42.5040407@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 26 Aug 2008, Scott Wood wrote:

>>> It's usually easiest to just trust that that part of the code works (in
>>> my experience, that's rarely where a hang actually occurs when bringing
>>> up a new board), and resume tracing after the MMU is on and you've
>>> inserted a caching-inhibited BAT entry.
>> 
>> Where can I find out how to do that?  Since I have this board working with 
>> the old ARCH=ppc, can I copy anything from there?
>
> See setup_cpm_bat in arch/powerpc/kernel/head_32.S.
>
>> Also, where would be a good place in the code to resume tracing?
>
> As soon as you can set up a BAT -- though first, I would try just enabling 
> the CPM debug console and see if you get anything from that.

Thanks very much for your help so far.  I tried enabling the console and 
didn't get anything output.  So I resumed tracing and discovered it gets 
much further, as far as udbg_init_cpm and udbg_putc_cpm in cpm_common.c 
However, it never gets that first 'X' printed because it appears to hang 
when it gets to this bit:

   out_8(txbuf, c);
   out_be32(&cpm_udbg_txdesc[0], 0xa0000001);

I just left CONFIG_PPC_EARLY_DEBUG_CPM_ADDR at the default value for CPM2? 
Is that likely to be correct for SMC1?  (I tried looking in the MPC8272 
reference manual, but couldn't find it.)

Is it likely the port isn't set up properly?  udbg_early_init and 
udbg_init_cpm get called before it probes the machine so there's been no 
chance to do cpm2_set_pin or anything.

Cheers,

Chris.
