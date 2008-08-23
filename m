Return-Path: <vancasperz@yahoo.com.cn>
Received: from n78.bullet.mail.sp1.yahoo.com (n78.bullet.mail.sp1.yahoo.com
	[98.136.44.42]) by ozlabs.org (Postfix) with SMTP id CD67ADDE3A
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 06:50:57 +1000 (EST)
Subject: Re: Why does one "stw" fail with address translation disabled in
	PPC405EP?
From: Zhou Rui <vancasperz@yahoo.com.cn>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080822184213.GA24526@yoda.jdub.homelinux.org>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2008 23:18:39 +0200
Message-Id: <1219526319.7530.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Âú® 2008-08-22‰∫îÁöÑ 14:42 -0400ÔºåJosh BoyerÂÜôÈÅìÔºö
> On Fri, Aug 22, 2008 at 08:27:15PM +0200, Zhou Rui wrote:
> >Hi, all:
> >    I think I meet an odd problem with PPC405EP (PPChameleonEVB Board).
> 
> What kernel version are you using?
> 
> >    I am running a kernel module which will execute a user space
> >application. The entry point of the application is 0x100000a0. At the
> 
> That should be the first clue that you are doing it wrong.  Don't do
> stuff like that in modules...
> 
> >moment when the processor tries to execute the application, 0x100000a0
> >is not in TLB (this can be seen from BDI by printing out TLB entries),
> >so DTLBMiss is called automatically and then finish_tlb_load. However,
> >InstructionAccess is followed and the problem arises here.
> >InstructionAccess starts from 0x400, and after instruction "0xc0000434
> ><InstructionAccess+52>:      stw     r12,64(r11)", machine check occurs.
> >This instruction will store the value of r12, which is 0x0 at this
> >moment, to address 0x03072de0. I am puzzled why this action leads to
> >machine check. Is it illegal to store 0x0 in a memory address? Or is
> >there some other cause of the machine check here?
> 
> I have no idea if you're using physical or virtual addresses here, so
> there isn't much we can do to help you.
> 
> Do you have enough DRAM to cover that?  Some of those boards only come
> with 32MiB of DRAM.

Oh, I think I just now realized that for 32MB DRAM, the physical address
should be between 0x0 and 0x1FFFFFF, but the address 0x03072da0 was out
of this range ...
To enlarge the memory size is one solution but I do not think it is
feasible for my board. Is there any solution from software side? I hope
there is.
Thank you very much!!!

Best Wishes

Zhou Rui
2008-08-23

> 
> josh

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
