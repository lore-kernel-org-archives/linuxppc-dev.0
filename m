Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 81A8567C20
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 05:21:33 +1000 (EST)
Date: Thu, 24 Aug 2006 21:22:00 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060824192200.GA2715@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060823002801.GA2709@localhost>
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

On Wed, Aug 23, 2006 at 02:28:01AM +0200, Wolfgang Pfeiffer wrote:
> 
> Hi Stefan,
> Hi All
> 
> On Sat, Aug 19, 2006 at 11:13:24AM +0200, Stefan Richter wrote:
> 
>           [ ... ]
> 
> > The fact that Linux on the AlBook gets at least as far as "ieee1394: 
> > Error parsing configrom for node 0-00:1023" indicates that not all hope 
> > is lost. If you have got the time, compile the 1394 drivers for verbose 
> > logging and send the log. Don't crosspost the log if it gets too big.
> 
> Some tests on the Alubook:


.. but this time with "modprobe ieee1394 disable_irm=1". 2 logs were be
created: 
www.wolfgangpfeiffer.com/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
www.wolfgangpfeiffer.com/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt

Because i hate to burden my lousy memory with what I did to produce
the logs above, I scrambled together my admittedly marginal bash
knowledge and ran the tests with 4 scripts to produce the logs.

All the following below is to give you control on how these logs were
created. I'll try to be as verbose as possible. This because, as I
already made clear, I'm anything else but a bash expert. And because I
want to make sure the logs are not spoiled.

And please:

If you think the following is not necessary and instead only burdens
everyone else's mail box with KB that are not needed please let me
know ... :) 


###########################################################
*** How
    disable-irm.kern.log.when.fw.disk.is.switched.on.txt
    was made
###########################################################


First the main script I run to get 
disable-irm.kern.log.when.fw.disk.is.switched.on.txt

/home/shorty/scripts/ieee.test.sh:
------------------------------------------------
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.sh; \
/home/shorty/scripts/scsi.stop.sh; \
/home/shorty/scripts/scsi.start.sh; \

sleep 2; \
/home/shorty/kernel-factory/git.060822/linux-2.6/scripts/ver_linux; \

cat /dev/null > /var/log/kern.log; \
echo "===> NOW SWITCH ON THE FW DISK <===="; \
sleep 70; \
ls /dev/sda*; \

if [ -f   /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt ]; then
    rm -f /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
    chown shorty.shorty /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
else
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
fi


-------------------------------------------------


As you can see above 2 more scripts are (hopefully :) executed inside
the latter script:

#1: /home/shorty/scripts/scsi.stop.sh:
-----------------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.stop.sh; \
rmmod raw1394; \
rmmod eth1394;
rmmod ohci1394; \
rmmod sbp2; \
rmmod ieee1394


---------------------------------------

and #2: /home/shorty/scripts/scsi.start.sh:
------------------------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.start.sh; \

modprobe ieee1394 disable_irm=1; \
sleep 2; \
modprobe ohci1394; \
sleep 2; \
modprobe sbp2; \
sleep 2; \
modprobe raw1394; \
sleep 2
chown root.shorty /dev/raw1394



--------------------------------------------


This is what the shell was saying when running ieee.test.sh:
-----------------------------------------------------------
[root@ 20:39:50]# /home/shorty/scripts/ieee.test.sh
+ /bin/sh -nv /home/shorty/scripts/ieee.test.sh
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.sh; \
/home/shorty/scripts/scsi.stop.sh; \
/home/shorty/scripts/scsi.start.sh; \

sleep 2; \
/home/shorty/kernel-factory/git.060822/linux-2.6/scripts/ver_linux; \

cat /dev/null > /var/log/kern.log; \
echo "===> NOW SWITCH ON THE FW DISK <===="; \
sleep 70; \
ls /dev/sda*; \

if [ -f   /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt ]; t
hen
    rm -f /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.when.fw.disk.is.switc
hed.on.txt
    chown shorty.shorty /home/shorty/disable-irm.kern.log.when.fw.disk.is.switch
ed.on.txt
else
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.when.fw.disk.is.switc
hed.on.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.when.fw.disk.is.switc
hed.on.txt
fi

+ /home/shorty/scripts/scsi.stop.sh
+ /bin/sh -n /home/shorty/scripts/scsi.stop.sh
+ rmmod raw1394
ERROR: Module raw1394 does not exist in /proc/modules
+ rmmod eth1394
+ rmmod ohci1394
+ rmmod sbp2
+ rmmod ieee1394
+ /home/shorty/scripts/scsi.start.sh
+ /bin/sh -n /home/shorty/scripts/scsi.start.sh
+ modprobe ieee1394 disable_irm=1
+ sleep 2
+ modprobe ohci1394
+ sleep 2
+ modprobe sbp2
+ sleep 2
+ modprobe raw1394
+ sleep 2
+ chown root.shorty /dev/raw1394
+ sleep 2
+ /home/shorty/kernel-factory/git.060822/linux-2.6/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debby1-6 2.6.18-rc4-ieeeverbose-gef7d1b24-dirty #1 Tue Aug 22 22:18:50 CES
T 2006 ppc GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
pcmcia-cs              3.2.8
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   097
Modules Loaded         raw1394 sbp2 eth1394 ohci1394 ieee1394 bluetooth radeon d
rm nfs nfsd exportfs lockd nfs_acl sunrpc ipv6 therm_adt746x sr_mod cpufreq_powe
rsave cpufreq_performance scsi_mod apm_emu joydev appletouch snd_aoa_codec_onyx 
usbhid snd_aoa_fabric_layout snd_aoa pcmcia firmware_class snd_aoa_i2sbus snd_pc
m_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc sungem sungem_phy pmac_zilo
g serial_core snd ehci_hcd ide_cd evdev uninorth_agp agpgart i2c_powermac ohci_h
cd yenta_socket rsrc_nonstatic pcmcia_core cdrom soundcore snd_aoa_soundbus usbc
ore
+ cat /dev/null
+ echo '===> NOW SWITCH ON THE FW DISK <===='
===> NOW SWITCH ON THE FW DISK <====
+ sleep 70
+ ls '/dev/sda*'
ls: /dev/sda*: No such file or directory
+ '[' -f /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt ']'
+ rm -f /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
+ cp /var/log/kern.log /home/shorty/disable-irm.kern.log.when.fw.disk.is.switche
d.on.txt
+ chown shorty.shorty /home/shorty/disable-irm.kern.log.when.fw.disk.is.switched
.on.txt
[root@ 20:42:36]#
------------------------------------------------------------




########################################################################
*** How 
    disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
    was made
########################################################################

disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
covers one of at least 2 instances when I started gscanbus a few
minutes after failing to connect the firewire disk to the alubook with
the very first script, i.e. ieee.test.sh.
I turned on a bus reset from within gscanbus.

/home/shorty/scripts/ieee.test.with.gscanbus.sh:
-----------------------------------------------------
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.with.gscanbus.sh; \

echo "====> NOW RUN gscanbus ... <====="; \
cat /dev/null > /var/log/kern.log; \
sleep 120; \
ls /dev/sda*; \


if [ -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt ]; then
    rm -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
else
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt
fi



---------------------------


Shell output when running ieee.test.with.gscanbus.sh:
-----------------------------------------
# /home/shorty/scripts/ieee.test.with.gscanbus.sh
+ /bin/sh -nv /home/shorty/scripts/ieee.test.with.gscanbus.sh
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.with.gscanbus.sh; \

echo "====> NOW RUN gscanbus ... <====="; \
cat /dev/null > /var/log/kern.log; \
sleep 120; \
ls /dev/sda*; \


if [ -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connecti
on.txt ]; then
    rm -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connec
tion.txt
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.with.gscanbus.after.f
ailed.fw.connection.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.with.gscanbus.after.f
ailed.fw.connection.txt
else
    cp /var/log/kern.log /home/shorty/disable-irm.kern.log.with.gscanbus.after.f
ailed.fw.connection.txt
    chown shorty.shorty  /home/shorty/disable-irm.kern.log.with.gscanbus.after.f
ailed.fw.connection.txt
fi


+ echo '====> NOW RUN gscanbus ... <====='
====> NOW RUN gscanbus ... <=====
+ cat /dev/null
+ sleep 120
+ ls '/dev/sda*'
ls: /dev/sda*: No such file or directory
+ '[' -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connect
ion.txt ']'
+ rm -f /home/shorty/disable-irm.kern.log.with.gscanbus.after.failed.fw.connecti
on.txt
+ cp /var/log/kern.log /home/shorty/disable-irm.kern.log.with.gscanbus.after.fai
led.fw.connection.txt
+ chown shorty.shorty /home/shorty/disable-irm.kern.log.with.gscanbus.after.fail
ed.fw.connection.txt
[root@ 20:52:04]#
------------------------------------------

3 nodes inside the gscanbus window:


#1:
--------------------------
SelfID Info
-----------
Physical ID: 0
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: No
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

-------------------------


#2:
---------------------
SelfID Info
-----------
Physical ID: 1
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

-------------------------

#3
-----------------------------
SelfID Info
-----------
Physical ID: 2
Link active: No
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: No
Power Class: -1W
Port 0: Not connected
Port 1: Connected to child node
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


--------------------------------


And this was what the xterm was telling from where I ran gscanbus:
------------------------------------------
$ gscanbus
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000494: read failed
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000428: read failed
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff000042c: read failed
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000464: read failed
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
Error while reading from IEEE1394: : Resource temporarily unavailable
1/0x0000fffff0000400: read failed
1/0x0000fffff0000400: wrong bus info block length
--------------------------------------------


HTH

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + + /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
