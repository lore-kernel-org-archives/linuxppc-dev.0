Date: Tue, 16 Mar 2004 23:09:25 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Random crashes on snooze
Message-Id: <20040316230925.15bfe069.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know I don't contribute much here but I just can't seem to find any clue
about what is happening.  So I need help.

I just upgraded to Yellow Dog 3.0.  Since doing so I have experienced seemingly
random crashes when I issue a "snooze" command "/sbin/snooze".

Here are machine specs:

14:29:54 > rpm -qa | grep pmud
pmud-0.10-3f

14:30:00 > uname -a
Linux batwing2 2.4.25-ben1-sleep-debug #15 Tue Mar 16 11:29:56 PST 2004 ppc ppc ppc GNU/Linux

14:31:54 > cat /proc/cpuinfo
processor       : 0
cpu             : 7410
clock           : 500MHz
revision        : 17.3 (pvr 800c 1103)
bogomips        : 996.14
machine         : PowerBook3,2
motherboard     : PowerBook3,2 MacRISC2 MacRISC Power Macintosh
board revision  : 00000001
detected as     : 71 (PowerBook Titanium)
pmac flags      : 0000000b
L2 cache        : 1024K unified
memory          : 512MB
pmac-generation : NewWorld


I put some debug messages in the sleep code and I think it might have something
to do with the awacs sound driver.

>From /var/log/messages on a bad sleep:

Mar 16 17:49:15 batwing2 kernel: IKW sleep 1 calling c03b5ff4 (c020cae0)
Mar 16 17:49:15 batwing2 kernel: aty128fb: aty128_sleep_notify when 1 board c1ab1800
Mar 16 17:49:16 batwing2 kernel: IKW sleep 1 accepted by c03b5ff4 (c020cae0)
Mar 16 17:49:16 batwing2 kernel: IKW Sync disks
Mar 16 17:49:16 batwing2 kernel: IKW sleep 2 calling c03868ec (c01d1b6c)
Dec 31 20:53:02 batwing2 syslogd 1.4.1: restart.

>From System.map
c01d1b6c t awacs_sleep_notify

But I don't know if there is something missing from the file because of course
nothing can be written to the disk at this time...  Does anyone have any other
clues?


Thanks,
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
