Date: Tue, 18 Jan 2000 19:28:19 +0100
Message-Id: <200001181828.TAA23940@dumburk.cendio.se>
From: Christer Weinigel <wingel@cendio.se>
To: alan@packetengines.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: WARNING OFF TOPIC SLIGHTLY: 8xx MMU w/8MB pages
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


alan.corp.packetengines.com wrote:

>I tried using the MD_CAM and MD_RAMn registers to debug this.  These seem to
>read back the values I have stored via the MD_RPN, MD_TWC and MD_RPN register
>EXCEPT that when I read back I get a value for the MD_CAM.PS field of 110
>rather than the 111 which is the documented 8MB page size value.  The doc even
>says that values other than those listed (000, 001, 011, 111) are "reserved".
>The value I am setting in the MD_TWC.PS field (which is oddly a two bit
>encoding for page size) is 11, which is documented as the 8MB page
>size value.

This is simple :-)  Or rather, I was tearing my hair out last week
trying to figure out exactly the same thing.  Set the 4/16k bit in
MD_RPN to 1 and it'll work.  Apparently, the two page size bits in
MD_TWC and the bit från MD_RPN together form the real page size.  The
documentation is a bit misleading here.

Now I'd just like to know why I can't get 8 MB pages working with the
Linux page tables.  The performance boost from putting the Linux
kernel in an 8 MB page on a MPC850 is rather impressive, most lmbench
system call benchmarks went twice as fast.

  /Christer

--
Christer Weinigel		Cendio Systems AB
Email:	wingel@cendio.se	Teknikringen 8
Phone:	+46-13-21 46 00		583 30  Linköping
Fax:	+46-13-21 47 00		Sweden
[please note that Signum Support has changed its name to Cendio Systems]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
