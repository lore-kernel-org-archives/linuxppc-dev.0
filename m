Date: Tue, 8 Aug 2000 18:19:47 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
Message-ID: <Pine.SOL.4.10.10008081713340.9223-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, my Pismo which was increasingly unstable this weekend
is now refusing to boot even from the MacOS CD's. So I probably
won't be able to work on this for at least a few days. I'm
hoping it will boot after having the battery out a few hours
(it worked a couple times this weekend) and that
reinitalizing the firmware and MacOS partitions will help,
if that or a full disk initialization doesn't help it will
probably be off to the shop.

But, just before it powered itself off last night, I found
the likely cause of the abends from the xmms_CdRead plugin.
It's actually in the xmms package code in ~/xmms/input.c. I
don't have the sources available, but can describe the
problem for anyone who's interested in trying to fix it.

There is a routine near the top of the file that uses GTK
byte swapping macros to perform the LE to NE conversion.
The problem is the classic macro mistake of passing
complex expressions with side effects as macro parms. In
this case it's of the form something like (this is from
memory):

  left[i] = GINT16_FROM_LE( (*ptr++) );
  right[i] = GINT16_FROM_LE( (*ptr++) );

The macro expands to use the argument several times
(see the *SWAP* macros in glib.h), so the pointer is
incremented too many times causing a seg fault. The
non-optimized case just happened to have enough readable
memory following the buffer to not fault (and optimizations
on the loop probably had impacts as well), similarly the
.wav player plugin uses a different buffering scheme that
just accidentally avoids faults (likewise the x86 was probably
lucky due to different run-time conditions, provided the
MACRO doesn't simply end up a NOP).

The fix is to find all such occurences and do the incrementing
outside the macro call. I think I've seen similar code in other
parts of the package, so a general inspection is in order. This
should also fix the visualization displays and make the xmms_CdRead
plugin usable for the analog CD challenged Macs.

Good Luck,
Henry


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
