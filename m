Message-ID: <3ACD0B76.982B66F2@ncal.verio.com>
Date: Thu, 05 Apr 2001 17:19:02 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: iain@sandoe.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: DMASOUND->rev6 (2.4.3)(attn: Xine, MOL, PowerComputing, ibook,
 Tumbler)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Applied to 2.4.3-benh, it is still reporting back 48K.
>From the new /dev/sndstat it looks like it is trying to
resample, but if it is, it is doing a terrible job. But,
it falls so far behind and drops pitch enough, that
it still must not be resampling above 44.1K. I don't
see anything in the patches that would change the
old behavior, did Paulus' fix get lost?

Xine will resample just fine if the device would
simply respond back to the SNDCTL_DSP_SPEED that 44.1K
was set instead of 48K. There is no need to extend kernel
resampling to 48K, any apps broken in this regard are
going to be broke on many x86 platforms.

In case I've got the wrong level:

PowerMac (AWACS rev 3 [screamer])  DMA sound driver rev 016 installed
Core driver edition 01.05 : PowerMac Built-in Sound driver edition 00.05
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default

/dev/sndstat :

PowerMac (AWACS rev 3 [screamer]) DMA sound driver rev 016 :
Core driver edition 01.05 : PowerMac Built-in Sound driver edition 00.05
		 === Formats & settings ===
Parameter                 soft                hard
Format   :    signed 16 bit BE    signed 16 bit BE
Samp Rate:         48000 s/sec         44100 s/sec
Channels :              stereo              stereo
		 === Sound Queue status ===
Allocated: Buffers  Size
    write:       4 32768
     read:       0     0
Current  : MaxFrg FragSiz MaxAct Frnt Rear Cnt RrSize A B S L  xruns
    write:      4    7528      4    0   -1   0      0 0 0 0 0      0
     read:      0       0      0    0    0   0      0 0 0 0 0      0

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
