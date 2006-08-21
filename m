Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BA68C67B9D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:29:02 +1000 (EST)
Date: Mon, 21 Aug 2006 02:29:22 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060821002921.GA2736@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E6D634.3000207@s5r6.in-berlin.de>
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 19, 2006 at 11:13:24AM +0200, Stefan Richter wrote:

> If you have got the TiBook around, you could connect it with the AlBook 
> and look what gscanbus or OS X's system profiler have to say about it. 
> If possible, also try the TiBook in target disk mode and see if it 
> appears as a disk for Linux' sbp2 or under OS X.

I sent the test results of the target disk mode last night.

Now this evening I tried to connect the alubook to the titanium via the FW
400 ports with both machines fully booted. 

First the alubook with OSX connected to the titanium with Linux on it,
and then both computers connected to each other with Linux running on
both of them.

The alubook is a dual-boot machine (OSX/Linux), while the titanium
only has Linux on it.


_____________________________________________________________________________
PART I

Connecting the alubook (with OSX running) to the tibook (with Linux running)
---------------------------------------------------------------------------

Status on the titanium, with a kernel 2.6.14-1, IEEE1394_VERBOSEDEBUG
is enabled there.

After modprobing raw1394 the connected AluBook (OSX running) is seen
via gscanbus, but /dev/sda is not created. sbp2 was not started at
that time.  modprobing sbp2 does not help to change this.

gscanbus tho:

clicking
S400 Linux - ohci 1394:

------------------------
SelfID Info
-----------
Physical ID: 1
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: None
Port 0: Connected to child node
Init. reset: Yes

CSR ROM Info
------------
GUID: 0x000393FFFECDE4C4
Node Capabilities: 0x000083C0
Vendor ID: 0x00000393
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor:  Apple Computer, Inc.
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

---------------------


clicking
"Unknown
Apple Computer, Inc." results in:

---------------------
SelfID Info
-----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: -1W
Port 0: Not connected
Port 1: Connected to parent node
Port 2: Not connected
Init. reset: No

CSR ROM Info
------------
GUID: 0x001451FFFE3148BE
Node Capabilities: 0x000083C0
Vendor ID: 0x00000A27
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000002
Model ID: 0x00000000
Nr. Textual Leafes: 2

Vendor:  Apple Computer, Inc.
Textual Leafes: 
Apple Computer, Inc.
Macintosh

AV/C Subunits
-------------
N/A

--------------------

Im getting in /var/log/kern.log messages like this:

---------------------------------
Aug 20 23:48:27 debby kernel: [ 2389.161336] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.161357] ieee1394: send packet local: ffc1a540 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.161369] ieee1394: received packet: ffc1a540 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.161386] ieee1394: send packet local: ffc1a560 ffc10000 00000000 7a2367e9
Aug 20 23:48:27 debby kernel: [ 2389.161400] ieee1394: received packet: ffc1a560 ffc10000 00000000 7a2367e9
Aug 20 23:48:27 debby kernel: [ 2389.261335] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.261356] ieee1394: send packet local: ffc1a940 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.261369] ieee1394: received packet: ffc1a940 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.261386] ieee1394: send packet local: ffc1a960 ffc10000 00000000 7a5567ff
Aug 20 23:48:27 debby kernel: [ 2389.261400] ieee1394: received packet: ffc1a960 ffc10000 00000000 7a5567ff
Aug 20 23:48:27 debby kernel: [ 2389.361334] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.361356] ieee1394: send packet local: ffc1ad40 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.361369] ieee1394: received packet: ffc1ad40 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.361386] ieee1394: send packet local: ffc1ad60 ffc10000 00000000 7a876814
Aug 20 23:48:27 debby kernel: [ 2389.361401] ieee1394: received packet: ffc1ad60 ffc10000 00000000 7a876814
Aug 20 23:48:27 debby kernel: [ 2389.461326] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.461348] ieee1394: send packet local: ffc1b140 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.461361] ieee1394: received packet: ffc1b140 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.461378] ieee1394: send packet local: ffc1b160 ffc10000 00000000 7ab96750
Aug 20 23:48:27 debby kernel: [ 2389.461392] ieee1394: received packet: ffc1b160 ffc10000 00000000 7ab96750
Aug 20 23:48:27 debby kernel: [ 2389.561323] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.561346] ieee1394: send packet local: ffc1b540 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.561359] ieee1394: received packet: ffc1b540 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.561377] ieee1394: send packet local: ffc1b560 ffc10000 00000000 7aeb675c
Aug 20 23:48:27 debby kernel: [ 2389.561392] ieee1394: received packet: ffc1b560 ffc10000 00000000 7aeb675c
Aug 20 23:48:27 debby kernel: [ 2389.661317] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.661338] ieee1394: send packet local: ffc1b940 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.661351] ieee1394: received packet: ffc1b940 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.661367] ieee1394: send packet local: ffc1b960 ffc10000 00000000 7b1d668a
Aug 20 23:48:27 debby kernel: [ 2389.661382] ieee1394: received packet: ffc1b960 ffc10000 00000000 7b1d668a
Aug 20 23:48:27 debby kernel: [ 2389.761314] raw1394:read_request called
Aug 20 23:48:27 debby kernel: [ 2389.761335] ieee1394: send packet local: ffc1bd40 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.761348] ieee1394: received packet: ffc1bd40 ffc1ffff f0000200
Aug 20 23:48:27 debby kernel: [ 2389.761366] ieee1394: send packet local: ffc1bd60 ffc10000 00000000 7b4f6677
Aug 20 23:48:27 debby kernel: [ 2389.761381] ieee1394: received packet: ffc1bd60 ffc10000 00000000 7b4f6677
Aug 20 23:48:28 debby kernel: [ 2389.862296] raw1394:read_request called
Aug 20 23:48:28 debby kernel: [ 2389.862316] ieee1394: send packet local: ffc1c140 ffc1ffff f0000200
Aug 20 23:48:28 debby kernel: [ 2389.862329] ieee1394: received packet: ffc1c140 ffc1ffff f0000200
Aug 20 23:48:28 debby kernel: [ 2389.862347] ieee1394: send packet local: ffc1c160 ffc10000 00000000 7b81e4b4
Aug 20 23:48:28 debby kernel: [ 2389.862362] ieee1394: received packet: ffc1c160 ffc10000 00000000 7b81e4b4
---------------------------


This is what OSX (on the alubook) says:
---------------------


.. about the titanium with Linux running: No pasting possible of the
values I saw: I wrote it down what I saw on the OSX screen:


Network status in OS X System Preferences reports something like this:

"Built in Firewire"

"Cable for built-in Firewire is connected, but your computer does not
have an IP address and cannot connect to the Internet"

I didn't even try (never will) to reconfigure this - I don't trust OSX
enough to let it come closer than 500 meters to my Linux partitions.

The Apple System Profiler, as it seems about the Titanium:

---------------------
Firewire Bus:
Unknown device

Manufacturer: Linux - ohci1394
Model: unknown device
GUID: 0x393FFFECDE4C4
Maximum Speed: Up to 400 Mb/Sec
Connection Speed: Up to 400 Mb/Sec

Unknown Unit:
Unit Software version: 0x1
Unit Spec ID: 0x5E
-----------------------------


-----------------------------------------------------------------------------------
PART II

Connecting the alubook to the titanium, with both machines running Linux on them:
---------------------------------------------------------------------------------

Status on the titanium:

----------------------------------------------
$ /sbin/lsmod | grep -i sbp
sbp2                   24932  0 
scsi_mod              160836  2 sbp2,sg
ieee1394              425552  4 sbp2,raw1394,eth1394,ohci1394
[shorty@ 00:58:55]$ /sbin/lsmod | grep 1394  
raw1394                35064  2 
eth1394                20552  0 
ohci1394               44980  0 
ieee1394              425552  4 sbp2,raw1394,eth1394,ohci1394
--------------------------------------------------------

No /dev/sda on the titanium.

gscanbus:

2 icons on the gscanbus window:

#1:
" <some Penguin picture>
 S400
 Linux - ohci1394"

Clicking it:

------------------------------
SelfID Info
-----------
Physical ID: 1
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: None
Port 0: Connected to child node
Init. reset: Yes

CSR ROM Info
------------
GUID: 0x000393FFFECDE4C4
Node Capabilities: 0x000083C0
Vendor ID: 0x00000393
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor:  Apple Computer, Inc.
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

------------------------------


#2:

"<Question mark>
 Unknown
 Linux - ohci1394"


Clicking it:

----------------------------
SelfID Info
-----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: -1W
Port 0: Not connected
Port 1: Connected to parent node
Port 2: Not connected
Init. reset: No

CSR ROM Info
------------
GUID: 0x001451FFFE3148BE
Node Capabilities: 0x000083C0
Vendor ID: 0x00001451
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor: Unknown
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

-----------------------------


---------------------------
Status on the alubook:
---------------------------

$ /sbin/lsmod | grep -i sbp
sbp2                   23528  0 
scsi_mod              154128  2 sr_mod,sbp2
ieee1394              417744  4 raw1394,sbp2,eth1394,ohci1394
[shorty@ 01:46:06]$ /sbin/lsmod | grep 1394
raw1394                28128  2 
eth1394                18628  0 
ohci1394               37392  0 
ieee1394              417744  4 raw1394,sbp2,eth1394,ohci1394

kernel is 2.6.18-rc4

$ zgrep IEEE1394_VERBOSEDEBUG /proc/config.gz
# CONFIG_IEEE1394_VERBOSEDEBUG is not set


gscanbus says this, after a "Force bus reset":

2 icons:

#1

"<Monitor with an Apple logo picture>
S400 
Linux - ohci1394"

clicking it:

-------------------------
SelfID Info
-----------
Physical ID: 1
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: None
Port 0: Connected to child node
Init. reset: No

CSR ROM Info
------------
GUID: 0x000393FFFECDE4C4
Node Capabilities: 0x000083C0
Vendor ID: 0x00000393
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor:  Apple Computer, Inc.
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

---------------------------
 

#2:

"<Monitor with a penguin picture>
Unknown
Linux - ohci1394"

clicking the picture:

-------------------------
SelfID Info
-----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: -1W
Port 0: Not connected
Port 1: Connected to parent node
Port 2: Not connected
Init. reset: Yes

CSR ROM Info
------------
GUID: 0x001451FFFE3148BE
Node Capabilities: 0x000083C0
Vendor ID: 0x00001451
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor: Unknown
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

----------------------------

No kern.log messages that I saw after the bus reset via gscanbus.
No /dev/sda on the alubook.


> 
> The fact that Linux on the AlBook gets at least as far as "ieee1394: 
> Error parsing configrom for node 0-00:1023" indicates that not all hope 
> is lost. If you have got the time, compile the 1394 drivers for verbose 
> logging and send the log. Don't crosspost the log if it gets too big.

As I already wrote: Tuesday or Wednesday I'll have the git kernel
compiled, if all goes well. With CONFIG_IEEE1394_VERBOSEDEBUG enabled.


Note: About 2 days ago I had, IIRC, ext2fsx
(http://sourceforge.net/project/showfiles.php?group_id=64713) shortly
installed on OSX - I quickly uninstalled it afterwards, and at the time
of the tests today on OSX nothing *should* have been installed of that
software anymore .. let's hope :) 

I do not know too much on OS X, that's why I keep my hands off Linux
via OSX.


Until then

Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
