Message-Id: <199906102256.AAA01670@mitra.phys.uit.no>
To: Ryan Nielsen <ran@krazynet.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for dmasound bug 
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
In-reply-to: Your message of "Wed, 02 Jun 1999 13:05:09 PDT."
             <19990602130509.A269@gondolin>
Date: Fri, 11 Jun 1999 00:56:26 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



OK, this reply comes a bit late, but I didn't try the patch
until now, so here goes:

Ryan Nielsen:
>
>This restores the rate/byteswap to normal after playing a beep
>if you for example stop timidity, make a beep, resume, the sound
>will be slower than normal (without this patch).

Although this patch might do what it was intended for, it has some
unwanted consequences on the PowerBook G3 Series, namely that one gets a
constant, really annoying hiss from the loudspeakers, most notably
during the boot sequence.  Without this patch, the hiss stops after a
system beep (like when you do an "echo ^G" in a shell), but now even
this does not help.  So, if this patch is included in the standard
distribution, I suspect we will hear a lot of complaints from PowerBook
G3 users.

To me, it seems like there is something wrong in the dmasound driver
that causes this hiss; it just doesn't switch off all sound when it's
supposed to.  I don't know enough about the workings of the audio
controller to go bug hunting here myself, so all I can do is just point
out that there is a problem here :(

>--- linux/drivers/sound/dmasound.c	1999/02/05 05:45:42	1.41
>+++ linux/drivers/sound/dmasound.c	1999/06/02 19:42:08
>@@ -3255,6 +3255,11 @@
> 	save_flags(flags); cli();
> 	if (beep_playing) {
> 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
>+		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
>+		out_le32(&awacs->control,
>+			 (in_le32(&awacs->control) & ~0x1f00)
>+			 | (awacs_rate_index << 8));
>+		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
> 		beep_playing = 0;
> 	}
> 	restore_flags(flags);



aLViN
-- 
:r .signature

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
