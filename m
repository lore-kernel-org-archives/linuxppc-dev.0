Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D175367C29
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 10:27:36 +1000 (EST)
Date: Wed, 23 Aug 2006 02:28:01 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060823002801.GA2709@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E6D634.3000207@s5r6.in-berlin.de>
Cc: linuxppc-dev@ozlabs.org, billfink@mindspring.com,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Stefan,
Hi All

On Sat, Aug 19, 2006 at 11:13:24AM +0200, Stefan Richter wrote:

          [ ... ]

> The fact that Linux on the AlBook gets at least as far as "ieee1394: 
> Error parsing configrom for node 0-00:1023" indicates that not all hope 
> is lost. If you have got the time, compile the 1394 drivers for verbose 
> logging and send the log. Don't crosspost the log if it gets too big.

Some tests on the Alubook:

I compiled a fresh git kernel now with verbose ieee logging turned on.

$ uname -r
2.6.18-rc4-ieeeverbose-gef7d1b24-dirty

$ zgrep 4_VERBOS /proc/config.gz 
CONFIG_IEEE1394_VERBOSEDEBUG=y


Before starting the FW disk I removed all ieee drivers I thought could
be relevant, with this little script:

-------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.stop.sh; \
rmmod raw1394; \
rmmod eth1394;
rmmod ohci1394; \
rmmod sbp2; \
rmmod ieee1394
---------------------------------------



Then, with the FW disk connected to the alubook, but *not yet* powered
on by the latter via a switch at the enclosure which obviously, when
switched on, feeds the current to the firewire disk, thus switching it on:

-----------------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.start.sh ; \

modprobe ieee1394 disable_irm=0; \
sleep 2; \
modprobe ohci1394; \
sleep 2; \
modprobe sbp2; \
sleep 2; \
modprobe raw1394; \
sleep 2
chown root.shorty /dev/raw1394
sleep 4; \
ls /dev/sda


-------------------------------



Only after running the latter script, I switch on the FW disk. The log
for these moments covering about 60 seconds is here:

wolfgangpfeiffer.com/kern.log.when.fw.disk.is.switched.on.txt

Then, some time later on with no /dev/sda available, I run gscanbus,
forcing a bus reset. The log, again covering about 60 seconds is here:

wolfgangpfeiffer.com/kern.log.with.gscanbus.after.failed.fw.connection.txt


Again a bit later I click the 3 icons on the gscanbus window:

Clicking
"Unknown 
Linux - ohci1394"

------------------------------------------------------
SelfID Info
-----------
Physical ID: 2
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: -1W
Port 0: Not connected
Port 1: Connected to child node
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
-------------------------------------------------





Clicking

" <question mark>
S400 Unknown":

------------------------------------------
SelfID Info
-----------
Physical ID: 1
Link active: No
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: No
Power Class: -1W
Port 0: Not connected
Port 1: Connected to parent node
Port 2: Connected to child node
Init. reset: No

CSR ROM Info
------------
GUID: 0x0000000000000000
Node Capabilities: 0x00000000
Vendor ID: 0x00000000
Unit Spec ID: 0x00000000
Unit SW Version: 0x00000000
Model ID: 0x00000000
Nr. Textual Leafes: 0

Vendor: (null)
Textual Leafes: 

AV/C Subunits
-------------
N/A

-------------------------------------------------------------


Clicking a second

" <question mark>
S400 Unknown":

----------------------------------------------------
SelfID Info
-----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: No
Power Class: None
Port 0: Connected to parent node
Port 1: Not connected
Port 2: Not connected
Init. reset: No

CSR ROM Info
------------
GUID: 0x0000000000000000
Node Capabilities: 0x00000000
Vendor ID: 0x00000000
Unit Spec ID: 0x00000000
Unit SW Version: 0x00000000
Model ID: 0x00000000
Nr. Textual Leafes: 0

Vendor: (null)
Textual Leafes: 

AV/C Subunits
-------------
N/A

---------------------------------------------------



Please, if you think it might help, let me know if want to change the
scripts to load the ieee drivers ...  (Note the disable_irm=0 in one of
the scripts above .. )


Til then

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
