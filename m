Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 0102ADDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 06:28:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Change console port after boot
Date: Fri, 14 Sep 2007 15:28:18 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0360A07C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi..

Does anybody know if there is a way to change the console port after
linux has started?

I have a serial port cosole (82xx, ttyCPM0), that is used for initial
console.
After the system is booted, there are times where I need to use that
serial port to talk to some equipment.
My problem is that I get output from kernel/init and other things that
have the console open also.

Right now I kill the login process on the serial port, set
/proc/sys/kernel/printk to "0 0 0 0" and try to find anything with
/dev/console open and kill them.

This does work, but not always.=20
What I'd like to do is be able to shut off all output from /dev/console
and kernel so only /dev/ttyCPM0 works.

This is the script I use now:
#!/bin/sh

# turn off serial login shell
echo 0 0 0 0 > /proc/sys/kernel/printk

sed -ri "s/^(::askfirst)/#\1/; s|(^ttyCPM0::respawn:).*$|#\1-/bin/sh|;"
/etc/inittab
init -q

PIDS=3D`ps | sed -nr "s|^ *([0-9]+) .*[-/]sh *$|\1|p"`

for p in ${PIDS}
do
        #echo ${p}
        OUT=3D`ls -l /proc/${p}/fd/0 | grep console`

        #echo ${OUT}
        if [ "${OUT}" !=3D "" ]
        then
                #echo send kill to pid ${p}
                kill -9 ${p}
        fi

        OUT=3D`ls -l /proc/${p}/fd/0 | grep ttyCPM0`

        #echo ${OUT}
        if [ "${OUT}" !=3D "" ]
        then
                #echo send kill to pid ${p}
                kill -9 ${p}
        fi
done

sleep 1
echo "Use ~ to enter menu"
echo "~tm changes linefeed mode"
echo "~x  exits"
microcom -D/dev/ttyCPM0
echo 7 4 1 7 > /proc/sys/kernel/printk

# turn login shell back on
sed -ri "s|#(ttyCPM0)|\1|;" /etc/inittab
init -q
