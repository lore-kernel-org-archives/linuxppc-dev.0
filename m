Return-Path: <Hans.Thielemans@skynet.be>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.2.102]) by ozlabs.org (Postfix) with ESMTP id 75CC567A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 21:29:34 +1100 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j1GATQcD020181
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Feb 2005 11:29:27 +0100
	(envelope-from <Hans.Thielemans@skynet.be>)
Date: Wed, 16 Feb 2005 11:15:29 +0100 (CET)
From: Hans Thielemans <Hans.Thielemans@skynet.be>
To: Matej Kupljen <matej.kupljen@ultra.si>
In-Reply-To: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
Message-ID: <Pine.LNX.4.44.0502161114040.10437-100000@gandalf.inthazo.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bdi2000 debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 16 Feb 2005, Matej Kupljen wrote:

> Hi 
> 
> I am trying to debug a problem in a user space application
> (X windows), which when the process exits, crashes the kernel.
> ---------------------------------------------------------------
> Oops: Exception in kernel mode, sig: 4
> NIP: 000003B4 XER: 00000000 LR: C002B540 SP: C3B8DD10 REGS: c3b8dc60
> TRAP: 0700    Not tainted
> MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c3b8c000[55] 'Xorg.strip' Last syscall: 146 
> last math c36aa000 last altivec 00000000
> GPR00: 00000000 C3B8DD10 C3B8C000 C3B8DD20 30105D0C 20000000 C3B8DDE0
> 00136DA8 
> GPR08: 00136DA8 00000000 00000035 000081A4 24048424 1031688C C0200000
> C3B8DDE0 
> GPR16: C0200000 C3B7F3E0 00000000 0C3B80C5 00001032 03B8DD10 C002B580
> 00009032 
> GPR24: 00000035 00000000 00000FCB C3B80C50 00136DA8 00000000 00000035
> C3B80C10 
> Call backtrace: 
> C0200000 C002B540 C002BCE8 C0090A58 C0039B64 C0039DCC C0005A7C 
> 00000000 0FE20BFC 0FE29878 0FE29D1C 0FE29DE8 0FD7E354 0FD65D78 
> 00000000 
> Oops: Exception in kernel mode, sig: 4
> NIP: 000003B4 XER: 20000000 LR: 0FDF527C SP: C3BAFF40 REGS: c3baff50
> TRAP: 0700    Not tainted
> MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c3bae000[54] 'run_xorg.sh' Last syscall: 114 
> last math c36aa000 last altivec 00000000
> GPR00: 00000000 C3BAFF40 30012738 C3BAFF50 0FEF1C6C 20000000 00000000
> 7F7F0000 
> GPR08: FFFFFFFD 00000000 1015E4CC 00000000 44000828 10094078 00000000
> 00000000 
> GPR16: 00000000 00000000 00000005 7FFFFA20 00001032 03BAFF40 0FE49374
> 0000D032 
> GPR24: 1009949C 00000000 00000003 00000000 7FFFFF8F 0FF0B59C 0FF09120
> 7FFFF8B0 
> Call backtrace: 
> C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 
> C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 
> C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 
> C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 
> C0005CC8 C0005CC8 C0005CC8 C0005CC8 C0005CC8 
> ---------------------------------------------------------------
> 
> And that goes on for every process running :-(
> 
> Something is overwriting memory in kernel space I guess.
> Now, I have the BDI 2000 and I am trying to debug this, but until
> now I was unsuccessful :-(
> 
> When I debug the kernel, the BDI prints this out in the telnet
> interface:
> - Target MBAR is 0xF0000000
> - Target XLBA is 0x8000A366
> 
> I know what MBAR is, but what the XLBA is?

I would assume this is the XLB arbiter register.

> The problem is that while this value remains the same everything 
> is fine. But sometimes it is set to 0x00000000 and then I cannot
> use debugger anymore. I can make a few steps when this value 
> is set to 0x0, but the "stepping" is done in completely unrelated
> code. I first noticed this while stepping trough hc_found_ohci
> function when the return 0 is executed. When I disabled the USB
> support in my kernel I could use debugger to debug a kernel.
> But is still does not work all the time, because the XLBA still 
> gets set to 0!
> 
> I am using CVS version of DENX kernel version 2.4.25.
> 
> Has anybody seen this?
> 
> Maybe a tip how to debug this problem?
> 
> Best regards,
> Matej
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
