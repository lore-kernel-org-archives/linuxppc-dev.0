Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 00FB7DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 05:21:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1526349anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Jan 2008 10:21:22 -0800 (PST)
Message-ID: <fa686aa40801071021g611ee7d6jbeafb4616cf29464@mail.gmail.com>
Date: Mon, 7 Jan 2008 11:21:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: MMU failure, Virtex4-FX60
In-Reply-To: <1199727744.17452.8.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199727744.17452.8.camel@PisteOff>
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

On 1/7/08, Robert Woodworth <rwoodworth@securics.com> wrote:
> Hello!
>
> I'm building a new Virtex4-FX60 device.  I have built it with the new
> MPMC3 and a 256MB SO-DIMM.  It works successfully with a "mem-test" type
> embedded program.
>
> I cannot get it to boot a Linux kernel.  I have traced it down to the
> MMU not getting mapped correctly.
>
> I can load the kernel via jtag, get the pre-boot messages on the serial
> but then when it tries to jump to 0xc0002218 (start_here: head_4xxx.S)
> it fails with a "Machine check exception; invalid instruction address".
>
> Using the debugger and examining the memory once the mmu is suppose to
> be configured, I see that it is not mapping 0xc0000000  to the proper
> location.  I'm sure I've set something up wrong in my FPGA and I need to
> re-synthesize.  But what?

Hmmm, I haven't seen that failure mode before.  MMU handling on an of
my virtex platforms has never been a problem.  Take a look at the TLB
registers to see how they are configured to see if the mappings are
really getting written.

What kernel version are you using?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
