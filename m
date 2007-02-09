Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 4A90BDDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Feb 2007 07:58:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Cross compile GDB 6.6 error
Date: Fri, 9 Feb 2007 15:45:57 -0500
Message-ID: <3C02138692C13C4BB675FE7EA2409529297D30@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

Hey guys,

I am trying to build a native GDB to run on my powerpc-405 target. To do
this, I run the configure script in gdb-6.6 as such
./configure --build=3Di386-linux-gnu --target=3Dpowerpc-405-linux-gnu
--host=3Dpowerpc-405-linux-gnu
Now beforehand, I tried building this, and the make would always fail
with the error "No Termcap Library found". After finding out that the
--builduserland option is broken, I tried cross-compiling ncurses
manually. After doing that, I moved the contents of the  ../ncurses/lib
directory into the directory containing libc.a in my cross-compiler
directory. Now when I build GDB, I get this output


powerpc-405-linux-gnu-gcc -c -g -O2 -I. -I.././gdb -I.././gdb/config
-LOCALEDIR=3D"\"/usr/local/share/locale\"" -DHAVE_CONFIG_H
-I.././gdb/../include/opcode -I.././gdb/../readline/..-I../bfd
-I.././gdb/../bfd -I.././gdb/../include -DMI_OUT=3D1 -DTUI=3D1=20
-Wimplicit -Wreturn-type -Wcomment -Wtrigraphs -Wformat -Wparentheses
-Wpointer-arith -Wformat-nonliteral -Wunused-label -Wunused-function
-Wuninitialized .././gdb/tui/tui-command.c=20

In file included from .././gdb/tui/tui-command.c:28:
./tui/tui-data.h:40: error: parse error before "WINDOW"
./tui/tui-data.h:40: warning: no semicolon at end of struct or union
./tui/tui-data.h:52: error: parse error before '}' token
./tui/tui-data.h:228: error: field `data_window' has incomplete type
./tui/tui-data.h:282: error: field `generic' has incomplete type In file
included from .././gdb/tui/tui-command.c:29:
./tui/tui-win.h:42: error: parse error before "tui_border_ulcorner"
./tui/tui-win.h:42: warning: type defaults to `int' in declaration of
`tui_border_ulcorner'
./tui/tui-win.h:42: warning: data definition has no type or storage
class
./tui/tui-win.h:43: error: parse error before "tui_border_urcorner"
./tui/tui-win.h:43: warning: type defaults to `int' in declaration of
`tui_border_urcorner'
./tui/tui-win.h:43: warning: data definition has no type or storage
class
./tui/tui-win.h:44: error: parse error before "tui_border_lrcorner"
./tui/tui-win.h:44: warning: type defaults to `int' in declaration of
`tui_border_lrcorner'
./tui/tui-win.h:44: warning: data definition has no type or storage
class
./tui/tui-win.h:45: error: parse error before "tui_border_llcorner"
./tui/tui-win.h:45: warning: type defaults to `int' in declaration of
`tui_border_llcorner'
./tui/tui-win.h:45: warning: data definition has no type or storage
class
./tui/tui-win.h:46: error: parse error before "tui_border_vline"
./tui/tui-win.h:46: warning: type defaults to `int' in declaration of
`tui_border_vline'
./tui/tui-win.h:46: warning: data definition has no type or storage
class
./tui/tui-win.h:47: error: parse error before "tui_border_hline"
./tui/tui-win.h:47: warning: type defaults to `int' in declaration of
`tui_border_hline'
./tui/tui-win.h:47: warning: data definition has no type or storage
class
.././gdb/tui/tui-command.c: In function `tui_dispatch_ctrl_char':
.././gdb/tui/tui-command.c:80: error: `WINDOW' undeclared (first use in
this function)
.././gdb/tui/tui-command.c:80: error: (Each undeclared identifier is
reported only once
.././gdb/tui/tui-command.c:80: error: for each function it appears in.)
.././gdb/tui/tui-command.c:80: error: `w' undeclared (first use in this
function)
.././gdb/tui/tui-command.c:85: warning: implicit declaration of function
`wgetch'
.././gdb/tui/tui-command.c:86: error: `ERR' undeclared (first use in
this function)
.././gdb/tui/tui-command.c:93: error: `KEY_PPAGE' undeclared (first use
in this function)
.././gdb/tui/tui-command.c:95: error: `KEY_NPAGE' undeclared (first use
in this function)
.././gdb/tui/tui-command.c:113: error: `KEY_DOWN' undeclared (first use
in this function)
.././gdb/tui/tui-command.c:114: error: `KEY_SF' undeclared (first use in
this function)
.././gdb/tui/tui-command.c:117: error: `KEY_UP' undeclared (first use in
this function)
.././gdb/tui/tui-command.c:118: error: `KEY_SR' undeclared (first use in
this function)
.././gdb/tui/tui-command.c:121: error: `KEY_RIGHT' undeclared (first use
in this function)
.././gdb/tui/tui-command.c:124: error: `KEY_LEFT' undeclared (first use
in this function)
make[2]: *** [tui-command.o] Error 1
make[2]: Leaving directory `/home/cthomas/gdb-6.6/gdb'
make[1]: *** [all-gdb] Error 2
make[1]: Leaving directory `/home/cthomas/gdb-6.6'
make: *** [all] Error 2

I've been looking around the mailing lists, it seems like the problem is
related to ncurses, but I am unsure of what I am doing wrong, as I have
not found a good solution to my problem of building GDB to run native on
my target.

Clinton Thomas
