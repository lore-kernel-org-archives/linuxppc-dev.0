Message-Id: <200110111652.LAA06692@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: "Boerner, Brian" <bmb@pirus.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Menuconfig choking on undefined reference to `acs_map'
Date: Thu, 11 Oct 2001 12:56:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Looks like somewhere between 5.2.2 and 5.2.7 the acs_map symbol changed from
global to local. I'll try and install 5.2.2 again and see what happens.

-bmb


> -----Original Message-----
> From: Boerner, Brian [mailto:bmb@pirus.com]
> Sent: Thursday, October 11, 2001 11:07 AM
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Menuconfig choking on undefined reference to `acs_map'
>
>
>
> So, this is a really stupid question, but it looks like menuconfig is
> failing all of a sudden. I say that because this used to work fine.
> Unfortunately this system is used by a number of people and
> what happens to
> it is out of my control. So it's failing to find the acs_map
> symbol in the
> libncurses.a library. A quick look at libncurses.a shows that it does
> exists:
>
> $ nm -v libncurses.a | grep acs
>          U _acs_mapf
>          U _acs_mapf
>          U __nc_init_acs
>          U _acs_mapf
>          U _acs_mapf
> lib_acs.o:
> 00000000 d _acs_map
> 00000000 T _acs_mapf
> 0000000c T __nc_init_acs
> 00001174 t _append_acs0
> 000011a4 t _append_acs
>
> I've even tried just adding /lib/libncurses.a instead of
> using -lncurses,
> but it's still busted. I'm sure there is a simple solution to
> this that I'm
> just not seeing. Can someone give me a clue; I feel like it's Monday.
>
> Compiler output follows...
>
> -bmb
>
>
> $ make menuconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-ppc asm)
> make -C scripts/lxdialog all
> make[1]: Entering directory
> `/views/bmb_linux_dbg2/LINUX/linuxppc/linux-2.4.1-pre10/script
> s/lxdialog'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o
> checklist.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o
> menubox.o menubox.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o
> textbox.o textbox.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o
> yesno.o yesno.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o inputbox.o
> inputbox.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o util.o util.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o lxdialog.o
> lxdialog.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o
> msgbox.o msgbox.c
> gcc -o lxdialog checklist.o menubox.o textbox.o yesno.o
> inputbox.o util.o
> lxdialog.o msgbox.o -lncurses
> Warning: resolving _COLS by linking to __imp__COLS (auto-import)
> Warning: resolving _LINES by linking to __imp__LINES (auto-import)
> Warning: resolving _stdscr by linking to __imp__stdscr (auto-import)
> checklist.o(.text+0x174):checklist.c: undefined reference to `acs_map'
> checklist.o(.text+0x1a0):checklist.c: undefined reference to `acs_map'
> checklist.o(.text+0x1af):checklist.c: undefined reference to `acs_map'
> checklist.o(.text+0x1be):checklist.c: undefined reference to `acs_map'
> checklist.o(.text+0x1d0):checklist.c: undefined reference to `acs_map'
> checklist.o(.text+0x213):checklist.c: more undefined
> references to `acs_map'
> follow
> collect2: ld returned 1 exit status
> make[1]: *** [lxdialog] Error 1
> make[1]: Leaving directory
> `/views/bmb_linux_dbg2/LINUX/linuxppc/linux-2.4.1-pre10/script
> s/lxdialog'
> make: *** [menuconfig] Error 2
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
