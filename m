MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: uncached user space mapping with mmap() ???
Date: Fri, 5 Mar 2004 12:02:34 +1300
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F4103EED2@ExchWENZ02.wenz.global.vpn>
From: "Richard Williams" <richard_williams@stratexnet.com>
To: "Dan Malek" <dan@embeddededge.com>,
	"Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>> How could I do this on an MPC8xx?
>
>Open /dev/mem and just map the physical address of your
>registers.  You don't even need your own driver.  If you
>are mapping outside of the range of real memory, the mem
>driver will automatically give you uncached access.

I just tried this using pread but it wont let me seek to memory locations >= 0x80000000. perror returns "Invalid argument". The seek offset is a signed long int which indicates that it was intended to be limited to less then 0x80000000.

How do you access 3rd and 4th GB memory?

Richard


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
Malek
Sent: Friday, March 05, 2004 6:00 AM
To: Steven Scholz
Cc: LinuxPPC
Subject: Re: uncached user space mapping with mmap() ???



Steven Scholz wrote:

> How could I do this on an MPC8xx?

Open /dev/mem and just map the physical address of your
registers.  You don't even need your own driver.  If you
are mapping outside of the range of real memory, the mem
driver will automatically give you uncached access.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
