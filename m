Date: Fri, 17 May 2002 23:07:50 -0400 (EDT)
From: Jack Howarth <howarth@bromo.med.uc.edu>
Message-Id: <200205180307.XAA10288@bromo.msbb.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: alsa recording
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


    For anyone interested, the current alsa cvs now has working
audio recording. At least on a Powermac G4/AGP with screamer chipset.
You will need to have alsa-drivers, alsa-libs and alsa-utils built
and installed from the cvs. Also make sure you have mic boost in alsamixer
set to 0 or you will easily overload you inputs while recording.
    I have confirmed that recording works with both the alsa and oss
compatibility interfaces. To test the alsa interface the following works...

make a .asoundrc in your home dir with...

pcm.copy {
  type plug
  slave {
  pcm hw
  }
  route_policy copy
}

and record with...

arecord -d 10 -f cd -t wav -D copy foobar2.wav

which can be played back with...

aplay -c 2 -t raw -r 44100 -f mu_law foobar2.wav

I have also confirmed the oss recording/playback using the
'snd' scheme based sound editor program that uses oss. I was
able to record 1 and 2 channel wav recordings with that.
Of course all of the above was done with the esd daemon killed.
There have been a slew of updates for Tumbler so it may work
as well. Good luck.
                          Jack


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
