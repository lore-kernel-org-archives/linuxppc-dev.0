Subject: Re: get_pteptr prototype
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030109023300.GC6569@zax.zax>
References: <1041893967.1207.42.camel@granite.austin.ibm.com>
	<20030107005751.GP22215@zax.zax>
	<1042040929.1021.80.camel@granite.austin.ibm.com>
	<20030108234908.GA1088@zax.zax>
	<1042071086.1207.206.camel@granite.austin.ibm.com>
	<20030109023300.GC6569@zax.zax>
Content-Type: text/plain
Date: 09 Jan 2003 09:55:40 -0600
Message-Id: <1042127751.1021.221.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-01-08 at 20:33, David Gibson wrote:
>
> Hmm... what's the reason that wakeup_info needs to be reserved in
> head_4xx.S, rather than just being a normal variable in the data area
> (which should be writable anyway)?  Its not obvious to me from the
> patch.

Sorry, I was hoping the Documentation file explained it well enough. On
wake the firmware needs to transfer control back to Linux, so the
firmware needs to know where to jump to. The only way I could think of
communicating that information was with a fixed memory location known to
both the firmware and to Linux. In future processors there will be a
scratch register (whose contents are saved during sleep) to solve this
problem.

> Actually, skimming through the patch I noticed a minor nit: you only
> have one .long in head_4xx.S reserving space for the wakeup_info
> struct which is 3 words long.  In practice the . = in the exception
> handlers will give you plenty of space, but I think it would be good
> form to explicitly reserve the right amount of space.

It's just a (physical) pointer to the structure which is elsewhere in
memory (actually on the stack).

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
