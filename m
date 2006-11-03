Return-Path: <vantranbk@yahoo.com.au>
Received: from web33012.mail.mud.yahoo.com (web33012.mail.mud.yahoo.com
	[209.191.69.127]) by ozlabs.org (Postfix) with SMTP id 6C84C67C94
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Nov 2006 01:27:59 +1100 (EST)
Message-ID: <20061103142757.35508.qmail@web33012.mail.mud.yahoo.com>
Date: Sat, 4 Nov 2006 01:27:57 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Not show login correct
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2072564607-1162564077=:34519"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2072564607-1162564077=:34519
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
I have just build kernel and ramdisk for TQM8xxL success. But when I login I receive 
[root@h W] , my hostname is van and current directory is /root/bin ,May I receive [root@van bin]
Here is my /etc/inittab and /etc/profile

#/etc/inittab
/////////////////////////////////////////////////////////////

 This is run first except when booting in single-user mode.
::sysinit:/etc/rc.sh
#::sysinit:/etc/rc.sysinit
# /bin/sh invocations on selected ttys
#
# Start an "askfirst" shell on /dev/ttyS1
::respawn:/sbin/getty -L 115200 ttyS0 ansi
# ansi
#
# Start internet super daemon; do NOT background!
#::respawn:/usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xinetd.pid

# Start user application
#::respawn:/bin/application
# Must be last 'respawn' entry to avoid ^C problem
# Start a shell on the console
#::respawn:-/bin/sh

# /etc/profile
//////////////////////////////////////////////////////////////
#echo Exec "/etc/profile" Dir `pwd`

# System wide environment and startup programs
# Functions and aliases go in /etc/bashrc

#alias rm='rm -i'
#alias w='w -u'
HOSTNAME=`/bin/hostname`
PS1="[$USER@\h \W]\\$ "

#ulimit -c 1000000
if [ `id -gn` = `id -un` -a `id -u` -gt 14 ]; then
        umask 002
else
        umask 022
fi

USER=`id -un`
LOGNAME=$USER
MAIL="/var/spool/mail/$USER"

HISTSIZE=1000
HISTFILESIZE=1000

if [ -e /etc/TIMEZONE ]; then
        TZ=`cat /etc/TIMEZONE`; export TZ
else
        unset TZ
fi

INPUTRC=/etc/inputrc
PATH=$PATH:/usr/local/bin

export PATH HOSTNAME HISTSIZE HISTFILESIZE USER LOGNAME MAIL INPUTRC PS1

/////////////////////////////////////////////////////////////////////////

//etc/rc.sh
//////////////////////////////////////////////////////////
#!/bin/sh

/sbin/ifconfig lo 127.0.0.1

>/etc/mtab

# mount /proc so "reboot" works
/bin/mount -t proc proc /proc

## try mount PC Card partition
##
## mount read-only by default to prevent corruption
##
#echo /dev/hda1 /mnt >>/etc/fstab
#mkdir -p /mnt
#mount -o ro /dev/hda1 /mnt
#
## run PC Card init script if it exists
#if [ -f /mnt/run.sh ] ; then
#/mnt/run.sh
#fi
/usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xinetd.pid


 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-2072564607-1162564077=:34519
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>I have just build kernel and ramdisk for TQM8xxL success. But when I login I receive <br>[root@h W] , my hostname is van and current directory is /root/bin ,May I receive [root@van bin]<br>Here is my /etc/inittab and /etc/profile<br><br>#/etc/inittab<br>/////////////////////////////////////////////////////////////<br><br>&nbsp;This is run first except when booting in single-user mode.<br>::sysinit:/etc/rc.sh<br>#::sysinit:/etc/rc.sysinit<br># /bin/sh invocations on selected ttys<br>#<br># Start an "askfirst" shell on /dev/ttyS1<br>::respawn:/sbin/getty -L 115200 ttyS0 ansi<br># ansi<br>#<br># Start internet super daemon; do NOT background!<br>#::respawn:/usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xinetd.pid<br><br># Start user application<br>#::respawn:/bin/application<br># Must be last 'respawn' entry to avoid ^C problem<br># Start a shell on the console<br>#::respawn:-/bin/sh<br><br>#
 /etc/profile<br>//////////////////////////////////////////////////////////////<br>#echo Exec "/etc/profile" Dir `pwd`<br><br># System wide environment and startup programs<br># Functions and aliases go in /etc/bashrc<br><br>#alias rm='rm -i'<br>#alias w='w -u'<br>HOSTNAME=`/bin/hostname`<br>PS1="[$USER@\h \W]\\$ "<br><br>#ulimit -c 1000000<br>if [ `id -gn` = `id -un` -a `id -u` -gt 14 ]; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umask 002<br>else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umask 022<br>fi<br><br>USER=`id -un`<br>LOGNAME=$USER<br>MAIL="/var/spool/mail/$USER"<br><br>HISTSIZE=1000<br>HISTFILESIZE=1000<br><br>if [ -e /etc/TIMEZONE ]; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TZ=`cat /etc/TIMEZONE`; export TZ<br>else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unset TZ<br>fi<br><br>INPUTRC=/etc/inputrc<br>PATH=$PATH:/usr/local/bin<br><br>export PATH HOSTNAME HISTSIZE HISTFILESIZE USER LOGNAME MAIL INPUTRC
 PS1<br><br>/////////////////////////////////////////////////////////////////////////<br><br>//etc/rc.sh<br>//////////////////////////////////////////////////////////<br>#!/bin/sh<br><br>/sbin/ifconfig lo 127.0.0.1<br><br>&gt;/etc/mtab<br><br># mount /proc so "reboot" works<br>/bin/mount -t proc proc /proc<br><br>## try mount PC Card partition<br>##<br>## mount read-only by default to prevent corruption<br>##<br>#echo /dev/hda1 /mnt &gt;&gt;/etc/fstab<br>#mkdir -p /mnt<br>#mount -o ro /dev/hda1 /mnt<br>#<br>## run PC Card init script if it exists<br>#if [ -f /mnt/run.sh ] ; then<br>#/mnt/run.sh<br>#fi<br>/usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xinetd.pid<br><br><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-2072564607-1162564077=:34519--
