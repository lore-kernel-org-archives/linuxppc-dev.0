Message-Id: <5.0.2.1.0.20030609124155.024df050@10.2.0.2>
Date: Mon, 09 Jun 2003 13:35:44 -0700
To: Ron Bianco <ronb@lcsaudio.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Jochen Roth <jochen@znyx.com>
Subject: Re: Has anyone made the 8240 do burst reads from PCI memory?
In-Reply-To: <000401c32c64$dc6a4690$4d00a8c0@warp-speed>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:50 PM 6/6/03 -0700, Ron Bianco wrote:
>FYI, although not a PCI expert, I'm trying to determine if we need to upgrade
>our CPLD code in order to successfully support memory read cycles with
>more than
>one data phase.

It's been a while that I worked on this, but here are some things I remember:

You implemented the PCI Read Line/Multiple commands in the CPLD, I assume.
Check
the PCI spec for details on the protocol.

You then will have to set up things like the PCI command used by the 8240 and
the PCI latency register.

Check the DBAT settings used for accessing your CPLD memory space. If you
use the
generic MMIO mapping provided in the kernel, then caching is disabled for those
accesses. If I remember correctly, the 603 core will not burst in that case.

>Even with sequential reads in groups of 8 words, ( or writes for that matter )
>we are unable to get the 8240 to do other than single (beat) word read PCI
>cycles.  One 'strange' thing in particular is that the 8240 as PCI
>initiator is
>keeping !FRAME asserted only very briefly.
>It also de-asserts !IRDY very soon after the first data phase
>completes.  It may
>be that the 8240 is just indicating a wait and we need to handle that better.

Did you check the CBE lines for the PCI command issued by the 8240? If it was a
generic single word read, then what you describe would be normal, I think.

Regards,

Jochen Roth
ZNYX Networks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
