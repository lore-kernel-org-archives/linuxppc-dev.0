Message-ID: <3C4F0441.8070905@bluewin.ch>
Date: Wed, 23 Jan 2002 19:43:13 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: jdweyer@rockwellcollins.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/vme Permissions for users other than root...
References: <OFEA27A9BB.3CE5E820-ON86256B49.007E0567@collins.rockwell.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi JoAnna,

I think the following code fragments in the ioctl function of the VME driver
simply prevent normal users from doing "bad" things:

                /* Is this the right capability to use ? Everybody seems
to use
                 * CAPS_SYS_ADMIN as a default to replace suser().
                 */
                error = -EPERM;
                if (!capable(CAP_SYS_ADMIN)) break;

Hope it helps,

Wolfgang.


jdweyer@rockwellcollins.com wrote:

>(disregard prior email; subject was not included)
>
>Greetings,
>
>We are using Linux version 2.2.12 with Gabriel Paubert's patches for the
>Motorola MVME2600 platform.   I have
>my application working opening /dev/vme and then doing ioctl calls to set
>the attributes.  It works
>fine only when I am root.  When another user tries to run the application,
>the ioctl (not the open) fails.
>I have changed the permissions of /dev/vme to rw for all (ugo) and have
>even gone as far as
>changing ownership and group to the user's instead of root, but to no
>avail.  The permissions
>of /dev/vme are crwxrwxrwx.  I realize the execute (x) permission is
>ineffective, but I'm trying everything.
>
>Do you have any ideas of what to try?
>
>Thanks for any help you can provide,
>
>JoAnna Weyer
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
