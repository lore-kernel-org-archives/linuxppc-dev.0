Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id DB6F0B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 12:25:15 +1100 (EST)
Received: by fxm1 with SMTP id 1so1373422fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 18:25:12 -0700 (PDT)
MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Wed, 27 Oct 2010 18:24:52 -0700
Message-ID: <AANLkTimS-sfqONuSJNPJy7OxO_U81qtDHe2JeioLDNVs@mail.gmail.com>
Subject: RapidIO: MC Exception when enumerating peer to peer connection
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm trying to bring up a RapidIO on my p2020 on v2.6.36-rc7.  I'm
running into an issue when the host tries to enumerate the agent
devices, and fails miserably.  The rio driver does a
fsl_rio_config_read with a destid of 255, after which it hangs, until
I get a timeout exception (Handled now, thanks!).  The port connection
get's trained, and everything looks good, but I get no response.  Any
ideas on what to look at to debug this?

Also, after the timeout, the driver seems to hang after that,
presumably because the port is in an error-stop state, because when I
use my trusty jtag to issue a Port Link Maintenance Request and
request status, I get back unrecoverable ackID error for port 1, and
error-stopped port_status for port 2.

0_ffec0140 : 00000004 80000050 02000202 00000000  .......P........
0_ffec0150 : 00000000 00000000 00120002 42600001  ............B`..
0_ffec0160 : 00000004 00000005 00000000 00000000  ................


Reference information below:


U-Boot LAW configuration:
========================
Local Access Window Configuration
        LAWBAR1 : 0x000a0000, LAWAR1 : 0x80c00017 /* SRIO Port 1 */
        LAWBAR2 : 0x000a1000, LAWAR2 : 0x80d00017 /8 SRIO Port 2 */


Excerpt from linux boot:
====================
Setting up RapidIO peer-to-peer network /rapidio@ffec0000
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~ fsl_rio_setup ~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
of:fsl-of-rio ffec0000.rapidio: Of-device full name /rapidio@ffec0000
of:fsl-of-rio ffec0000.rapidio: Regs: [mem 0xffec0000-0xffedffff]
of:fsl-of-rio ffec0000.rapidio: LAW start 0x00000000a0000000,
 size 0x0000000001000000.
of:fsl-of-rio ffec0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
of:fsl-of-rio ffec0000.rapidio: Overriding RIO_PORT setting to single lane 0
of:fsl-of-rio ffec0000.rapidio: RapidIO PHY type: serial
of:fsl-of-rio ffec0000.rapidio: Hardware port width: 4
of:fsl-of-rio ffec0000.rapidio: Training connection status: Single-lane 0
of:fsl-of-rio ffec0000.rapidio: RapidIO Common Transport System size: 256
EIPWQBAR: 0x00000000 IPWQBAR: 0x1f107000
IPWMR: 0x00100120 IPWSR: 0x00000000
RIO: enumerate master port 0, RIO0 mport
rio_enum_host: port `RIO0 mport`
fsl_local_config_write: index 0 offset 00000068 data 00000000
fsl_local_config_read: index 0 offset 00000068
fsl_local_config_write: index 0 offset 00000060 data 00000000
master port device id set to 0 (next=0)
fsl_local_config_read: index 0 offset 0000000c
fsl_local_config_read: index 0 offset 00000100
fsl_local_config_read: index 0 offset 00000158
RIO: Rio network device created
rio_enable_rx_tx_port(local = 1, destid = 0, hopcount = 0, port_num = 0)
fsl_local_config_read: index 0 offset 0000000c
fsl_local_config_read: index 0 offset 00000100
fsl_local_config_read: index 0 offset 0000015c
fsl_local_config_write: index 0 offset 0000015c data 42600001
Enumerating rionet.
RIO: acquiring  device lock...
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
RIO: fsl_rio_mcheck_exception - MC Exception handled. reason=0x80000000
RIO: cfg_read error -14 for ff:0:68
RIO_LTLEDCSR = 0x0


Thanks!
