Date: Thu, 4 Apr 2002 21:47:39 +0200
From: Albrecht Dre? <albrecht.dress@arcor.de>
To: Linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Awacs Burgundy sound w/ 2.4.18?
Message-ID: <20020404194739.GE30247@regulus>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I already posted this to the users list, but apparently nobody had a
solution...]

I upgraded an old rev. 1 iMac (bondi blue) to 2.4.18 from kernel.org, and
this somehow broke sound support. Everything used to work with
2.2.17pre-something, and the *same* mixer/xmms/cd player config now stays
silent on both the headphones and the built in speakers; even the console
beep doesn't work. Also, it is not possible to change any settings using
aumix or any other mixer program (xmixer, gmix).

I add some further information below and hope that somebody can give me
hints to resolve the problem. Any help is really welcome!!!

Thanks in advance,

	Albrecht.


~~~~~~~~~~

The dma sound driver is built into the kernel, and it is recognised upon
startup (2.4.18 from kernel.org, built w/ gcc 2.95.3). However, I got the
same results with the sound stuff built as modules:

-----
PowerMac Burgundy  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default
-----

Roughly the same kernel config works with an Awacs PowerMac 7300 (seems as
if a have a collection of old machines ;-)).

The output of /dev/sndstat looks a little strange to me:

-----
[root@island /root]# cat /dev/sndstat
PowerMac Burgundy DMA sound driver rev 016 :
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
44100 s: s/sec
HW AFMTS: signed 16 bit BE signed 16 bit LE
                  === Formats & settings ===
Parameter                 soft                hard
Format   :    signed 16 bit LE    signed 16 bit BE
Samp Rate:         44100 s/sec         44100 s/sec
Channels :                mono              stereo
                  === Sound Queue status ===
Allocated: Buffers  Size
     write:       4 32768
      read:       0     0
Current  : MaxFrg FragSiz MaxAct Frnt Rear Cnt RrSize A B S L  xruns
     write:      4    4096      4    0   -1   0      0 0 0 0 0      5
      read:      0       0      0    0    0   0      0 0 0 0 0      0
-----

Finally, here is the constant output of aumix (== any attempt to change
settings is ignored silently):

-----
[root@island /root]# aumix -q
vol 100, 100
speaker 0, 99
line 100, 100, P
mic 0, 0, P
cd 100, 100, P
pcm2 76, 0
-----


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Albrecht Dreﬂ  -  Johanna-Kirchner-Straﬂe 13  -  D-53123 Bonn (Germany)
        Phone (+49) 228 6199571  -  mailto:albrecht.dress@arcor.de
_________________________________________________________________________

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
