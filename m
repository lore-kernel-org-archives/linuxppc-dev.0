Message-ID: <3EE8C5B8.7080806@embeddededge.com>
Date: Thu, 12 Jun 2003 14:26:00 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: erik.teose@exgate.tek.com
Cc: fray@mvista.com, Christophe.LINDHEIMER@fr.thalesgroup.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running Linux with 2Mo of Ram.
References: <BA0E4392AD99D040885C414D992C24BE0361528A@us-bv-m11>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


erik.teose@exgate.tek.com wrote:

> MontaVista's "Consumer Electronics Edition" does xip (execute in place) from
> rom.

I wrote the original version of that several years ago for an mpc8xx
consumer product.  I've been sitting on the patches ever since trying
to find a way to neatly make it part of at least the PowerPC tree.
Recent changes have made it easier to add the patch to the source
tree, but as Mark said it is very processor, board and application
specific.  The patches would only work for the original product and
although the code would be easy to modify upon inspection for another
target, it isn't something that lends itself to configuration options.

The code should be modified to work with a more common off-the-shelf
board, and people could use that as an example.

However, xip is not a solution to simply not having enough memory
for the application.  If you do a systems analysis, xip doesn't really
save that much memory, and depending upon the hardware design could
hinder the performance.  In the particular application that started
this, we gained some performance by using large page mapping for the
code space, not so much for using less real memory for code.  It
also provided a slightly faster boot up indication to the user that
the system had started operating.  The large page mapping is the part
of the patch that I have integrated into the public sources.

Keep in mind that Linux is a dynamic operating system, and by itself
it does very little.  The memory management Linux performs is based
completely on what the applications are asking it to do.  Kernel hacks
and tricks are fun to do, but aren't going to provide a stable solution
to ill-behaved applications.  The way applications are built and the
configuration of the necessary files to support them will have a much
more significant effect than xip on the utilization of system resources.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
