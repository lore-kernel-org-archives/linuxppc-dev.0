To: linuxppc-dev@lists.linuxppc.org
Subject: /etc/power/pwrctrl patch (iBook, improved ifconfig)
From: Henner Eisen <eis@baty.hanse.de>
Date: 09 Dec 2000 18:23:41 +0100
In-Reply-To: Andi Kleen's message of "Fri, 8 Dec 2000 18:42:28 +0100"
Message-ID: <oupuj1pkyq.fsf@baty.hanse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The following patch for the pmud-0.7 /etc/etc/power/pwrctl script

- adds iBook support
- improves (IMHO ;) ifconfig up/down usage inside pwrctl_3400 function

It just uses the pwrctl_3400 handler when the PMU_VERSION indicates an
iBook. I think as long as sleep is not supported for the iBook, the pwrctl
script does not need any special iBook handler.

However, the pwrctl_3400 handler does an `ifconfig down' when system
is on battery such that nap mode can be enabled. I was bored by this
because whenever unplugging ac, network connections are lost.

The change is based on the assuption that, when operating the computer
in an environment where networking is not needed, eth0 is down
anyway (e.g., because in such a case, the user will only boot into
a runlevel without external networking).

Thus, when on battery, the changed script just determines whether eth0
is up. If so, nothing dma-related is changed and the cpu remains in the
default mode. Only if eth0 is already down, then hd dma is disabled
and the cpu is switched to nap mode.

Further, before sleep (not tested as not supported on iBook), the ifconfig
up/down state is stored on disk such that it can be restored after
wake up.


Henner


--- pwrctl.orig	Mon Oct  9 16:33:47 2000
+++ pwrctl	Sat Dec  9 17:19:24 2000
@@ -33,6 +33,8 @@
 # as that file will not be overwritten on upgrades.
 # -----------------------------------------------------------------------------
 # $Log: pwrctl,v $
+# iBook support and conditional ifconfig up|down (Henner Eisen)
+#
 # Revision 1.5  2000/10/09 14:33:40  stephan
 # wakebay added
 #
@@ -51,6 +53,11 @@
 logger=/usr/bin/logger
 localfun=/etc/power/pwrctl-local

+function eth0_is_up()
+{
+	ifconfig eth0 | grep 'UP' > /dev/null 2>&1
+}
+
 function do_warn()
 {
 	local msg="Low battery, system will go down..."
@@ -123,16 +130,21 @@
 {
 	case "$1" in
 	minimum)
- 	   	ifconfig eth0 down
-    		hdparm -d0 -S 12 /dev/hda
-    		hdparm -d0 /dev/hdc
-    		echo 1 >/proc/sys/kernel/powersave-nap
+		if eth0_is_up; then
+#			$logger -p daemon.info -t pwrctl "$0: no nap mode because eth0 needs DMA"
+			echo 0 >/proc/sys/kernel/powersave-nap
+			hdparm -d1 -p -S 12 /dev/hda
+			hdparm -d1 /dev/hdc
+		else
+			hdparm -d 0 -S 12 /dev/hda
+			hdparm -d 0 /dev/hdc
+			echo 1 >/proc/sys/kernel/powersave-nap
+		fi
     	;;
 	medium)
     		echo 0 >/proc/sys/kernel/powersave-nap
     		hdparm -d1 -p -S 12 /dev/hda
     		hdparm -d1 /dev/hdc
-    		ifconfig eth0 up
     	;;
 	maximum)
     		echo 0 >/proc/sys/kernel/powersave-nap
@@ -147,16 +159,25 @@
 		;;
 		esac
     		hdparm -d1 /dev/hdc
-    		ifconfig eth0 up
     	;;
 	warning)
 		do_warn
 	;;
 	sleep)
-    		ifconfig eth0 down
+		if eth0_is_up; then
+			echo "up" > /var/pmud/eth0_state
+			$logger -p daemon.info -t pwrctl "$0: ifconfig'ing eth0 down for sleep"
+			ifconfig eth0 down
+		else
+			echo "down" > /var/pmud/eth0_state
+		fi
     	;;
 	wakeup)
-    		ifconfig eth0 up
+		if [ X`cat /var/pmud/eth0_state` = Xup ]; then
+			$logger -p daemon.info -t pwrctl "$0: ifconfig'ing eth0 up after sleep"
+			ifconfig eth0 up
+#			XXX we still need to reset other stuff (like routes).
+		fi
 	;;
 	*)
 		$logger -p daemon.error -t pwrctl "$0: invalid arg $1"
@@ -190,6 +211,7 @@
 case "$PMUVERSION" in
 9)	pwrctl_3400 $1 $2 ;;
 10|11)	pwrctl_G3   $1 $2 ;;
+12)	pwrctl_3400 $1 $2 ;;
 *)
 	$logger -p daemon.error -t pwrctl "no function for PMU $PMUVERSION"
 ;;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
