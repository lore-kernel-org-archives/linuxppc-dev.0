Subject: Re: kernel panic on mcp750
To: stevebj@inxpress.net (Stephen B Johnson)
Date: Mon, 4 Sep 2000 12:22:09 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39B28BB4.A52E1E69@inxpress.net> from "Stephen B Johnson" at Sep 03, 2000 12:34:44 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000904012209.57872C2@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen B Johnson writes:
> I'm observing a kernel panic when booting the kernel on a Motorola
> MCP750.  The panic indicates "Kernel panic: No init found.  Try passing
> init= option to kernel."

Look in init/main.c:init, where the kernel tries to exec an init program.
One of the steps is failing.  You can add printfs to find out which one.

Check the following:
    - Do you have CONFIG_SASH set?
	If so:
	    - does CONFIG_SASH_PATH exist?
	    - Is it statically linked?
	    - Do you have /dev/console on you root filesystem?

    - Do any of /sbin/init, /etc/init, /bin/init, /bin/sh exist?
    - Are the shared libraries set up to run the above correctly?

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
