Message-ID: <39C667B6.580DC690@mvista.com>
Date: Mon, 18 Sep 2000 15:06:30 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mike Flynn <mflynn@enerdyne.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FW: Embedded Planet 860T software reset
References: <67505026E29DD311A9AA00508B7315F33B7399@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike Flynn wrote:
>
> Software resets works! Our Julia found John Whitney's comment:
>
>         "I soft reboot my system using "shutdown -nr now..."
>
> Dan's code works as provided. "init 6" and "reboot" don't work, but we have
> something
> that does.

The "init" and "reboot" (actually halt) follow a circuitous route
to the shutdown program.  They depend on a variety of files or
environment variables and work well in a fully configured workstation
environment.  They probably won't work correctly in a stripped down
file system of an embedded system.

Also, the code in the kernel may have to be adapted based upon the
boot rom used.  Jumping into rom is a questionable operation.  I am
adding the checkstop/reset patch that was posted a while back to the
2.4 tree (and probably backported to 2.2 as well) as a configuration
option.  This isn't a complete solution either, as it prevents passing
parameters around that are sometimes useful.

Options galore....choose what works for you....not a single solution
for everyone....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
