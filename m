To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I can smell it ... I'm almost there 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Feb 2003 11:31:20 PST."
             <995FF289C9D69747A09E42992644595405B23645@penguin.adic.com>
Date: Mon, 03 Feb 2003 23:38:40 +0100
Message-Id: <20030203223845.75F74C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B23645@penguin.adic.com> you wrote:
>
> I'm almost there. As you can see from the attachment below, linux gets
> loaded, the root filesystem gets mounted via nfs, and then I get some error
> messages. Maybe I could get on the right track if someone would be kind
> enough to given me a hint on the following:
>
> (1) modprobe. The kernel I built is 2.4.20 and the directory in
>     {/opt/eldk/ppc_4xx)/lib/modules is 2.4.4 .... hence the modprobe errors.
>     Do I have to get this squared away before I get to a bash prompt, and if
>     yes, how would I go about it?
>       - Is there a "make modules, make modules install" step that I have to
>         take ... similar to workstation (non-embedded) kernel re-builds.

Ignore this for now, it is not relevant here.

> (2) There is no {/opt/eldk/ppc_4xx}/etc/fstab file which seems to cause
>     several errors towards the bottom of my boot log. Is there information
>     somewhere on how '{/opt/eldk/ppc_4xx}/etc/fstab' is supposed to be
>     setup, if at all?

The main problem is that your root filesystem is mounted read-only. All other problems are just results from this.

> Kernel command line: ip=on

In here is the cause of your problem: you  are  passing  insufficient
boot  parameters;  the boot options required for root filesystem over
NFS include "root=/dev/nfs rw" - and it's especially  the  "rw"  part
that is missing in your case.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I must follow the people.  Am I not their leader? - Benjamin Disraeli

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
