Message-ID: <37DE9699.F0F7604D@jlc.net>
Date: Tue, 14 Sep 1999 14:40:25 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieray1.p.y.ki.era.ericsson.se>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC: porting to new platforms
References: <37DC6656.2A40D04D@ctam.com.au> <37DC7E94.946FBA49@jlc.net> <37DE6AC5.EAF9A6DD@kieray1.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:


> * in arch/ppc/config.in this code breaks 8xx configuration:
>   if [ "$CONFIG_PPC64" != "y" ];then
>     define_bool CONFIG_6xx y
>   fi

That's been fixed.

> 
> * Move "commproc.h" ==> <asm/8xx_cpm.h> so external modules can
>   access it in a clean way. (I can send a diff if you want)

Sure, send it.

> 
> * Do EXPORT_SYMBOL(cpm_install_handler) so modules can use this
>   function.

There is more missing from module support, but I will add this.

> 
> * As at least the 860 is quite crowded with bugs it's nice to have
>   a nice way to handle bug workarounds. The attached mpc8xx_bug.h
>   is what we use to compile kernels for different hardware revisions.

So, do you actually have the bug fixes and have tested them on
these silicon revisions at the power, speeds and temperatures listed
in the errata?  Or are just acknowledging they exist?

Anyone using less than Rev. C 860s or Rev. D anything else should
be looking for upgrades.  These workarounds are tedious to write and
test, and in general hurt the performance.  They also occur at
very, very specific speeds, power and temperatures.  You guys are
the only ones I have heard from that encountered the Rev B CPU6
bug besides myself.  I had to develop and test this under very
controlled laboratory conditions to make sure I actually corrected
something.

We can put these silicon bug fixes on the server as patches if
people run into them (and fix them).  I really don't want these
patches in the main code base because they don't affect everyone,
can be very processor specific, and they are obsolete rather quickly.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
