Subject: Re: System ACE MPU interface to CF card
From: Jeff Angielski <jangiels@speakeasy.net>
To: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <4084151A.4050805@buckeye.ece.drexel.edu>
References: <407470ED.3030607@buckeye.ece.drexel.edu>
	 <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu>
	 <25757-52278@sneakemail.com>  <407EDCF7.2020009@buckeye.ece.drexel.edu>
	 <1082322389.23738.13.camel@localhost.localdomain>
	 <4084151A.4050805@buckeye.ece.drexel.edu>
Content-Type: text/plain
Message-Id: <1082399912.8706.11.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 19 Apr 2004 14:38:32 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-04-19 at 14:06, Sharad Gupta wrote:
> I do not enable interrupts between SystemACE and the CPU.

Doh.  It is in your best interest to get the interrupts working...

> Following the
> debug cycle:
>
> xsysace_init()
> ->register_disk()
> -->grok_partitions()
> --->check_partition()
> ---->msdos_partition()
> ----->read_dev_sector()
> ------>read_cache_page()
> ------->lock_page()
> -------->__lock_page()
> --------->schedule()
>
> And it never resumes after that. The code just goes to power_save mode.
> Any help would be appreciated.

I would suggest instrumenting the code in the driver that actually
handles the block request from the kernel.  For instance, is the request
being received by the xsa_thread?  Is the driver actually making a
request to the device.  And most importantly and where I suspect your
problem lies, is the xsa_complete_request() ever getting run?

Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
