Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 4F8682BDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 22:19:25 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id y7so311132rne
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 03:19:24 -0800 (PST)
Message-ID: <1f729c4804112503197e843ddb@mail.gmail.com>
Date: Thu, 25 Nov 2004 12:19:24 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: zhonglei@rcs-9000.com, linuxppc-dev@ozlabs.org
In-Reply-To: <200411251657.AA31129806@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_4_16219844.1101381564660"
References: <200411251657.AA31129806@RCS-9000.COM>
Subject: Re: problem on netdevice
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4_16219844.1101381564660
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Make certain that your DHCP server is set up correctly (see the attached fi=
le).

For the kernel config; make certain you have the following enabled:
[mleeman@gemini linux-2.4.28]$ cat config.nfs |grep NFS
CONFIG_NFS_FS=3Dy
CONFIG_ROOT_NFS=3Dy
[mleeman@gemini linux-2.4.28]$ cat config.nfs |grep ROOT
CONFIG_ROOT_NFS=3Dy
[mleeman@gemini linux-2.4.28]$ cat config.nfs |grep AUTO
CONFIG_AUTOFS4_FS=3Dy
[mleeman@gemini linux-2.4.28]$ cat config.nfs |grep BOOTP =20
CONFIG_IP_PNP_BOOTP=3Dy

Yours is not going to be bootp, but something similar with DHCP (same
goes with the att. file).

P.S. reply to the list too

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul

------=_Part_4_16219844.1101381564660
Content-Type: text/plain; name="NFSSystem.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="NFSSystem.txt"


   Barco home TWiki > Firmware > FirmwareDocumentation > NFSSystem TWiki we=
bs:
   Firmware | Software | Servers
   Firmware . { Changes | Index | Search | Go ________________ }

   Loading a cramfs is time consuming and during a testing/debugging/develo=
pment cycle, if this is done quite often. Therefore
   a NFS filesystem, where changes can be done on the fly, is more useful. =
The boards are configured to use BOOTP for booting.
   In the following, the basic modifications are described to configure a G=
NU/Linux server to serve as a bootp server.

   First of all, a number of services need to be installed on the serving m=
achine (gemini in this example):
     * a NFS server
     * a DHCP server

   On a GNU/Debian system, the following packages need to be installed:
[mleeman@gemini mleeman]$ dpkg -l |grep nfs
ii  nfs-common     1.0-2woody1    NFS support files common to client and se=
rve
ii  nfs-kernel-ser 1.0-2woody1    Kernel NFS server support
[mleeman@gemini mleeman]$ dpkg -l |grep dhcp
ii  dhcp           2.0pl5-19      DHCP server for automatic IP address assi=
gnment

   Other distributions should have similarly named packages.

   The main configuration for this is done in a number of files:
     * /etc/exports contains the files of your files on the server which ar=
e exported over NetworkFileSystem (NFS). In this
       case, this will be the root filesystem for our embedded board.
     * /etc/dhcpd.conf contains the configuration of the DHCP server. You h=
ave to make certain that you are the only DHCP
       server in your netrange. If you do not, a lot of unpleasantness can =
occuur since your server will reply with DHCPNACK on
       requests for the official DHCP server.

   Extract a root filesystem tarball (or something similar) to your homedir=
 (or a predetermined location). A free and general
   purpose PPC root filesystem can be found in ELDK (http://www.denx.de/ELD=
K/).
[mleeman@gemini mleeman]$ mkdir targets
[mleeman@gemini mleeman]$ tar xvfz target.scn.tar.gz -C targets/

   With the current BARCO builds, you can also use the CompressedFileSystem=
 backup to create your NFS root FS:
# mkdir fs; cd fs
# bzcat ../target-2.0.0.10.cpio.bz2 | cpio -vi

   Do not forget to copy your stream.cfg file, which basically re-confirms =
your IP address to ppcserver into the
   /root/ppcstream directory.

   Secondly, add the following entry in the exports file, indicating that y=
ou want to export without any condition:
/home/mleeman/targets/target.scn.01 *(rw,no_root_squash,no_all_squash)

   Finally, restart the NFS server:
[mleeman@gemini mleeman]$ sudo /etc/init.d/nfs-kernel-server restart

   We're halfway through. We now need to link this NFS filesystem to the MA=
C address of our board. This is done by adding the
   following in the /etc/dhcpd.conf file:
# global configuration options
# allow bootp packages
allow bootp;
# the first subnet we listen to
subnet 150.158.231.0 netmask 255.255.255.0 {
  # options for the subnet in question
  option routers 150.158.231.1;
  default-lease-time 1209600;
  max-lease-time 31557600;
  # for each board, add the following configuration block.
  # It is best that you use different root FS directories
  # for each board.
  group {
    host scnhost01 {
      # MAC address
      hardware ethernet 00:d0:b7:85:f9:28;
      # The fixed address we will assign to the board
      fixed-address 150.158.231.20;
      # hm. not relevant here, is the kernel, which we load in FLASH
      filename "image";
      # our root FS that will be passed to the board
      option root-path "/home/mleeman/targets/target.scn.01";
    }
  }
}

   We now need to restart the dhcp server:
[mleeman@gemini mleeman]$ sudo /etc/init.d/dhcpd restart

   If you do not know the MAC address, and it is not indicated on the board=
 in some way, just let the target boot (loaded with
   an NFS kernel of course) and watch the messages of the dhcp server, it w=
ill display the the MAC address (but will not pass a
   root FS).

[mleeman@gemini mleeman]$ sudo tail -f /var/log/messages

   and search for something like the following passing:
Apr  9 07:53:22 gemini dhcpd: BOOTREQUEST from 00:04:a5:00:05:19 via eth0
Apr  9 07:53:22 gemini dhcpd: No applicable record for BOOTP host 00:04:a5:=
00:05:19 via eth0

   More detailed information will be see in
sudo tail -f /var/log/syslog

Jul 13 15:57:08 gemini dhcpd: BOOTREQUEST from 00:04:a5:04:05:0c via eth0
Jul 13 15:57:08 gemini dhcpd: BOOTREPLY for 150.158.231.121 to hydra_stream=
_dmar (00:04:a5:04:05:0c) via eth0
Jul 13 15:57:13 gemini rpc.mountd: authenticated mount request from 150.158=
.231.121:800 for /home/dmartens/targets/target.01 (/home/d
martens/targets/target.01)

   In this case 00:04:a5:00:05:19 is our MAC address.

   More details about the kernel parameters are found in the attached file.

   -- MarcLeeman - 17 Jun 2004

   Attachment: Action: Size:        Date:           Who:                   =
   Comment:
   nfsroot.txt action  8020  21 Jun 2004 - 10:00 MarcLeeman Kernel Document=
ation (2.6.7) about an nfsroot

   Topic NFSSystem . { Edit | Attach | Ref-By | Printable | Diffs | r1.9 | =
> | r1.8 | > | r1.7 | More }

   Revision r1.9 - 13 Jul 2004 - 14:00 GMT - MarcLeeman
   Parents: WebHome > FirmwareDocumentation Copyright =A9 1999-2003 by the =
contributing authors. All material on this
   collaboration platform is the property of the contributing authors.
   Ideas, requests, problems regarding TWiki? Send feedback.

------=_Part_4_16219844.1101381564660--
