Message-ID: <3BA24BB9.3039BD7C@mvista.com>
Date: Fri, 14 Sep 2001 14:26:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'ashish anand'" <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address"  vs "Physical"
References: <6B546A602AD2D211BFF00008C7A42889041D6BE4@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Goddeeris Frederic wrote:
>
> So the key is that by address is above ioremap_base. That I initially got
> away with not using ioremap is a coincidence? Right?

No, it's not a coincidence.  I've written sufficiently about virtual
space mapping on the embedded processors in the past and if you just
search the mailing list archives you will find all of the answers.

The short answer.....on some processors, like the 8xx, there is a
common address space used by many device drivers and functions
unique to this processor.  The granularity of mapping required is
very small, resulting in many overlapped maps if you constantly use
ioremap() in all of these cases.  For this processor, a common area
is ioremap()'ed by the memory management early in the kernel initialization
for all of these uses.  The side effect of mapping this early is you
get a 1:1 virtual to physical mapping because the kernel VM is not
yet fully initialized.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
