Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav18.bay1.hotmail.com [65.54.244.122])
	by ozlabs.org (Postfix) with ESMTP id 2C65567A30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 00:47:02 +1100 (EST)
Message-ID: <BAY1-DAV187A9A9A5B15B2CB86F14D8B7D0@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Embedded TUX" <etux@embeddedtux.org>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Tue, 1 Feb 2005 19:17:02 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problem with getty and telnetd
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I am running a Linux 2.6.10 kernel on an MPC8260 target. I have Busybox 1.0
installed on top of the Linux kernel.

Problem 1: getty ------------------------------------------

I wish to put in place a login system on my system console (ttyCPM). For
this, I add the following line to /etc/inittab:

::respawn:/sbin/getty -L 57600 ttyCPM

On the subsequent login, I find that the system goes totally haywire! It
keeps displaying the login prompt again and again, and doesn't accept the
user ID and password I give, saying:

# /:
(none) login: root
/bin/sh: root: No such file.

I am unable to do anything after this, as the login prompt keeps popping up
everytime I enter a command. After a while the console gets stuck.

However, if I remove the above line from /etc/inittab and execute the getty
process directly from the command prompt, everything works just fine!

# /: getty -L 57600 ttyCPM
(none) login: root
password:

BusyBox 1.00 xxxxxxxxxxx (BusyBox string)

~ /: pwd
/root

Also, if I add a line to /etc/inittab as follows:

s1:2345:/sbin/getty -L 57600 ttyCPM

then upon the subsequent boot, I can see the getty process in the list of
running processes (by giving the ps command). However, I don't get any login
prompt.

Please explain what the problem could be. I don't have any other relevant
files in /etc. Do I need to add any other files (other than the getty entry
in inittab) for getty to work ok?

Problem 2: telnetd ------------------------------------------

To implement a telnet host on my target, I run the telnetd process from the
target. All is fine at first sight - I can connect from a remote host, the
login prompt is displayed fine (and WORKS here!) and it SEEMS as if I can
use the system normally.

HOWEVER, the problem comes when I try a ls command or try to view a file
with vi. If I do a ls on a directory with several files, the telnet terminal
on the remote host gets stuck after displaying a few entries. There's only
two ways to recover: close the terminal window on the host or kill the 'ash'
shell process on the target with 'kill -HUP process_id'.

Why could this be happening? Is there some buffer setting that I need to
address? Or something else that I'm missing? Please help!!!

Regards

Vijay Padiyar
