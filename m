Message-ID: <38A94B33.D06D64A8@huawei.com.cn>
Date: Tue, 15 Feb 2000 20:48:51 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: fadsrom questions...
References: <38A229CE.2472651F@grn.georet.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

     This is a strange question...
     Since "puts()" in  mbxboot/misc.c cannot work properly (it cannot print
messages via serial port correctly), I steal part of codes from vsprintf.c of
fadsrom,  replacing puts() with printf().
Under the following old cross-compile environment, I can cross-compile my
kernel and run it on target correctly.
[binutils 2.9.1.0.19a]
[egcs-1.1.2]
[glibc-2.1 glibc-crypt-2.1 glibc-linuxthread-2.1]

When I upgrade my cross-compile environment to the following and recompile my
kernel, some errors occur:
[binutils 2.9.5.0.22]
[gcc-2.95.2]
[gcc-core-2.95.2]
[glibc-2.1.2 glibc-crypt-2.1.2 glibc-linuxthread-2.1.2]

Error:
In function 'vsprintf' (in vsprintf.c of fadsrom):
undefined reference to "__va_arg_type_violation".

I trace this problem and find that it calls "va_arg()" which is defined in
"stdarg.h" (under "/usr/local/lib/gcc-lib/powerpc-linux/2.95.2/include"). The
"stdarg.h" includes "va-ppc.h", and the "va-ppc.h" itself defines "
__va_arg_type_violation". I guess it is the link problem but don't know how to
solve it.
Does anyone know what's the problem?
Thanks very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
