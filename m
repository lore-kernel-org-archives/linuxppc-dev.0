Message-ID: <39A54154.E02B3E0C@ncal.verio.com>
Date: Thu, 24 Aug 2000 08:37:56 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: iain@sandoe.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re:[RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain,

(Iain, you may have recieved an earlier version of this, it bounced
on a typo in the maillist addr, so I'm resending with some additions)

My Pismo is back from the shop (bad I/O logic board) and Linux
reinstalled. I've applied the dmasound backport to
linux-2.2.217pre19-ben1. There were a couple of simple typos, I
think I've seen them mentioned before but let me know if you want
the diffs.

First the good news:

More recent verisons of esound (looks like those with ALSA changes)
have had some sort of buffering problem were they would skip blocks
during playback (with both esdplay and XMMS esd output plugin). The
blocks that played were at the correct speed, but the
track/sample would playback as quick as it could be read off
storage. The backport corrects,  or perhaps covers-up, the problem. I
need to investigate the root cause some more.

With the old driver it was impossible to use the modem while
playing back CD's, throughput would drop to zero. Now there is
little if any impact and the CPU load is cut significantly
(this is with, and without, irq unmasking enabled for the DVD
in both cases).

However, on the Pismo it looks like that in additional to the LE
modes not being set, as previously discussed, the 8bit mode and rate
parms are also not getting set in the Screamer. The RAW_AFMT_S8_S_44K
sample sounds like Alvin and the Chipmonks and the lower rate samples
are just high-speed jibberish. Here's the stest ouput for a couple:

 [henry@osprey stest]$ ./stest -f AFMT_S16_LE_S_44K.wav
  /dev/dsp Capabilities : Rev 18
  DUPLEX : real-time : BATCH : co-proc : trigger : mmap
  /dev/dsp Supported Formats.
  MU-LAW : A-LAW : ima-adpcm : U8 : S16-LE : S16-BE : S8 : U16-LE :
U16-BE : mpeg-2
  /dev/dsp current settings <  AFMT_S16_BE : STEREO : >
  /dev/dsp now set to :   AFMT_S16_BE :  STEREO :
  SAMPLINGRATE=44100
  fragment parameter = 00020009
  OSS BUFFERS: fragments=2  fragment size=512  total buffer size=1024
  buffer latency=5.804989 ms

[henry@osprey stest]$ ./stest -f RAW_AFMT_S8_S_44K
  /dev/dsp Capabilities : Rev 18
  DUPLEX : real-time : BATCH : co-proc : trigger : mmap
  /dev/dsp Supported Formats.
  MU-LAW : A-LAW : ima-adpcm : U8 : S16-LE : S16-BE : S8 : U16-LE :
U16-BE : mpeg-2
  /dev/dsp current settings <  AFMT_S16_BE : STEREO : >
  /dev/dsp now set to :   AFMT_S16_BE :  STEREO :
  SAMPLINGRATE=44100
  fragment parameter = 00020009
  OSS BUFFERS: fragments=2  fragment size=512  total buffer size=1024
  buffer latency=5.804989 ms
finished
[henry@osprey stest]$ ./stest -f SUN_AFMT_A_LAW_M_11K
  /dev/dsp Capabilities : Rev 18
  DUPLEX : real-time : BATCH : co-proc : trigger : mmap
  /dev/dsp Supported Formats.
  MU-LAW : A-LAW : ima-adpcm : U8 : S16-LE : S16-BE : S8 : U16-LE :
U16-BE : mpeg-2
  /dev/dsp current settings <  AFMT_S16_BE : STEREO : >
  /dev/dsp now set to :   AFMT_S16_BE :  STEREO :
  SAMPLINGRATE=44100
  fragment parameter = 00020009
  OSS BUFFERS: fragments=2  fragment size=512  total buffer size=1024
  buffer latency=5.804989 ms
finished
[henry@osprey stest]$ ./stest -f SUN_AFMT_MU_LAW_M_8K
  /dev/dsp Capabilities : Rev 18
  DUPLEX : real-time : BATCH : co-proc : trigger : mmap
  /dev/dsp Supported Formats.
  MU-LAW : A-LAW : ima-adpcm : U8 : S16-LE : S16-BE : S8 : U16-LE :
U16-BE : mpeg-2
  /dev/dsp current settings <  AFMT_S16_BE : STEREO : >
  /dev/dsp now set to :   AFMT_S16_BE :  STEREO :
  SAMPLINGRATE=44100
  fragment parameter = 00020009
  OSS BUFFERS: fragments=2  fragment size=512  total buffer size=1024
  buffer latency=5.804989 ms
finished

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
