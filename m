Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23643@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: TFTP not able to find file???
Date: Sun, 2 Feb 2003 14:28:27 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

That was it. Thanks. I needed that sym link "ln -s . tftpboot" to get it to
work. Thanks a million.

Wolfgang Denk:

Might want to make a note to add that clip to section 3.2 "Configuration of
a TFTP Server" to the "PPCBoot and Embedded Linux Guide" as I don't recall
seeing it there.

-- Brian

-----Original Message-----
From: Wolfgang Grandegger [mailto:wolfgang.grandegger@bluewin.ch]
Sent: Sunday, February 02, 2003 5:10 PM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TFTP not able to find file???

Is the TFTP server started with the argument "-s"? Then do:

  $ cd /tftpboot
  $ ln -s . tftpboot

Hope it helps,

Wolfgang.


On 02/02/2003 10:56 PM brian.auld@adic.com wrote:
> All y'all must've been wondering why I hadn't posted with a problem yet
> today. Surprise!!
>
> Checklist for my embedded 'linux on ebony/440GP' project:
> ---------------------------------------------------------
> - cross tools working (check)
> - bootloader built (check)
> - bootloader installed in flash (check!!)
> - bootloader runs (check!!)
> - ... next load linux
>
> Well, I've progressed to the point where u-boot is installed on the ebony
> and running. I'm now trying to load linux and run, but I'm getting stumped
> where tftp is not able to find the file I'm trying to load. The following
> are attached below to show my settings:
>
> (a) dhcp conf file on host
> (b) listing of tftp directory
> (c) ebony serial port log
>
> Please note the following:
> - Host/DHCP server ip=172.16.77.151
> - Target ip=172.16.77.152 (assigned by dhcp server)
> - Permissions in tftpboot directory are more than adequate
> - I used DHCP because as I fuddled around with u-boot, it didn't see
>   possible to separate tftp from bootp. In other words, even if I set
>   ip addr(s) and stuff through the u-boot setenv command, the values
>   would be automatically overidden when I run the bootp command. The
>   BOOTP command seems to be the only way to kick off tftp, so I really
>   wasn't able to find a way to make use of statically set network
>   Config info.
> - vmlinux.PPCBOOT is the product of my 'make uImage' build in my kernel
>   source tree.
>
> Any ideas on why this isn't working??
>
>
***************************************************************************
> ********************* (a) dhcp config file
********************************
>
***************************************************************************
> subnet  172.16.77.0       netmask 255.255.255.0 {
>         option routers          172.16.77.1;
>         option subnet-mask      255.255.255.0;
>
>         option domain-name      "adic.com";
>
>         host trgt {     hardware ethernet       00:04:AC:E3:1B:55;
>                         fixed-address           172.16.77.152;
>                         option root-path        "/opt/eldk/ppc_4xx";
>                         option host-name        "ebony1-linux-iSCSI";
>                         next-server             172.16.77.151;
>                         filename
"/tftpboot/vmlinux.PPCBoot";
>         }
> }
>
***************************************************************************
>
***************************************************************************
>
>
>
***************************************************************************
> ********************* (b) tftp directory
*********************************
>
***************************************************************************
> [root@ppc-dev logs]# ls -al /tftpboot
> total 4336
> drwxrwxrwx    4 root     root         4096 Feb  2 11:08 .
> drwxr-xr-x   20 root     root         4096 Jan 30 04:47 ..
> -rw-r--r--    1 root     root          256 Jan 31 09:33 bdi_log
> -rw-r--r--    1 root     root         3061 Feb  2 11:08 evb440gp.cfg
> drwxr-xr-x    2 root     root         4096 Feb  2 11:52 logs
> -rwxr-xr-x    1 root     root       524288 Jan 31 13:51 ppcboot.bin
> -rw-r--r--    1 root     root         9597 Feb  1 08:20 reg405gp.def
> -rw-r--r--    1 root     root        10722 Feb  2 04:37 reg440gp.def
> -rwxr-xr-x    1 root     root       539716 Jan 31 08:43 u-boot
> -rwxr-xr-x    1 root     root       524288 Jan 31 08:43 u-boot.bin
> -rwxr-xr-x    1 root     root      1572962 Jan 31 08:43 u-boot.srec
> -rwxrwxrwx    1 root     root       583425 Feb  2 07:48 vmlinux.PPCBoot
> drwxr-xr-x    3 root     root         4096 Jan 30 04:11 X86PC
> -rwxr-xr-x    1 root     root       611872 Feb  1 08:18 zImage.ebony
> [root@ppc-dev logs]#
>
***************************************************************************
>
***************************************************************************
>
>
>
***************************************************************************
> ********************* (c) ebony serial port
*******************************
>
***************************************************************************
> U-Boot 0.2.0 (Jan 31 2003 - 05:12:55)
>
> IBM PowerPC 440 Rev. C
> Board: IBM 440GP Evaluation Board (Ebony)
>         VCO: 800 MHz
>         CPU: 400 MHz
>         PLB: 133 MHz
>         OPB: 66 MHz
>         EPB: 66 MHz
> I2C:   ready
> DRAM:  I2c read: failed 4
> I2c read: failed 4
> 128 MB
> FLASH:  4.5 MB
> PCI:   Bus Dev VenId DevId Class Int
> In:    serial
> Out:   serial
> Err:   serial
> KGDB:  kgdb ready
> ready
> BEDBUG:ready
> => bootp
> ENET Speed is 100 Mbps - HALF duplex connection
> BOOTP broadcast 1
> DHCP client bound to address 172.16.77.152
> ARP broadcast 1
> TFTP from server 172.16.77.151; our IP address is 172.16.77.152
> Filename '/tftpboot/vmlinux.PPCBoot'.
> Load address: 0x100000
> Loading: *
> TFTP error: 'File not found' (1)
> Starting again
>
***************************************************************************
>
***************************************************************************
>
>
> -- Brian
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
