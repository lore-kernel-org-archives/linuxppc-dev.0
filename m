Message-ID: <4084151A.4050805@buckeye.ece.drexel.edu>
Date: Mon, 19 Apr 2004 14:06:18 -0400
From: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
MIME-Version: 1.0
To: Jeff Angielski <jangiels@speakeasy.net>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu>	 <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu>	 <25757-52278@sneakemail.com>  <407EDCF7.2020009@buckeye.ece.drexel.edu> <1082322389.23738.13.camel@localhost.localdomain>
In-Reply-To: <1082322389.23738.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Angielski wrote:
> Sounds to me like you do not have your interrupts configured properly
> between the SystemACE and the CPU or your xsa_thread is dying
> prematurely.
>
> Either way, the kernel is getting no response when it actually tries to
> access the CF thru the SystemACE.
>
>
> Jeff Angielski
> The PTR Group

I do not enable interrupts between SystemACE and the CPU. Following the
debug cycle:

xsysace_init()
->register_disk()
-->grok_partitions()
--->check_partition()
---->msdos_partition()
----->read_dev_sector()
------>read_cache_page()
------->lock_page()
-------->__lock_page()
--------->schedule()

And it never resumes after that. The code just goes to power_save mode.
Any help would be appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
