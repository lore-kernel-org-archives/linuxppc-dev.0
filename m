MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ppcboot boot-up question
Date: Mon, 2 Feb 2004 14:48:59 -0700
Message-ID: <8039970AF146314597457D3B51A68B382E0492@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You probably need the serial handshake lines properly terminated, or hardware handshaking disabled, so that your boot process isn't waiting for the handshake lines to go active.  For a test, make a DB-9 (or whatever) with RTS connected to CTS and DSR connected to DTR and DCD.  Plug this into your board and I suspect it will boot fine.

The "AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0" is minicom trying to initialize your modem (which obviously doesn't exist).  This can be ignored, but a better solution is to switch to ckermit (as Wolfgang would strongly recommend ;-) or change your minicom default initialization by deleting all the modem initialization strings.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Todd
> Sent: Monday, February 02, 2004 4:40 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: ppcboot boot-up question
>
>
>
> I'm using PPCBoot 2.0.0
> I have my PPC 750 setup to delay for 5sec then boot
> from the DiskOnChip.  This works properly, as long as
> I have an active serial connection to the board.
> However, I've noticed that if there is not an active
> serial connection to the board, the autoboot function
> will not work.  If I reset the board, with no serial
> connection, then start minicom after 10 seconds I
> always find the following:
>
> => AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
> syntax error
> =>
>
> Does anyone know what I am doing wrong??
>
> These are my environmental variables:
>
> baudrate=9600
> preboot=
> clocks_in_mhz=1
> hostname=spyder
> ethaddr=00:c0:e5:10:0:99
> serverip=10.1.1.107
> gatewayip=10.1.1.1
> ipaddr=10.1.1.28
> netmask=255.255.255.0
> nfs_bootfile=gesppc2
> doc_bootfile=no_nfs_pImage
> bootdelay=5
> rootpath=/opt/timesys/linux/4.0/gesppc2/rfs
> bootcmd=docboot 6000000 0
> bootargs=root=/dev/nftla1 rw
> ip=10.1.1.28::10.1.1.1:255.255.255.0:spyder:eth0:off
> autostart=yes
> autoload=yes
> stdin=serial
> stdout=serial
> stderr=serial
>
> Environment size: 438/4092 bytes
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
