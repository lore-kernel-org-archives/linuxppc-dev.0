Date: Thu, 29 Nov 2001 14:39:25 -0500
From: "Henry A. Leinhos" <leinhosha@npt.nuwc.navy.mil>
Subject: sound input from /dev/dsp
To: linuxppc-dev@lists.linuxppc.org
Message-id: <3C068EED.6050105@npt.nuwc.navy.mil>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm writing an application that writes to and reads from the sound
device (/dev/dsp), and have been having some trouble with  the Burgundy
input sound device driver (the sound  out seems to work fine).  I can
run the same application on a machine with the Screamer (i.e. dual G4)
sound device without any trouble, but reading the burgundy device gives
me nothing but zeros.

When I read from /dev/dsp, I notice that I'm getting interrupts, and the
read returns data, but the data are all zeros. I get the same behavior
when using an application like grecord (I get data, but they're all zeros).

I'm currently using Kaoru Fukui's 2.4.8-pre1_0a, compiled on a single
cpu B&W G3 (400MHz), as well as a dual G4 (400MHz w/SMP).

I've tried compiling Kaoru's 2.4.10 kernel, but have been having some
boot-up issues.  Before I rsync to any more current tree, is there
something I'm doing that's obviously wrong?


Thanks in advance,
Henry

-----------------------------------------

Background (burgundy machine):

(cat /proc/cpuinfo)

processor    : 0
cpu        : 750
temperature     : 0 C
clock        : 400MHz
revision    : 130.1 (pvr 0008 8201)
bogomips    : 796.26
zero pages    : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine        : PowerMac1,1
motherboard    : PowerMac1,1 MacRISC Power Macintosh
L2 cache    : 1024K unified
memory        : 384MB
pmac-generation    : NewWorld

(cat /dev/sndstat)

PowerMac Burgundy DMA sound driver rev 016 :
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.06
44100 s: s/sec
HW AFMTS: signed 16 bit BE signed 16 bit LE
         === Formats & settings ===
Parameter                 soft                hard
Format   :    signed 16 bit BE    signed 16 bit BE
Samp Rate:         44100 s/sec         44100 s/sec
Channels :              stereo              stereo
         === Sound Queue status ===
Allocated: Buffers  Size
    write:       4 32768
     read:       4 32768
Current  : MaxFrg FragSiz MaxAct Frnt Rear Cnt RrSize A B S L  xruns
    write:      4   32768      4    0   -1   0      0 0 1 0 1      1
     read:      4   32768      4    3    2   0      0 1 1 0 1   2576


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
