Return-Path: <gil-ad@myrealbox.com>
Received: from sa3.bezeqint.net (sa3.bezeqint.net [192.115.104.17])
	by ozlabs.org (Postfix) with ESMTP id EAA136881C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 11:40:26 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by sa3.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP id ED67733DB2 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 01:58:16 +0200 (IST)
Received: from sa3.bezeqint.net ([127.0.0.1])
	by localhost (sa3 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 11229-09 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 01:58:14 +0200 (IST)
Received: from [10.0.0.2] (unknown [82.80.62.95])
	by sa3.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 01:58:14 +0200 (IST)
From: Gil Madar <gil-ad@myrealbox.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Tue, 29 Nov 2005 01:47:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200511290147.05220.gil-ad@myrealbox.com>
Subject: Problem running kernel 2.6.14 (DENX) on MPC866
Reply-To: gil-ad@myrealbox.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I load linux from u-boot, and manage to go all the way until the call to cpu_idle() from rest_init().
The system claims mounts a root file system over NFS. Sniffer logs and host logs support this claim.
If I do a while ( 1 ) printk( whatever ), just before cpu_idle(), the system continues to run.
If I let it call cpu_idle(), the system hangs.
If I powercycle the board, I see many occurences of exceptions in the log_buf. They all claim there has
been an access to an invalid address as in "<4>Oops: kernel access of bad area, sig: 11".

The exceptions are never printed and the 'bad address' is offset 0x1C from the IMMR. The access
is from m8xx_get_irq(). 
Has anybody else faced similar problems?
Note: I had to workaround the 
 ppc_md.set_rtc_time  = m8xx_set_rtc_time;
 ppc_md.get_rtc_time  = m8xx_get_rtc_time;
initialisations in m8xx_setup.c.
What additional modifications are needed for the MPC866?
Is there something broken in my setup?
Is there a need for additional information?
As I'm doing this without an emulator, I appreciate any ideas.

Thanks for your time. I appreciate any response,
Gil

Here is a log of the run.


U-Boot 1.1.3 (Nov 22 2005 - 00:26:43)

CPU:   unknown MPC86x (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB D-Cache FEC present
         *** Warning: CPU Core has Silicon Bugs -- Check the Errata ***
Board: IDU()
DRAM:  16 MB
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
Monitor Command Prompt:>setenv gatewayip 10.0.0.138;setenv ethaddr 00:01:02:03:04:05; setenv console ttyCPM0,38400n8; setenv
 ipaddr 10.0.0.4;setenv serverip 10.0.0.2;setenv hostname idu;setenv netmask 255.0.0.0; setenv rootpath /mnt/iso1
Monitor Command Prompt:>setenv bootargs root=/dev/nfs  rw nfsroot=$(serverip):$(rootpath) console=$(console) ethaddr=$(ethad
dr)  ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off
Monitor Command Prompt:>tftpboot 600000 uImage
Using FEC ETHERNET device
TFTP from server 10.0.0.2; our IP address is 10.0.0.4
Filename 'uImage'.
Load address: 0x600000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ####
done
Bytes transferred = 1350694 (149c26 hex)
Monitor Command Prompt:>bootm 600000
## Booting image at 00600000 ...
   Image Name:   Linux-2.6.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1350630 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F9DBB0 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF90
memstart    = 0x00000000
memsize     = 0x01000000
flashstart  = 0x00000000
flashsize   = 0x00000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0x0F000000
bootflags   = 0x00000001
intfreq     =    133 MHz
busfreq     = 66.500 MHz
ethaddr     = 00:01:02:03:04:05
IP addr     = 10.0.0.4
baudrate    =  38400 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Linux version 2.6.14 (xxxx@yyyy) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-10)) #44 Tue Nov 29 00:41:34 IST 2005
Built 1 zonelists
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.2:/mnt/iso1 console=ttyCPM0,38400n8 ethaddr=00:01:02:03:04:05 ip=10.0.0
.4:10.0.0.2:10.0.0.138:255.0.0.0:idu::off
PID hash table entries: 128 (order: 7, 2048 bytes)
Decrementer Frequency = 498750000/60
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 13084k available (2364k kernel code, 656k data, 84k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
NTFS driver 2.1.24 [Flags: R/W].
JFS: nTxBlock = 102, nTxLock = 819
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf000a80 (irq = 20) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
eth0: FEC ENET Version 0.2, FEC irq 3, addr 00:01:02:03:04:05
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=10.0.0.4, mask=255.0.0.0, gw=10.0.0.138,
     host=idu, domain=, nis-domain=(none),
     bootserver=10.0.0.2, rootserver=10.0.0.2, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.2
Looking up port of RPC 100005/1 on 10.0.0.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 84k init

---------here the system hangs ----------------- 
