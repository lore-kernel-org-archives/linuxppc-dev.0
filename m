Message-ID: <20020423012601.31643.qmail@web9506.mail.yahoo.com>
Date: Mon, 22 Apr 2002 18:26:01 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: having trouble building glibc 2.2.5
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Still having trouble building glibc 2.2.5.  Using powerpc-eabi-gcc 3.0.4
running on cygwin on Windows 98.

Get a bunch of unresolved externals:

powerpc-eabi-gcc -B/usr/local/powerpc-eabi/bin/ -D__ELF__ -nostdlib
-nostartfiles -o /usr/build/glibc-2.2.5/iconv/iconvconfig
-Wl,-dynamic-linker=/usr/local/powerpc-linux/lib/ld.so.1   -Wl,-z,combreloc
/usr/build/glibc-2.2.5/csu/crt1.o /usr/build/glibc-2.2.5/csu/crti.o
`powerpc-eabi-gcc -B/usr/local/powerpc-eabi/bin/ -D__ELF__
--print-file-name=crtbegin.o` /usr/build/glibc-2.2.5/iconv/iconvconfig.o
/usr/build/glibc-2.2.5/iconv/strtab.o /usr/build/glibc-2.2.5/iconv/xmalloc.o
-Wl,-rpath-link=/usr/build/glibc-2.2.5:/usr/build/glibc-2.2.5/math:/usr/build/glibc-2.2.5/elf:/usr/build/glibc-2.2.5/dlfcn:/usr/build/glibc-2.2.5/nss:/usr/build/glibc-2.2.5/nis:/usr/build/glibc-2.2.5/rt:/usr/build/glibc-2.2.5/resolv:/usr/build/glibc-2.2.5/crypt:/usr/build/glibc-2.2.5/linuxthreads
/usr/build/glibc-2.2.5/libc.so.6 /usr/build/glibc-2.2.5/libc_nonshared.a -lgcc
`powerpc-eabi-gcc -B/usr/local/powerpc-eabi/bin/ -D__ELF__
--print-file-name=crtend.o` /usr/build/glibc-2.2.5/csu/crtn.o
/usr/build/glibc-2.2.5/iconv/iconvconfig.o: In function `add_module':
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:302: undefined reference to
`__strtol_internal'
/usr/build/glibc-2.2.5/iconv/iconvconfig.o: In function `name_to_module_idx':
/usr/src/glibc-2.2.5/iconv/iconvconfig.c:792: undefined reference to `abort'
/usr/build/glibc-2.2.5/iconv/iconvconfig.o: In function `write_output':
/usr/src/glibc-2.2.5/iconv/iconvconfig.c:1156: undefined reference to `close'
/usr/src/glibc-2.2.5/iconv/iconvconfig.c:1157: undefined reference to `unlink'
/usr/src/glibc-2.2.5/iconv/iconvconfig.c:1162: undefined reference to `close'
/usr/src/glibc-2.2.5/iconv/iconvconfig.c:1165: undefined reference to `fchmod'
/usr/build/glibc-2.2.5/iconv/strtab.o: In function `morememory':
/usr/src/glibc-2.2.5/iconv/strtab.c:120: undefined reference to `abort'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(tramp.o): In
function `__trampoline_setup':
tramp.o(.text+0x88): undefined reference to `abort'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o): In
function `__eabi':
eabi.o(.text+0xc4): undefined reference to `__init'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x8):
undefined reference to `__SDATA_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0xc):
undefined reference to `__SBSS_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x14):
undefined reference to `__SDATA2_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x18):
undefined reference to `__SBSS2_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x1c):
undefined reference to `__GOT_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x28):
undefined reference to `__GOT_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x2c):
undefined reference to `__GOT2_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x30):
undefined reference to `__GOT2_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x34):
undefined reference to `__FIXUP_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x38):
undefined reference to `__FIXUP_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x3c):
undefined reference to `__CTOR_LIST__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x40):
undefined reference to `__CTOR_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x44):
undefined reference to `__DTOR_LIST__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x48):
undefined reference to `__DTOR_END__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x4c):
undefined reference to `__EXCEPT_START__'
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/libgcc.a(eabi.o)(.got2+0x50):
undefined reference to `__EXCEPT_END__'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__dup'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtod_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `utime'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `lrand48_r'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtoull_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_cmp'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__libc_fcntl'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__write'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `getenv'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__getcwd'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `bsearch'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__dup2'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `qsort'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtoll_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__read'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__unlink'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_lshift'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_mul'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_submul_1'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__open'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to
`__mpn_construct_float'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtoul_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__libc_read'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__xstat64'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_divrem'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__lxstat'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to
`__mpn_construct_double'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__chmod'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtold_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtod_l'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__isatty'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__statfs'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `_fpioconst_pow10'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__chdir'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__readlink'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_extract_double'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__secure_getenv'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mkdir'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__cxa_atexit'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_add_n'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__poll'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__statvfs64'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__pipe'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__libc_open'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__chown'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__random_r'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__initstate_r'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__xmknod'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__lseek'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_rshift'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__srand48_r'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__tens'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__lxstat64'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__ttyname_r'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__libc_lseek'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__rmdir'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__fstatfs'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__close'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__fxstat64'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__mpn_mul_1'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__xstat'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__strtof_internal'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `exit'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__fxstat'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__libc_write'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__fcntl'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__setenv'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__access'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__unsetenv'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__open64'
/usr/build/glibc-2.2.5/libc.so.6: undefined reference to `__fstatvfs64'
collect2: ld returned 1 exit status
make[2]: *** [/usr/build/glibc-2.2.5/iconv/iconvconfig] Error 1
make[2]: Leaving directory `/usr/src/glibc-2.2.5/iconv'
make[1]: *** [iconv/others] Error 2
make[1]: Leaving directory `/usr/src/glibc-2.2.5'
make: *** [all] Error 2

What am I doing wrong?

Thanks,

Pete


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
