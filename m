Return-Path: <dieter.wirtz@gmx.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id ED8152BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 06:45:30 +1100 (EST)
Message-ID: <41A24026.5070908@gmx.net>
Date: Mon, 22 Nov 2004 20:38:14 +0100
From: Dieter Wirtz <dieter.wirtz@gmx.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: compiling ELDK3 microwindows source paket
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I want to rebuild the ELDK3 (www.denx.de) microwindows source paket 
(host system: i386 pc running SUSE 9.0; target system: embedded ppc405; 
CROSS_COMPILE=ppc_4xx-).

For it I installed the source in the ELDK3 directory and tried to 
rebuild the paket with  ${CROSS_COMPILE}rpmbuild -ba microwindows.spec. 
This gave some errors because the host and not the cross compiler was used.

After I changed the file microwindows-0.90-config.ppc.patch from
...
-POWERPCTOOLSPREFIX       = powerpc-linux-
+POWERPCTOOLSPREFIX       =
  SHTOOLSPREFIX            = sh-linux-gnu
...
to
...
-POWERPCTOOLSPREFIX       = powerpc-linux-
+POWERPCTOOLSPREFIX       = ppc_4xx-
  SHTOOLSPREFIX            = sh-linux-gnu
...
the command make use of the cross tools.


Now it rebuild the rpm paket but the strip command gives the warning:
strip: Warning: Output file cannot represent architecture UNKNOWN!
and the programms are not executable (on the ppc405 board) after 
installing the rpm paket.


What can it be?


Regards,

Dieter




Here an extract from the build process:


wi@wi2:~/PPC/ELDK3/usr/src/denx/SPECS> ${CROSS_COMPILE}rpmbuild -ba 
microwindows.spec
Executing(%prep): /bin/sh -e /home/wi/PPC/ELDK3/var/tmp/rpm-tmp.50044
+ umask 022
+ cd /home/wi/PPC/ELDK3/usr/src/denx/BUILD
+ cd /home/wi/PPC/ELDK3/usr/src/denx/BUILD
+ rm -rf microwindows-0.90
+ /bin/gzip -dc 
/home/wi/PPC/ELDK3/usr/src/denx/SOURCES/microwindows-0.90.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd microwindows-0.90
+ echo 'Patch #0 (microwindows-0.90-noroot.patch):'
Patch #0 (microwindows-0.90-noroot.patch):
+ patch -p1 -s
+ echo 'Patch #1 (microwindows-0.90-bugfix.ppc.patch):'
Patch #1 (microwindows-0.90-bugfix.ppc.patch):
+ patch -p1 -s
+ echo 'Patch #2 (microwindows-0.90-config.ppc.patch):'
Patch #2 (microwindows-0.90-config.ppc.patch):
+ patch -p1 -s
+ echo 'Patch #3 (microwindows-0.90_thick_lines.patch):'
Patch #3 (microwindows-0.90_thick_lines.patch):
+ patch -p1 -s
+ echo 'Patch #4 (microwindows-0.90-stretch.patch):'
Patch #4 (microwindows-0.90-stretch.patch):
+ patch -p1 -s
+ echo 'Patch #5 (microwindows-0.90-tsc2000.patch):'
Patch #5 (microwindows-0.90-tsc2000.patch):
+ patch -p1 -s
+ echo 'Patch #6 (microwindows-0.90-config-fonts.patch):'
Patch #6 (microwindows-0.90-config-fonts.patch):
+ patch -p1 -s
+ echo 'Patch #7 (microwindows-0.90-mtest-fix.patch):'
Patch #7 (microwindows-0.90-mtest-fix.patch):
+ patch -p1 -s
+ exit 0
Executing(%build): /bin/sh -e /home/wi/PPC/ELDK3/var/tmp/rpm-tmp.89079
+ umask 022
+ cd /home/wi/PPC/ELDK3/usr/src/denx/BUILD
+ cd microwindows-0.90
+ cd src
+ HOSTCC=/usr/bin/gcc -B/usr/bin/
+ make -e
make -C drivers
make[1]: Entering directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers'
Updating dependencies in 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers ...
/bin/sh -ec '/usr/bin/gcc -B/usr/bin/ -MM 
-DMWPIXEL_FORMAT=MWPF_TRUECOLOR565 -DVTSWITCH=1 -DHAVE_FILEIO 
-DHAVE_FNT_SUPPORT=1 -DFNT_FONT_DIR="\""/usr/microwindows-fonts/bdf""\" 
-DHAVE_PCF_SUPPORT=1 -DPCF_FONT_DIR="\""/usr/microwindows-fonts/pcf""\" 
-DHAVE_HZK_SUPPORT=1 
-DHZK_FONT_DIR="\""/usr/microwindows-fonts/chinese""\" 
-DHAVE_EUCJP_SUPPORT=1 
-DEUCJP_FONT_DIR=\""/usr/microwindows-fonts/japanese"\" 
-DHAVE_BMP_SUPPORT=1 -DHAVE_GIF_SUPPORT=1 -DHAVE_PNM_SUPPORT=1 
-DHAVE_XPM_SUPPORT=1 -DHAVETEXTMODE=1 -DTHREADSAFE=1 -DERASEMOVE=1 
-DUPDATEREGIONS=1 -DDEBUG=1 -DLINUX=1 -DUNIX=1 -DARCH_LINUX_POWERPPC=1 
-DMW_CPU_BIG_ENDIAN=1 -I. 
-I/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/include 
fblin8.c fblin16.c fblin24.c fblin32.c fblin32alpha.c genmem.c fb.c 
fblin1.c fblin2.c genfont.c scr_fb.c fbportrait_left.c 
fbportrait_right.c fbportrait_down.c fblin4.c vtswitch.c mou_ser.c 
kbd_tty.c \
| sed '\''s/\(\)\.o[ :]*/\1.o \.depend : $(TOP)\/config /g'\'' > .depend; \
[ -s .depend ] || rm -f .depend'
make[1]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers'
make[1]: Entering directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers'
Compiling fblin8.c ...
ppc_4xx-gcc -c -DMWPIXEL_FORMAT=MWPF_TRUECOLOR565 -DVTSWITCH=1 
-DHAVE_FILEIO -DHAVE_FNT_SUPPORT=1 
-DFNT_FONT_DIR="\""/usr/microwindows-fonts/bdf""\" -DHAVE_PCF_SUPPORT=1 
-DPCF_FONT_DIR="\""/usr/microwindows-fonts/pcf""\" -DHAVE_HZK_SUPPORT=1 
-DHZK_FONT_DIR="\""/usr/microwindows-fonts/chinese""\" 
-DHAVE_EUCJP_SUPPORT=1 
-DEUCJP_FONT_DIR=\""/usr/microwindows-fonts/japanese"\" 
-DHAVE_BMP_SUPPORT=1 -DHAVE_GIF_SUPPORT=1 -DHAVE_PNM_SUPPORT=1 
-DHAVE_XPM_SUPPORT=1 -DHAVETEXTMODE=1 -DTHREADSAFE=1 -DERASEMOVE=1 
-DUPDATEREGIONS=1 -DDEBUG=1 -DLINUX=1 -DUNIX=1 -DARCH_LINUX_POWERPPC=1 
-DMW_CPU_BIG_ENDIAN=1 -fpic -I. 
-I/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/include 
-msoft-float -Wall -Wpointer-arith -O3 -ggdb -o fblin8.o fblin8.c
Compiling fblin16.c ...

...

Compiling nanox.c ...
ppc_4xx-gcc -c  -DNANOX=1 -DMWPIXEL_FORMAT=MWPF_TRUECOLOR565 
-DVTSWITCH=1 -DHAVE_FILEIO -DHAVE_FNT_SUPPORT=1 
-DFNT_FONT_DIR="\""/usr/microwindows-fonts/bdf""\" -DHAVE_PCF_SUPPORT=1 
-DPCF_FONT_DIR="\""/usr/microwindows-fonts/pcf""\" -DHAVE_HZK_SUPPORT=1 
-DHZK_FONT_DIR="\""/usr/microwindows-fonts/chinese""\" 
-DHAVE_EUCJP_SUPPORT=1 
-DEUCJP_FONT_DIR=\""/usr/microwindows-fonts/japanese"\" 
-DHAVE_BMP_SUPPORT=1 -DHAVE_GIF_SUPPORT=1 -DHAVE_PNM_SUPPORT=1 
-DHAVE_XPM_SUPPORT=1 -DHAVETEXTMODE=1 -DTHREADSAFE=1 -DERASEMOVE=1 
-DUPDATEREGIONS=1 -DDEBUG=1 -DLINUX=1 -DUNIX=1 
-DARCH_LINUX_POWERPPC=1-DMW_CPU_BIG_ENDIAN=1  -fpic -I../include -I. 
-I/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/include 
-msoft-float -Wall -Wpointer-arith -O3 -ggdb -o nanox.o nanox.c
ppc_4xx-gcc  -fpic -I../include -I. 
-I/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/include 
-msoft-float -Wall -Wpointer-arith -O3 -ggdb 
-L/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib 
args.o rfbproto.o sockets.o vncviewer.o nanox.o -o 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/bin/vnc 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/libnano-X.a 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/libvncauth.a
make[3]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/demos/vnc/vncviewer'
make[2]: Zirkuläre Datei 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ <- 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ 
Abhängigkeit wird nicht verwendet.
make[2]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/demos/vnc'
make[1]: Zirkuläre Datei 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ <- 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ 
Abhängigkeit wird nicht verwendet.
make[1]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/demos'
+ exit 0
Executing(%install): /bin/sh -e /home/wi/PPC/ELDK3/var/tmp/rpm-tmp.69817
+ umask 022
+ cd /home/wi/PPC/ELDK3/usr/src/denx/BUILD
+ cd microwindows-0.90
+ cd src
+ rm -rf -- /home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root
+ mkdir -p -- /home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/bin
+ make 
INSTALL_PREFIX=/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr install
make -C drivers
make[1]: Entering directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers'
make[1]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/drivers'
make -C mwin

...

make -C nanox
make[1]: Entering directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/nanox'
make[1]: Leaving directory 
`/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/nanox'
make: Zirkuläre Datei 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ <- 
/home/wi/PPC/ELDK3/usr/src/denx/BUILD/microwindows-0.90/src/lib/ 
Abhängigkeit wird nicht verwendet.
install -c -m 755 -d 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/include/microwin
echo "Copying hdrs to 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/include/microwin"
Copying hdrs to 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/include/microwin
install -c -m 644 include/*.h 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/include/microwin
echo "Copying libs to 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/lib"
Copying libs to /home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/lib
install -c -m 755 -d 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/lib
install -c -m 644 -s lib/*.a 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root/usr/lib
strip: Warning: Output file cannot represent architecture UNKNOWN!
strip: Warning: Output file cannot represent architecture UNKNOWN!
strip: Warning: Output file cannot represent architecture UNKNOWN!
...
ppc-linux-strip: Warning: Output file cannot represent architecture UNKNOWN!
ppc-linux-strip: Warning: Output file cannot represent architecture UNKNOWN!
Processing files: microwindows-0.90-2
Finding  Provides: /home/wi/PPC/ELDK3/usr/lib/rpm/find-provides
Finding  Requires: /home/wi/PPC/ELDK3/usr/lib/rpm/find-requires
Provides: libmwimages.so libmwinlib.so libmwin.so libnano-X.so
Requires(rpmlib): rpmlib(PayloadFilesHavePrefix) <= 4.0-1 
rpmlib(CompressedFileNames) <= 3.0.4-1
Requires: libc.so.6 libc.so.6(GLIBC_2.0) libc.so.6(GLIBC_2.1) 
libc.so.6(GLIBC_2.3) libm.so.6 libmwimages.so libmwinlib.so libmwin.so 
libnano-X.so
Checking for unpackaged file(s): 
/home/wi/PPC/ELDK3/usr/lib/rpm/check-files 
/home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root
Wrote: /home/wi/PPC/ELDK3/usr/src/denx/SRPMS/microwindows-0.90-2.src.rpm
Wrote: 
/home/wi/PPC/ELDK3/usr/src/denx/RPMS/ppc/microwindows-ppc_4xx-0.90-2.ppc.rpm
Executing(%clean): /bin/sh -e /home/wi/PPC/ELDK3/var/tmp/rpm-tmp.10309
+ umask 022
+ cd /home/wi/PPC/ELDK3/usr/src/denx/BUILD
+ cd microwindows-0.90
+ rm -rf /home/wi/PPC/ELDK3/var/tmp/microwindows-0.90-root
+ exit 0
