From: Ryan Nielsen <ran@krazynet.com>
Date: Wed, 2 Jun 1999 13:05:09 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: patch for dmasound bug
Message-ID: <19990602130509.A269@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This restores the rate/byteswap to normal after playing a beep
if you for example stop timidity, make a beep, resume, the sound
will be slower than normal (without this patch).

--- linux/drivers/sound/dmasound.c	1999/02/05 05:45:42	1.41
+++ linux/drivers/sound/dmasound.c	1999/06/02 19:42:08
@@ -3255,6 +3255,11 @@
 	save_flags(flags); cli();
 	if (beep_playing) {
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
+		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
+		out_le32(&awacs->control,
+			 (in_le32(&awacs->control) & ~0x1f00)
+			 | (awacs_rate_index << 8));
+		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
 		beep_playing = 0;
 	}
 	restore_flags(flags);

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
