From: Ryan Nielsen <ran@krazynet.com>
Date: Fri, 11 Jun 1999 13:07:54 -0700
To: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for dmasound bug
Message-ID: <19990611130754.A67@gondolin>
References: <19990602130509.A269@gondolin> <199906102256.AAA01670@mitra.phys.uit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199906102256.AAA01670@mitra.phys.uit.no>; from Alvin Brattli on Fri, Jun 11, 1999 at 12:56:26AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alvin Brattli wrote:
> >This restores the rate/byteswap to normal after playing a beep
> >if you for example stop timidity, make a beep, resume, the sound
> >will be slower than normal (without this patch).
> 
> Although this patch might do what it was intended for, it has some
> unwanted consequences on the PowerBook G3 Series, namely that one gets a
> constant, really annoying hiss from the loudspeakers, most notably
> during the boot sequence.  Without this patch, the hiss stops after a
> system beep (like when you do an "echo ^G" in a shell), but now even
> this does not help.  So, if this patch is included in the standard
> distribution, I suspect we will hear a lot of complaints from PowerBook
> G3 users.

is this better?
--- dmasound.c	1999/02/05 05:45:42	1.41
+++ dmasound.c	1999/06/11 20:04:43
@@ -3255,6 +3255,11 @@
 	save_flags(flags); cli();
 	if (beep_playing) {
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
+		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
+		out_le32(&awacs->control, MASK_IEPC
+			 | (awacs_rate_index << 8) | 0x11
+			 | (awacs_revision < AWACS_BURGUNDY? MASK_IEE: 0));
+		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
 		beep_playing = 0;
 	}
 	restore_flags(flags);

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
