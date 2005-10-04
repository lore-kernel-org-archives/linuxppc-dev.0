Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk01.marconi.com (smtpoutuk01.marconi.com
	[128.87.251.112]) by ozlabs.org (Postfix) with ESMTP id 60493683F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 16:54:50 +1000 (EST)
Received: from cvdgwy01.uk.marconicomms.com (cvis26.uk.marconicomms.com
	[128.87.251.109])
	by smtpoutuk01.marconi.com (8.12.11/8.12.11) with ESMTP id
	j946siAs021327
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Oct 2005 07:54:44 +0100
	(envelope-from KokHow.Teh@marconi.com)
To: linuxppc-embedded@ozlabs.org
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Tue, 4 Oct 2005 14:54:38 +0800
Message-ID: <OF3208D35D.AA3CBB6C-ON48257090.0019F4B3@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi;
      I have debian linux running on my PQ2FADS-ZU with devfs and seria=
l
driver compiled in. I have read Documentation/serial-console.txt and I =
have
tried both passing "console=3D" option as well as without passing that =
to the
kernel and both don't give me the expected results.
      When I pass "console=3Dtts/0,115200n8" to the kernel, I don't get=
 any
console output until the login prompt which I set to 115200 in
/etc/inittab. When I don't pass "console=3D" option to the kernel, I ge=
t
console output all the way until "Freeing unused kernel memory:" and th=
e
console output is garbled and I don't see any login prompt. Here is the=

/dev/* content:


(none) login:
Debian GNU/Linux 3.1 (none) tts/0
Password:
Last login: Thu Jan  1 02:29:06 1970 on tts/0

The programs included with the Debian GNU/Linux system are free softwar=
e;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
(none):~# l /dev
total 0
crw-------  1 root root 8, 0 Jan  1 02:00 .devfsd
lr-xr-xr-x  1 root root   13 Jan  1 02:37 MAKEDEV -> /sbin/MAKEDEV
crw-------  1 root root 5, 1 Jan  1 02:00 console
drwxr-xr-x  1 root root    0 Jan  1 02:00 discs
crw-rw-rw-  1 root root 1, 7 Jan  1 02:00 full
drwxr-xr-x  1 root root    0 Jan  1 02:00 ide
prw-------  1 root root    0 Jan  1 02:37 initctl
crw-r-----  1 root root 1, 2 Jan  1 02:00 kmem
srw-rw-rw-  1 root root    0 Jan  1 02:37 log
crw-r-----  1 root root 1, 1 Jan  1 02:00 mem
drwxr-xr-x  1 root root    0 Jan  1 02:00 misc
drwxr-xr-x  1 root root    0 Jan  1 02:00 mtd
drwxr-xr-x  1 root root    0 Jan  1 02:00 mtdblock
crw-rw-rw-  1 root root 1, 3 Jan  1 02:00 null
crw-r-----  1 root root 1, 4 Jan  1 02:00 port
crw-rw-rw-  1 root root 5, 2 Jan  1 02:00 ptmx
drwxr-xr-x  1 root root    0 Jan  1 02:00 pts
drwxr-xr-x  1 root root    0 Jan  1 02:00 pty
crw-r--r--  1 root root 1, 8 Jan  1 02:00 random
drwxr-xr-x  1 root root    0 Jan  1 02:00 rd
lr-xr-xr-x  1 root root   33 Jan  1 02:37 root -> ide/host0/bus0/target=
0/lun0/part2
drwxrwxrwt  3 root root   60 Jan  1 02:37 shm
drwxr-xr-x  1 root root    0 Jan  1 02:00 soc
drwxr-xr-x  1 root root    0 Jan  1 02:00 tts
crw-rw-rw-  1 root root 5, 0 Jan  1 02:00 tty
crw-r--r--  1 root root 1, 9 Jan  1 02:37 urandom
prw-r-----  1 root adm     0 Jan  1 02:37 xconsole
crw-rw-rw-  1 root root 1, 5 Jan  1 02:00 zero
(none):~#

      This is what I end up without "console=3D" option passed to the k=
ernel:

<snip>
Mounted devfs on /dev
Freeing unused kernel memory: 232k init 4k prep
..=EF=BF=BD=EF=BF=BD=EF=BF=BD.=EF=BF=BD...=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD.=EF=BF=BD=EF=BF=BD.=EF=BF=BD=
...=EF=BF=BD...=EF=BF=BD=EF=BF=BD=EF=BF=BD......=EF=BF=BD..=EF=BF=BD...=
=EF=BF=BD=EF=BF=BD=EF=BF=BD..=EF=BF=BD.=EF=BF=BD.=EF=BF=BD=EF=BF=BD.=EF=
=BF=BD=EF=BF=BD.....=EF=BF=BD=EF=BF=BD[42;124H.
 <no login prompt>

      My question is, how can I get a complete serial console output al=
l
the way from bootup to the login prompt? I am missing something. It is
either the kernel configuration or I have to tweak the codes somewhere.=
 Any
input and insight is appreciated.

Regards,
TEH
=
