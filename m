Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FA5235B.7080007@iti.fi>
Date: Sun, 02 Nov 2003 17:31:39 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage continued
References: <3FA4F3B2.6050106@iti.fi> <3FA50B32.4010400@iti.fi>
In-Reply-To: <3FA50B32.4010400@iti.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kate Alhola wrote:

>
>
> and in this case the mgt5100_tty.c look a like have one dependence
> to ppcboot, it took the ibp bus clock frequency from ppcboot bd struct
> even
> not ppc-boot configuration. I replaced it with just plain #define .
> Now just i should do testing ...


I just fixed it by comenting out setting baudrate, then it will leave it as
it was after dBug. Now i get kernel booting up and initial strings
coming out
but kernel crashes after initMMU ( early boot prit enabled ),
I think that i have something wrong in .config.
I did not find goog example gor 5200lite from denx tree so i made
my best quess and it seems not to bee so good.


Kate
-- continues hacking ....

dBUG> dn -i zImage.icecube
Address:  0x00020000
Downloading Image 'zImage.icecube' from 195.218.81.140
..............
939645 bytes read via TFTP
dBUG> go 20000
loaded at:     00020000 001071B8
relocated to:  00800000 008E71B8
zimage at:     00805830 008E3C88
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel
id mach(): doneMMU:enterMMU:hw initMMU:mapin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
