To: christof <xfr@freenet.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel executing from flash
References: <1314024740.953824470340.JavaMail.wwwrun@moe.freenet.de>
From: Markus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 23 Mar 2000 17:33:50 +0100
In-Reply-To: christof's message of "Thu, 23 Mar 2000 16:14:30 +0100 (CET)"
Message-ID: <kfyog85zlw1.fsf@kieraypc25.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


christof <xfr@freenet.de> writes:

> Hello,
>
> all Linux I know will be copied during startup from Harddisk, NFS or
> Flash to RAM and will be executed there.  Is there a possibility for
> smaller systems to run the kernel directly from flash memory as other
> embedded os's do? Did somebody try this or is it totaly impossible?

Well, I see no reason why it shouldn't be possible, but not without
modifying things.

You'd need to link the .data, .data.cacheline_aligned, .data.init
and .bss sections so they are located in RAM, and the former
three plus the exception vectors would have to be copied from flash
to their linked location.

The question is why?
RAM is usually cheaper than flash, and if you run the kernel in
RAM as usual you can have it compressed in flash, whereas if
you intend to run it directly from flash it must be uncompressed.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
