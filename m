Message-ID: <3BEAA8D3.51ADDCC8@mvista.com>
Date: Thu, 08 Nov 2001 09:46:27 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 -- a little console help, part 2
References: <3BEA8A5D.50A75CE7@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
>
> I've got a little more info -- /bin/sash doesn't produce any
> output and just sits there, echoing charachters typed.  I'll try poking
> around w/ gdb/abatron but am not sure how to find the exec'd shell.
>
> if I spawn ash w/ init=/bin/ash:
> ...
> --  but at least I get a prompt and it seems to work.

That is very odd, I don't know why ash would work and sash does not.
Very strange indeed.

> I'm not sure what the message "can't access tty; job control turned off"
> means -- I'll have to get the source for ash and debug it.

This sounds like you do not have proper /dev/* populated..  i.e.
/dev/console, /dev/tty, /dev/pts, etc.  For initial system bringup you
can ignore that warning.  (However, keep in mind that ctrl-C, ctrl-Z,
etc job control will not work..)  This might also partially be a symptom
of ash starting as process 1, process 1 contains special rules in the
kernel as it is the init process.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
