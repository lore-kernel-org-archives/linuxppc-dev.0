Date: Thu, 21 Jan 1999 12:58:11 +0100
To: Martin Costabel <costabel@wanadoo.fr>, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: pre8(vger) kills button 3 on 1-button mouse
Message-Id: <19990121125811.027884@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 21, 1999, Martin Costabel <costabel@wanadoo.fr> wrote:

>The latest changes for 2-to-4-button mice on vger in
>drivers/macintosh/mac_keyb.c (rev 1.24) break the emulation of button 3
>on my 1-button Apple adb mouse.
>
>This happens both in Xpmac, where option_right+click is hard-coded to
>button 3, and in XF68_FBDev, where I use a patch by Franz Sirl for the
>adb_buttons kernel command to get the same effect.
>
>The reason seems to be that in rev 1.24 option_right gets mapped to
>option_left even in raw mode (same for ctrl, BTW). I don't understand
>this from the code, which is too complicated for me, anyway, but from
>looking at the effect, as witnessed by xev in Xpmac, for example.
>
>For the moment, I went back to rev 1.23 which doesn't have this problem.

I removed most of my patches to mac_keyb.c before submitting them, I was
pretty sure I didn't break anything, but I was probably wrong. I'll have
a look at it as soon as I manage to get this vger tree (today probably)
and submit a new patch.

Here, I have rewritten most of the buttons handling in console and
buttons emulation, but my new version is not ready and was not included
in the patches I sent to Cort. I just checked my patches, and they should
not change anything to buttons emulation. I'll test all this later today.
Thanks for pointing this out.

Ah yes, could you send me a dmesg log ? I would like to soo how your
mouse was recognized at startup.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
