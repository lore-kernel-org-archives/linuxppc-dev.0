Date: Wed, 24 Feb 1999 11:42:17 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Fwd: Re: Help! Installer will not boot on my G3
Message-Id: <19990224114217.006994@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A user sent me this, it may be interesting to whoever is maintaining
dmasound.c :


On Tue, Feb 23, 1999, Jonah Petri <petrij@bc.edu> wrote:

---------------- Begin Forwarded Message ----------------
> I'm interested to know what happens when you remove the DVD card. I
> beleive the G3 is an original (gray) one, isn't it ? Will sound work
> under MacOS ?
> 

This is indeed a "beige box" G3, with the Apple BTO DVD/AV card. Sound
works just fine in MacOS, both internal speaker and sound out.  

The DVD decoder is on the "personality card" along with the AWACS chip, and
the various TV analog/digial converters.  I yanked that out of the box and
when I put everything together again, to my suprise, linux started up just
fine!  After sucessfully installing linuxppc 4, I did a dmesg, and there is
no sign of anything involving AWACS in the startup messages.  

Now, I decided to look around and see what I could find about possible
reasons for this apparent incompatibility between my personality card and
the linux DMAsound driver (or whatever was crashing).  After poking about
in the mailing lists I discovered some complaints about sound support being
forced to 8 bit.  But when I opened my monitors and sound control panel I
found this:

My computer does not support anything but 16 bit/44.1 kHz sound in and out.
My documentation which came with the computer confirms this.

If the kernel tries to force the AWACS chip to anything else, this may be
the cause of the crash.

Does this help?  I can try out any other kernels you give me, and I could
even yank my card again and patch my existing kernel source and recompile
(although this is a bit of a pain!).

Jonah
petrij@bc.edu


----------------- End Forwarded Message -----------------

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
