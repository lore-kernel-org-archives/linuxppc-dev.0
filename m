To: curt brune <curt@acm.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: wireless lan PCMCIA card advice 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Jan 2003 12:51:25 PST."
             <20030106125125.D24490@curtisb.com>
Date: Mon, 06 Jan 2003 22:58:16 +0100
Message-Id: <20030106215821.56C05C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Curt,

in message <20030106125125.D24490@curtisb.com> you wrote:
>
> I have a RPXLite 823e based board from EmbeddedPlanet that has an open
> PCMCIA slot in it.  Currently I am booting a 2.4.4 kernel from ELDK
> which works just fine.

The current version of our ELDK provides pretty complete support  for
PCMCIA  cards,  and has been tested with WLAN, CompactFlash and other
IDE, network and modem cards.

> I would like to buy a wireless 802.11b PCMCIA card for this board and
> am wondering about any past experiences.  I have researched the
> general linux+WiFi webistes a bit, but I wanted the embedded society's
> opinion also.
>
> Any success stories out there?  If so could you include the following
> info?

Here is a step-by-step description of what we did -  both  on  custom
hardware and on standard TQM8xxL systems:

1. Building and installing the CardServices package.

QUICKSTART:

 - Unpack pcmcia-cs-3.2.0.tar.gz tarball, apply patch.

 - The CIS replacement data file ARGOSY.dat have to be copied
   to "pcmcia-cs-3.2.0/etc/cis" directory of the source tree.

 - set up cross-development environment (ppc_8xx-gcc should be in PATH)
 - configure, build and boot the kernel, making sure that the latest patch
   is applied.
	The CONFIG_PCMCIA kernel option must be off.
	For particular card types see notes below.
        To avoid warnings during "depmod" at the system start-up, enable
        the standard 16550 serial driver.

   While in the pcmcia-cs-3.2.0 directory, execute the following commands:
 - make config
      It is safe to leave the default answers to all the
      configuration questions, except for the Cardbus support, which
      must be disabled, and for the Linux kernel source directory,
      which must match the directory you used in the previous step

 - make all
 - touch etc/cis/ARGOSY.dat
 - make install
The resulting tree will be in pcmcia-cs-3.2.0/../pcmcia directory.
 - Copy the resulting tree to the root (/) of the target file system
   being logged as 'root':

   # cp -r ../pcmcia/* /opt/eldk/ppc_8xx/

2. Starting CardServices:

on the target:
/etc/rc.d/rc.pcmcia start


3. To be able to use wireless PCMCIA cards the 'wireless-tools' package
must be installed on the target filesystem.

To bring up the WLAN card for network operations, the following
actions should be performed (the example output shows card configuration
for the WLAN network controlled by the Access Point ("managed" mode)):

1. Assign the ip address of the WLAN network segment to the WLAN interface:

bash# ifconfig eth1 192.168.2.3

2. Assign the Network (or Domain) Name to the WLAN interface:
bash# iwconfig eth1 essid "DENX"

At this point the Acess Point station MAC address should appear on the
iwconfig output:
bash# iwconfig eth1
eth1      IEEE 802.11-DS  ESSID:"DENX"  Nickname:"Prism  I"
          Mode:Managed  Frequency:2.462GHz  Access Point: 00:02:2D:03:A5:15
          Bit Rate:2Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:28/92  Signal level:151/153  Noise level:107/153
          Rx invalid nwid:0  invalid crypt:0  invalid misc:0



The card now is ready for normal network operations.



Special considerations about kernel configuration on
certain card types:

- PCMCIA IDE cards (CF and true-IDE)
To support the ide CardService Client, the kernel have to be
configured with general ATA IDE support. The MPC8XX IDE support
(CONFIG_BLK_DEV_MPC8XX_IDE flag) have to be turned off.


- PCMCIA modem cards
The kernel have to be configured with standard serial port support
(CONFIG_SERIAL flag).
After the kernel bootup the following preparation is needed:

mknod /dev/ttySp0 c 240 64
(/dev/ttyS0-4 and TTY_MAJOR 4 are already used by the standard 8xx
uart driver).

After the CardServices detects and initializes the PCMCIA card,
the /dev/ttySp0 becomes available for use.

- PCMCIA Wireless LAN cards
Enable "Network device support" --> "Wireless LAN (non-hamradio)" -->
"Wireless LAN (non-hamradio)" option in the kernel configuration
(CONFIG_NET_RADIO flag).


Note that the current version of the ELDK includes all required
packages in the "pcmcia-cs-ppc_8xx-3.2.1-1.ppc.rpm" and
"wireless-tools-ppc_8xx-21-3.ppc.rpm" RPMs

Hope this helps.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The most difficult thing in the world is to know how to  do  a  thing
and to watch someone else doing it wrong, without commenting.
                                                        -- T.H. White

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
