Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 9 Sep 2002 22:14:30 -0700
From: curt brune <curt@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: booting on embedded planet RPX_LITE-DW (823e)
Message-ID: <20020910051430.GA1543@lenin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

More news from the home front -- I have made some progress booting
this board, but still have some problems.

The big break through was how to execute a kernel image once
downlaoded via tftp.  With my default boot loader I can load an image
via tftp to any address. Typically I +load the image at 0x4000000 like
this:

>> Load using tftp via Ethernet
>> Enter server IP address <10.0.0.1> :
>>
>> Enter server filename   <ppc-zImage> :
>>
>> Enter (B)inary or (S)record input mode <S> : B
>> B
>> Enter address offset  : <00400000 hex> :
>>
>> .512.1024..2048....4096.
>> Total bytes = 2611354 in 7799788 uSecs
>> Loaded addresses 00400000 through 0067D899.
>> Start address = 00400000
>> >go 410000
>>
>> loaded at:     00410000 0067F210
>> relocated to:  00180000 003EF210
>> board data at: 003EC144 003EC160
>> relocated to:  003EC128 003EC144
>> zimage at:     00185950 00200389
>> initrd at:     00201000 003EBA4A
>> avail ram:     003F0000 01000000
>>
>> Linux/PPC load: console=/dev/ttyS00 root=/dev/ram

Note, however that I jump to 0x410000, not the 0x400000 where I loaded
the image.  A kind soul informed me that I had to start execution at
an offset of 0x10000 from where I load the image.  That really helped
me a lot, since trying to execute at 0x400000 would just hang at the go.

Does anyone know a reason for the 0x10000 offset?  Can you point me to
the documentation ?  Also what do the two columns of addresses mean in
the above output ?  Subsequent to this break through, however, I am
stuck at the "Linux/PPC load:" line.  The system just hangs here.  I
would have expected to see messages like:

>> Uncompressing Linux...done.
>> Now booting the kernel
>> Linux version 2.4.4 ....
>> .....

But I get nothing.  It is as if the uncompression code is not being
run.  Anyone have any ideas on how to get past this step?

I thought it might be my serial port is not configured properly.
Maybe the system is booting, but I'm not seeing anything over the
serial line.  In the documentation for my board it says the serial
port is SMC1 and the ethernet is SMC2.  In the kernel config I see
options for setting the ethernet to SMC1-SMC3, but I do not see
anything about setting the serial port to SMC1.  Could that be a
problem?

For the curious the docs for my board are located here:
http://www.embeddedplanet.com/pdf/docs/lite_um.pdf

Any ideas?

I do appreciate your time, really.  I'm doing this as a hobby --
nobody is going to get rich if I can get this board to boot :)

Cheers,
Curt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
