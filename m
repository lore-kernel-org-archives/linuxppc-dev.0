Date: Mon, 28 Feb 2000 02:29:42 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc
 with r128
In-Reply-To: <v03110700b4dd777b032a@[209.183.136.166]>
Message-ID: <Pine.LNX.4.21.0002280213230.19278-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Feb 2000, Kevin B. Hendricks wrote:

 Thats the responces i got back from the xfree list about the usb mouse
problems in 3.9.18, the bit about drivers/usb/mouse.c not setting the
the bit 3 correctly in the first data byte seems intresting, maybe the
problem is in our side ?

  Kostas

----------------------------------------------------------------------

>From yokota@zodiac.mech.utsunomiya-u.ac.jp Mon Feb 28 02:12:31 2000
Date: Sat, 26 Feb 2000 16:22:32 +0900
From: Kazutaka YOKOTA <yokota@zodiac.mech.utsunomiya-u.ac.jp>
Reply-To: devel@XFree86.Org
To: devel@XFree86.Org
Cc: yokota@zodiac.mech.utsunomiya-u.ac.jp
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc
     with r128 (fwd)

linuxppc doesn't have the PS/2 mouse port, does it?  Then, why do they
want to use the IMPS/2 protocol on the linuxppc machine?  If they are
trying to use the USB version of IntelliMouse, they shouldn't be needing
IMPS/2.

Anyway, if they somehow do use the PS/2 version of the IntelliMouse on
the PS/2 mouse port...

We need to know exact model of his mouse.  Some mice are not very
compatible with the others.  I have genuine MS IntelliMouse,
IntelliMouse Explorer, Wheel Mouse, IntelliMouse Trackball, and they
are all fine with 3.9.18.  But, as there are quite a number of
slightly different models of IntelliMouse, there may be some which
aren't so compatible with the others.

He is talking about the IMPS/2 spec.  AFAIK, Microsoft has not
released the official document describing the IntelliMouse protocol.
If he has the official spec, I would like to see it.

In any case, does anybody else has IntelliMouse which worked in 3.9.17
or before, but not in 3.9.18?  We broke IMPS/2 support somewhere
around 3.9.17d and it wasn't (supposedly) fixed until 3.9.17Z.  I
would like to believe 3.9.18 is OK with IMPS/2.

# Aha, maybe their mouse driver is trying to emulate the IMPS/2
# protocol, and does not quite get it right...

>But according to my specs on IMPS/2 the first character has the following bina
>ry
>format:
>
>0b00xy0321  with xy indicating movement in positive x or y direction of mouse
>and 321 being the mouse buttons.  The later characters determine the dx, dy, a
>nd
>dz values.

The first byte from the original IBM PS/2 mouse is

   bit 7  Y overflow
       6  X overflow
       5  sign Y
       4  sign X
       3  always 1
       2  always 0 (many 3 button PS/2 mouse uses this bit to indicate
          the middle button status)
       1  right butten
       0  left button

There have been some mice which do NOT set the bit 3, or use it
for other purposes.  But, IntelliMouse seem to always set the bit 3...

I wonder what document he is referring to and how he obtained it...

Kazu

----------------------------------------------------------------------

>  Hmm, what version of LinuxPPC is this? That probably is an old, twitchy
>USB stack. There will be a new version released shortly which should be
>better. The old versions only did imps2.

Ok, old code may be buggy.

>Could the bit3 not getting set
>be an endian issue?

Absolutely not.  It is definitely a emulator issue.

[...]
>  I'll see about slapping together a linux-usb input driver this weekend.
>That should make everybody happier.

I had a quick glance at Linux input driver suite 0.4.4 by Voltech
Pavlik.  It appears that it emulates IMPS/2 all right in mousedev.c;
we can expect this driver will work with the XFree86 mouse code.

In contrast, Linux 2.3.29's original drivers/usb/mouse.c does NOT set
the bit 3 correctly in the first data byte.  People in the linux/PPC
mailing list must have complained because of this...

I don't have a Linux/PPC box or Linux/i386 box here.  So, I cannot
verify the above findings.  But, I believe I am not very badly beside the
mark.

Kazu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
