Message-ID: <3810680B.51E0FABD@iname.com>
Date: Fri, 22 Oct 1999 14:35:07 +0100
From: Jim Chapman <jim.chapman@xstreamis.com>
MIME-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: bypassing MacOS using Open Firmware on Apple pmac G3
Content-Type: multipart/mixed;
 boundary="------------7487E4CCC787020C9CF54289"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------7487E4CCC787020C9CF54289
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have an Apple PowerMAC G3 and I currently boot Linux via MacOS using
BootX. I am trying to configure the Open Firmware (OF) NVRAM settings
such that Linux is booted by default, but I can't make it work Can
anyone help?

I have 2 IDE disks. ide0 is used by MacOS and ide1 is for Linux. The
root partition is on ide1 (hdb5).

I followed instructions in the LinuxPPC Installation Guide but when I
try to boot, OF displays

boot MAC-PARTS: LOAD (interposed) not supported load-size=0 adler32=1

What is this message telling me? Is the machine still trying to boot
MacOS?

I set the following variables using the OF "setenv" command:-

boot-device    ide1/disk@0:5
boot-file    ide1/disk@0:5/boot/vmlinux root=/dev/hdb5 hda=noautotune
hdb=noautotune
boot-command    dev ide1 cr set-timeout 0 cr boot
load-base    0x100000 (and 0x4000, 0x60000, 0x10000...)

I guessed that ide1, partition 5 would be represented as ide1/disk@0:5.
What does that @0 represent?
Perhaps I need to set other variables?

OF displays its versions as PowerMAC1, 1 1.1f1, Open Firmware 3.1.1.

I also noticed that the LinuxPPC "nvsetenv" command doesn't display that
variable values as listed above. Effectively, any changes to boot
variables I make with "nvsetenv" seem to be localised to the Linux
environment; they are remembered between reboots, but the values are
different to those displayed by the OF "printenv" command. It's as if
the OF "setenv" command and linux "nvsetenv" command modify different
copies of the parameters in NVRAM!!!! Is anyone else seeing this?

Thanks

    Jim Chapman


--------------7487E4CCC787020C9CF54289
Content-Type: text/x-vcard; charset=us-ascii;
 name="jim.chapman.vcf"
Content-Description: Card for Jim Chapman
Content-Disposition: attachment;
 filename="jim.chapman.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard 
n:Chapman;Jim
tel;fax:+44-1865-784004
tel;work:+44-1865-784569
x-mozilla-html:TRUE
url:http://www.xstreamis.com
org:Xstreamis plc;R&D
version:2.1
email;internet:jim.chapman@xstreamis.com
title:Principal Engineer
adr;quoted-printable:;;Magdalen Centre=0D=0AOxford Science Park;OXFORD;OXON;RG8 0ND;ENGLAND
fn:Jim Chapman
end:vcard

--------------7487E4CCC787020C9CF54289--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
