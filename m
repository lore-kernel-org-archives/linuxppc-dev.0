From: "Michael A. Peters" <mpeters@omnilinux.com>
Reply-To: mpeters@omnilinux.com
To: edwintam@ieee.org, linuxppc-dev@lists.linuxppc.org
Subject: php compilation fix
Date: Tue, 8 Aug 2000 17:29:19 -0700
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00080818110803.04184@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I created a patch that makes the changes suggest to php-4.0.1pl2/main/main.c

replace
args = orig_args;
by:
memcpy(args, orig_args, sizeof(orig_args));

in lines 370 & 435

php-4 now builds beautifully on PowerPC, but mod_php-gd does not. Well, it
builds- but apache won't start with gd.so selected in the php.ini file.

Interestingly enough- on Red Hat 6.2 when I build php-4.0.1pl2 without the
patch, mod_php-gd loads beautifully but with the same patch needed to even
build php on PPC, mod_php-gd is broken.

Something about the fix breaks the compilation of gd.so
Well, it compiles, it just doesn't load.
All other modules I currently build load after patch.

This is how I build gd.so:

# Build PHP modules.
build_ext() {
gcc -fPIC -shared $RPM_OPT_FLAGS -DHAVE_CONFIG_H -I.\
        -I. -I`/usr/sbin/apxs -q INCLUDEDIR` -I./Zend \
        -I/usr/include/freetype -I/usr/include/$1 \
        -I./ext/$1 -I./ext/$1/lib$1 -I./main\
        -I./ext/xml/expat/xmltok -I./ext/xml/expat/xmlparse \
        -DHAVE_CONFIG_H `grep ^CPPFLAGS Zend/Makefile | cut -f2- -d=` \
        $4 $2 -o $1.so $3 -lc

build_ext gd "ext/gd/gd.c ext/gd/gdttf.c ext/gd/gdcache.c ext/gd/gdt1.c" \
        "-lpng -lgd -lttf -lt1 -lc" "-DHAVE_GD_PNG  -DHAVE_LIBGD \
        -DHAVE_LIBJPEG -DHAVE_LIBPNG -DHAVE_GDIMAGECOLORRESOLVE \
        -DHAVE_LIBT1 -DHAVE_LIBTTF -DHAVE_LIBGD13 -DCOMPILE_DL_GD"

Any ideas? I'd like to include mod_php-gd if at all possible...

The src rpm I use can be found at

http://staging.omnilinux.com/~mpeters/php-4.0.1pl2-2.src.rpm

please keep in mind that this spec file is still under major work- although
(with the exception of mod_php-gd) everyhing that's not commented out currently
builds spledidly and works on x86 and ppc, and mod_php-gd works on x86 w/o the
patch.

--
Michael A. Peters
http://www.omnilinux.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
