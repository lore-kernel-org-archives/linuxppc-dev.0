From: xuwentao@cn.ibm.com
To: frowand@mvista.com, benb@m2tech.co.nz
cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <4825691B.00152176.00@d73mta06.au.ibm.com>
Date: Thu, 13 Jul 2000 09:50:30 +0800
Subject: Re: Why eth0 does not work
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Currently I only modify ppc4xx_pic_init() to init IRQ 20 and 26, which is
used by
ttys00 and eth0. That error occurs because my CPU is a ppc401 not a 405gp.

I have exported /opt/hardhat/devkit/ppc/8xx/target_ftest4 according
instructions from
mvista. The output is broken into 2 lines.

BTW, I disabled the loopback in the config file, and the msg "lo is down'
still
appears.

I start the tcpdump at the server, I found that the server recieved many
ARP packets
issued from the linux box(7.1.1.5) looking for the server(7.1.1.21). It
seems that
the box can not resolve 7.1.1.21 (can not read MAC addr, as Ben said).

Xu Wentao
IBM China Research Lab
Tel:          (86-10)  62986677-216
Internet:    xuwentao@cn.ibm.com


Frank Rowand <frank_rowand@mvista.com> on 2000-07-13 06:15:13 AM

Please respond to frowand@mvista.com

To:   Wentao Xu <xuwentao@yahoo.com>
cc:   linuxppc-embedded@lists.linuxppc.org (bcc: Wen Tao Xu/China/IBM)
Subject:  Re: Why eth0 does not work





Wentao Xu wrote:
>
> Hi, everyone,
> I am porting the linux code from mvista to IBM redwood
> board. Now it seems like the eth0 is not registered
> because the NFS uses loopback device. Who can give me
> an idea? Thanks in advance.
>
> the output is
> -----------------------------------------------------
> Linux version 2.3.39 (xwt@stb_dev) (gcc version 2.95.2
> 19991024 (release)) #393
> Wed Jul 12 17:02:16 CST 2000
> walnut_setup_arch()
> ----------  progress:  0x3eab arch: exit
> On node 0 totalpages: 00001800
> zone(0): 6144 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.

> ERROR: ppc4xx_pic_init() detected wrong PVR_VER

I don't know what changes you have made to ppc4xx_pic_init(), make sure you
have
initialized the pic correctly.


>
> -----  in walnut_calibrate_decr()
>
>   bip:
>
>     bi_s_version      1.3
>     bi_r_version      1.13
>     bi_memsize        0x1800000
>     bi_enetaddr       123456-7890ab
>     bi_pci_enetaddr   000002-f34f60
>     bi_procfreq       0x2f34f60
>     bi_plb_busfreq    0x4e800021
>     bi_pci_busfreq    0x0
>
> Calibrating delay loop... 49.25 BogoMIPS
> Memory: 22704k available (800k kernel code, 580k data,
> 48k init) [c0000000,c1800
> 000]
> Buffer-cache hash table entries: 1024 (order: 0, 4096
> bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768
> bytes)
> POSIX conformance testing by UNIFIX
> ----------  progress:  0xffff
> Linux NET4.0 for Linux 2.3
> Based upon Swansea University Computer Society
> NET3.039
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind
> 4096)
> Starting kswapd v1.6
> tty_init() -- calling rs_init()
> Serial driver version 4.91 (1999-11-17) with no serial
> options enabled
> ttyS00 at 0x0000 (irq = 20) is a 16550A
> tty_init() -- returned from rs_init()
> RAMDISK driver initialized: 16 RAM disks of 4096K size
> 1024 blocksize
> eth0: National DP83902AV at 12:34:56:78:90:ab, found
> at 0xf1400000, using IRQ 26
> .
> Looking up port of RPC 100003/2 on 7.1.1.21
> Device lo is down.
> Device lo is down.
> Device lo is down.
> Device lo is down.

I have seen similar messages when the driver for eth0 was not registered or
not working properly.


> portmap: server 7.1.1.21 not responding, timed out
> Root-NFS: Unable to get nfsd port number from server,
> using default
> Looking up port of RPC 100005/1 on 7.1.1.21
> Device lo is down.
> Device lo is down.
> Device lo is down.
> Device lo is down.
> portmap: server 7.1.1.21 not responding, timed out
> Root-NFS: Unable to get mountd port number from
> server, using default
> Device lo is down.
> Device lo is down.
> Device lo is down.
> Device lo is down.
> mount: server 7.1.1.21 not responding, timed out

> Root-NFS: Server returned error -5 while mounting
> /opt/hardhat/devkit/ppc/8xx/ta

But this may indicate that you actually were communicating with the server
over ethernet???  I haven't looked up NFS error -5.  What does it mean?
Is it something as simple as needing to export your root files system
("/opt/hardhat/devkit/ppc/8xx/ta") on your host system?  Did you mis-type
the path of the root file system in the command line passed to the linux
kernel or is the path just truncated in the error message?


> rget_ftest4
> VFS: Unable to mount root fs via NFS, trying floppy.
> request_module[block-major-2]: Root fs not mounted
> VFS: Cannot open root device 02:00
> Kernel panic: VFS: Unable to mount root fs on 02:00
> Rebooting in 180 seconds..
> -------------------------------------------------------
>
> Wentao
>

--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
