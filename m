Date: Thu, 17 Jun 2004 11:37:46 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS probelm in MPC8245
Message-ID: <20040617093746.GO10248@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040617085836.82148.qmail@web13602.mail.yahoo.com>
Mime-Version: 1.0
In-Reply-To: <20040617085836.82148.qmail@web13602.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>          Iam working with MPC8245 in Linux.but im new
> to this. Kernel was booted into board and we able to
> do ping,telnet,ftp to board. but, i could not able to
> mount NFS in board.Rfs also not mounting. i had tried
> as per the "Getting started timesys linux on Ampro
> Encore PP1" doc. and i search in google also, but
> progress...
> please can anybody help me....

So you are booting and running a CramFS, but cannot replace it with a
NFS System?

Have you configured the kernel to activate BOOTP?
CONFIG_IP_PNP_BOOTP=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y

I just wrote the following, hope its of some use.

   Barco home TWiki > Firmware > FirmwareDocumentation > NFSSystem TWiki
   webs:
   Firmware | Software | Servers
   Firmware . { Changes | Index | Search | Go ________________ }

   Loading a cramfs is time consuming and during a
   testing/debuggin/development cycle, this is done quite often.
   Therefore a NFS filesystem is more useful. The boards are configured
   to use BOOTP for booting. In the following, the basic modifications
   are described to configure a GNU/Linux server to serve as a bootp
   server.

   First of all, a number of services need to be installed on the
   machine:
     * a NFS server
     * a DHCP server

   On a GNU/Debian system, the following packages need to be installed:
[mleeman@gemini mleeman]$ dpkg -l |grep nfs
ii  nfs-common     1.0-2woody1    NFS support files common to client and serve
ii  nfs-kernel-ser 1.0-2woody1    Kernel NFS server support
[mleeman@gemini mleeman]$ dpkg -l |grep dhcp
ii  dhcp           2.0pl5-19      DHCP server for automatic IP address assignme
nt

   Other systems have similarly named packages.

   The main configuration for this is done in a number of files:
     * /etc/exports contains the files of your files on the server which
       are exported over NetworkFileSystem (NFS). In this case, this will
       be the root filesystem for our embedded board.
     * /etc/dhcpd.conf contains the configuration of the DHCP server. You
       have to make certain that you are the only DHCP server in your
       netrange. If you do not, a lot of unpleasantness can occuur since
       your server will reply with DHCPNAK on request going for the
       official DHCP server.

   Extract a root filesystem tarball (or something similar) to your
   homedir (or a predetermined location).
[mleeman@gemini mleeman]$ mkdir targets
[mleeman@gemini mleeman]$ tar xvfz target.scn.tar.gz -C targets/

   Secondly, add the following entry in the exports file, indicating that
   you want to export without any condition:
/home/mleeman/targets/target.scn.01 *(rw,no_root_squash,no_all_squash)

   Finally, restart the NFS server:
[mleeman@gemini mleeman]$ sudo /etc/init.d/nfs-kernel-server restart

   We're halfway through. We now need to link this NFS filesystem to the
   MAC address of our board. This is done by adding the following in the
   /etc/dhcpd.conf file:
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

   We now need to restart the dhcp server:
[mleeman@gemini mleeman]$ sudo /etc/init.d/dhcpd restart

   If you do not know the MAC address, and it is not indicated on the
   board in some way, just let the target boot (loaded with an NFS kernel
   of course) and watch the messages of the dhcp server, it will display
   the the MAC address (but will not pass a root FS).

[mleeman@gemini mleeman]$ sudo tail -f /var/log/messages

   and search for something like the following passing:
Apr  9 07:53:22 gemini dhcpd: BOOTREQUEST from 00:04:a5:00:05:19 via eth0
Apr  9 07:53:22 gemini dhcpd: No applicable record for BOOTP host 00:04:a5:00:0
5:19 via eth0

   In this case 00:04:a5:00:05:19 is our MAC address.

   -- MarcLeeman - 17 Jun 2004

   Topic NFSSystem . { Edit | Attach | Ref-By | Printable | Diffs | r1.1
   | More }

   Revision r1.1 - 17 Jun 2004 - 07:57 GMT - MarcLeeman
   Parents: WebHome > FirmwareDocumentation Copyright © 1999-2003 by the
   contributing authors. All material on this collaboration platform is
   the property of the contributing authors.
   Ideas, requests, problems regarding TWiki? Send feedback.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
