Message-ID: <01a301bfc629$393f1ee0$dc52df8d@oslo>
From: "SangTae Ha" <stha@postech.edu>
To: "Rodney Davies" <rodneyd@nulec.com.au>, <sungyeon@cosmo.etri.re.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <1072F1A27E99D3119747005004B9A38041580D@MAIL>
Subject: Re: How to load kernel on RPX Lite Board ?
Date: Thu, 25 May 2000 18:11:34 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you so much.

I used zsrec utility to build S-Record image.  Wonderful. It works!

screen shot is as follows,

================================================================
loaded at:     00200000 0020B1F4RAM : <8DDF522D>     : 8DDF52DC*
relocated to:  00100000 0010B1F4firmware chksum   O  On-board I/
board data at: 001001C4 001001E0): OK

relocated to:  00200100 0020011C  Program FLASH  : <vmlinux.srec
zimage at:     00206000 0022DF78
Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@enisei.postech.ac.kr) (gcc version 2.95.2 19991024 (r
elease)) #1 Thu May 25 15:56:27 KST 2000
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
remove_mem_piece: bad overlap [7a000,a6000) with [7b000, 1000000)
Memory: 15720k available (304k kernel code, 344k data, 16k init) [c0000000,c1000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
VFS: Cannot open root device 00:00
Kernel panic: VFS: Unable to mount root fs on 00:00
Rebooting in 180 seconds..
====================================================================


Could you telll me what's difference between powerpc-linux-objcopy and zsrec?
Can we burn this S-record file into flash memory insead of loading into memory?
Some changes needed, doesn't it?

what is next step?
I read LDP(Linux Documentation Project). There are many choices to mount root file system. NFS, initrd, ..? I really want to know how to mount root file system.

Thank you for your help.




----- Original Message -----
From: "Rodney Davies" <rodneyd@nulec.com.au>
To: "'???'" <stha@postech.edu>
Sent: Thursday, May 25, 2000 3:32 PM
Subject: RE: How to load kernel on RPX Lite Board ?


>
> > I want to load my kernel image into this board. To download
> > kernel image, The flash utility given by company needs
> > S-Record format. Actually, I do know about S-Record Format,
> > But I don't know how to make it.  I used Montavista-2.2.13
> > kernel and patched it. To build the kernel, I typed "make
> > zImage" and I got two files named "./vmlinux" and
> > "./arch/ppc/mbxboot/zImage" in the kernel directory.
> > After that,
> > #>powerpc-linux-objcopy -O srec vmlinux vmlinux.srec
> >
> > vmlinux.srec is created, "S-Record format"
> >
>
> you can use that, or use the /opt/hardhat/devkit/ppc/8xx/bin/zsrec program:
> './zsrec vmlinux > vmlinux.srec'
>
> > To download via ethernet, I installed tftpserver on my PC,
> > and working good.
> >
> > RPX Load menu: press 123456789T key : <?> : 7
> > Load using tftp via Ethernet
> > Enter server IP address <8DDF52DC> :
>
> So, the IP address of your tftp server is 141.223.82.220? Because that is
> the IP address you've specified above in HEX. You can change this through
> the "C  Configure EEPROM" option. This IP must be your tftp server's IP
> address (in HEX).
>
> To convert an IP to hex: eg:
> 192.168.0.89 converted is -
>
> 192 = C0
> 168 = A8
> 0 = 00
> 89 = 59
>
> Hence, C0A80059 == 192.168.0.89
>
> (See below on my output example from my RPXLite board...)
>
> > Enter server filename   <vmlinux.srec> :
> > Enter address offset  : <00000000 hex> :
> > ----
> >
> >
> > C0000390 [does not exist]
> > C00003A0 [does not exist]
> > C00003B0 [does not exist]
> > C00003C0 [does not exist]
> > C00003D0 [does not exist]
> > load_tftp(): ** E_RPX_DST_NOT_EXIST
> > 3072 data bytes, 62 S-records, 6 tftp blocks, 0 repeated blocks
> >
> > Could you tell me about how to download the kernel and root
> > file system onto my board. Maybe, Something wrong in my procedure.
> > I already read the instruction at
> > ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/getting_started.rpx
> > But I couldn't.
> >
> > I really thank you, in advance.
>
> Here's a snapshot of my MPC850/RPXLite board when downloading via tftp -
> (You should see something similar):
>
> RPX Load menu: press 123456789T key : <?> : 7
> Load using tftp via Ethernet
> Enter server IP address <C0A80059> :
> Enter server filename   <myzag> : myzah
> Enter address offset  : <00000000 hex> :
> Starting tftp download:
> inetARP(): OK
> .1.2.4.8.16.32.64.128.256.512.1024.2048.4096
> load_tftp(): OK
> 388970 data bytes, 4924 S-records, 760 tftp blocks, 0 repeated blocks
>
> Once you have successfully loaded your kernel into RAM, ensure that the
> start address is set to 0x0200000 (from Load Menu L, use '8 200000').
>
> Then to start the execution, type '9 YES'  <-- uppercase YES.
>
> Hope this helps.... let me know how you go.. :-)
>
> Cheers,
> Rod
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
