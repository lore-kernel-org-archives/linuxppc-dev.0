Message-ID: <3C4E7534.3C5827BF@in2p3.fr>
Date: Wed, 23 Jan 2002 09:32:52 +0100
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
To: jdweyer@rockwellcollins.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/vme Permissions for users other than root...
References: <OFEA27A9BB.3CE5E820-ON86256B49.007E0567@collins.rockwell.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi JoAnna.

	I'm just a user of the driver of Gabriel and I need to use
it in normal user applications. Givint public r/w permission to /dev/vme
is not enough, since the driver will not accept to change the
attribute if you are not root. I have found the following
workaround, which works well:

	Consider that the path is shared between the user process and
any of its childs that inherits it. If a child has the root priviledge,
it can change the attributes and this change reflects to its parent.

	Then you just need to write a program which takes the attributes
in argument, belongs to root and has the uid bit set, which sets the
attributes and exits. You write a function to call it easily from
user applications and it is done.

	One question I did not address up to now is the following:
Do the attributes apply only to processes inheriting the same path or to
all the processes using simultaneously /dev/vme ?

	Greetings.	Didier

jdweyer@rockwellcollins.com wrote:
>
> We are using Linux version 2.2.12 with Gabriel Paubert's patches for the
> Motorola MVME2600 platform.   I have
> my application working opening /dev/vme and then doing ioctl calls to set
> the attributes.  It works
> fine only when I am root.  When another user tries to run the application,
> the ioctl (not the open) fails.
> I have changed the permissions of /dev/vme to rw for all (ugo) and have
> even gone as far as
> changing ownership and group to the user's instead of root, but to no
> avail.  The permissions
> of /dev/vme are crwxrwxrwx.  I realize the execute (x) permission is
> ineffective, but I'm trying everything.
>
> Do you have any ideas of what to try?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
