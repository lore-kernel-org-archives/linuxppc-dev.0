Message-ID: <DBF73ACB70D3D711A358000BDBACF5CE09D254@SSMAIL1>
From: Kiran Mandava <kiran.mandava@skystream.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ep8260 board linux port serial port problem
Date: Mon, 5 Jan 2004 09:47:08 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

  I am trying to port linux2.4.22 on to ep8260 board. U-boot tftps the image
and then starts loading linux.
the last few lines on the console show this

RAMDISK driver initialized: 16 RAM disks of 50000K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1367k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 44k init

tty_io.c: process 1 (swapper) used obsolete /dev/ttyS0 - update software to
use
/dev/ttyS0



    after this somewhere down the line the CPU gets an exception and
spinning in the panic function,(i know it is too little of information
but..) could someone  suggest what could  be happening here, could it be
related to the last message on the console, any sugestions would be greatley
appreciated.



thanks,
kiran



>-----Original Message-----
>From: Kiran Mandava [mailto:kiran.mandava@skystream.com]
>Sent: Tuesday, December 30, 2003 9:11 AM
>To: linuxppc-embedded@lists.linuxppc.org
>Subject: ep8260 board linux port serial port problem
>
>
>
>Hello All,
>
>	I am trying to bringup linux 2.4.22 on ep8260 board. i have the
>U-boot running fine. while booting the linux kernel the
>execution path is
>looping in serial_console_write(verified it thr'u JTAG).SMC1
>is configured
>as the console.
>
>      For the SMC port the code is setting up the proper Rx/Tx
>descriptors
>in the on chip DPRAM and it tries to use the actual buffers
>from the RAM (on
>the 6xx bus in this case) the code loops in the
>serial_console_write, but if
>i change the actual buffers to be from the on chip DPRAM
>itself the serial
>port works fine.(I guess this is how it is done in the U-boot too)..did
>someone face the similar probelm, any sugestions would be greately
>appreciated.
>
>      RAM seems to be working fine, as the code gets relocated
>properly to
>RAM and executes from there.
>
>
>
>
>thanks
>kiran
>
>
>
>>-----Original Message-----
>>From: Kiran Mandava [mailto:kiran.mandava@skystream.com]
>>Sent: Thursday, December 18, 2003 11:44 AM
>>To: linuxppc-embedded@lists.linuxppc.org
>>Subject: ep8260 board linux port
>>
>>
>>
>>Hello All,
>>
>>  I am trying to port linux 2.4.22 onto ep8260 board. (256 MB
>>RAM on 6xx
>>bus/ 32 MB Flash) using tools and source code from denx webisite.
>>  I was able to port u-boot and trying to boot linux now.
>>  i couldn't find any specific files to this board in the
>>platform directory
>>although est8260.h file has the basic bd structure. the
>>problem i am facing
>>is the processor loops in serial_console_write/ timer
>>interrupt handler. i
>>made sure that i am passing the baudrate proeprly by looking at the bd
>>structure while passing teh control to start_kernel function.
>>  My console does display everything properly running u-boot
>>but once the
>>control goes to linux don't see anything on the console.
>>
>>i made only the following changes for th elinux boot.
>>	1. in uart.c made sure that the console port is defines as SMC1.
>>	2. defines the SMC2 to be serial port too
>>      3. FCC3 is configured as the ethernet.
>>
>>and compiled and tried to boot the image, but i couldn't. i do
>>have a BDI
>>JTAG device and i was able to see the RAM properly.
>>
>> could some one throw light on what i could be doing wrong,
>>any sugestions
>>are greatley appreciated. I bet some one would have done this
>>sucessfully
>>years before..
>>
>>
>>
>>
>>thanks,
>>kiran
>>
>>
>>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
