Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 648C7DE0E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 08:54:37 +1100 (EST)
Subject: Re: MMU failure, Virtex4-FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40801071021g611ee7d6jbeafb4616cf29464@mail.gmail.com>
References: <1199727744.17452.8.camel@PisteOff>
	<fa686aa40801071021g611ee7d6jbeafb4616cf29464@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 14:54:36 -0700
Message-Id: <1199829276.4598.7.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

After further investigation...
There is a pending interrupt from the PLB waiting at bootup and it gets
hit by Linux when the MSR gets set and enables critical interrupts (same
time that it jumps into 0xC000XXXX).  The kernel code detects the
interrupt as a PLB data bus error and goes into crash sequence die().

I think I have a problem with my reset hardware, such that the PLB is
not getting reset correctly with the PPC.  With all interrupts disabled
and running a standalone C program, the PLB and memory work fine.
Any Virtex experts out there have any hints?



RJW.




On Mon, 2008-01-07 at 11:21 -0700, Grant Likely wrote:
> On 1/7/08, Robert Woodworth <rwoodworth@securics.com> wrote:
> > Hello!
> >
> > I'm building a new Virtex4-FX60 device.  I have built it with the new
> > MPMC3 and a 256MB SO-DIMM.  It works successfully with a "mem-test" type
> > embedded program.
> >
> > I cannot get it to boot a Linux kernel.  I have traced it down to the
> > MMU not getting mapped correctly.
> >
> > I can load the kernel via jtag, get the pre-boot messages on the serial
> > but then when it tries to jump to 0xc0002218 (start_here: head_4xxx.S)
> > it fails with a "Machine check exception; invalid instruction address".
> >
> > Using the debugger and examining the memory once the mmu is suppose to
> > be configured, I see that it is not mapping 0xc0000000  to the proper
> > location.  I'm sure I've set something up wrong in my FPGA and I need to
> > re-synthesize.  But what?
> 
> Hmmm, I haven't seen that failure mode before.  MMU handling on an of
> my virtex platforms has never been a problem.  Take a look at the TLB
> registers to see how they are configured to see if the mappings are
> really getting written.
> 
> What kernel version are you using?
> 
> Cheers,
> g.
> 
