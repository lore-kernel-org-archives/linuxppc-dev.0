Message-ID: <374E372F.25549C60@jlc.net>
Date: Fri, 28 May 1999 02:26:55 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: G3 sound recording
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just updated the PowerPC Mac dmasound driver so it will also
record.  It still needs some work, but the framework is there
for anyone to update and it is useful.

I did the development on my PowerBook G3, and will soon test it
on my iMac.

The driver supports the standard sample rates and the signed/unsigned
8- and 16-bit PCM data format.  It does not support A-law or u-law
because I have not yet taken the time to integrate the conversion
algorithm.

To the mixer read/write recording source I added the SOUND_MASK_MONITOR
because the AWACS has the "loop through" capability.  When this is
set, along with your recording input selection, the audio input
will be sent to your selected audio output (along with giving you
the data).  This is the way the audio CD players work, so if you
turn this off don't be surprised when an audio CD program may not
play.  If this was not the right mask to use for this purpose, will
someone with more knowledge please tell me what is correct.

The driver runs full duplex, you can play and record at the same
time.  In fact, I tested it this way with a loop back program.
Multiple threads and an extra slop buffer help out here.

I left plenty of things for others to do :-).  Also, be careful
when requesting data formats.  The driver will report more than
are supported by the recording side, since it can also play A-law
and u-law.  I don't know the "right" thing to do here, since there
is only one method to get formats (I know, fix the record side :-).


Thanks to everyone that helped out, including the folks that started
the work and to Paul for the documentation.

Now, back to the 8xx and 82xx updates.......


Have fun.


	-- Dan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
