Date: Wed, 09 Aug 2000 13:45:57 +0800
Subject: Re: php compilation fix
From: Edwin Tam <edwintam@ieee.org>
To: <mpeters@omnilinux.com>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5B71115.316A%edwintam@ieee.org>
In-Reply-To: <00080818110803.04184@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marco Pratesi (Bcc'ed) suggested a much neater fix than mine:
> I have solved the problem simply by commenting out
> the lines 370 and 435 and using orig_args
> instead of args.
> I have made this thing because orig_args is never
> overwritten in the functions related to lines 370
> and 435 and it is used only to copy it in args.
> Do you think my correction can be dangerous ?
> My diff:
> 370,372c370,372
> <                       args = orig_args;
> <                       size = vsnprintf(buffer, sizeof(buffer) - 1, format,
args);
> <                       va_end(args);
> ---
>> //                    args = orig_args;
>> size = vsnprintf(buffer, sizeof(buffer) - 1, format, orig_args);
>> va_end(orig_args);
> 435,437c435,437
> <               args = orig_args;
> <               size = vsnprintf(buffer, sizeof(buffer) - 1, format, args);
> <               va_end(args);
> ---
>> //            args = orig_args;
>> size = vsnprintf(buffer, sizeof(buffer) - 1, format, orig_args);
>> va_end(orig_args);

I tried it, and it works. My concerns are 1) if args do really not get
modified. If this is the case, then the problem is solved, simple and neat,
on the PC/Mac platform, and 2) even if (1) holds, what if the original
author is trying to avoid some OS bugs in other non-Linux OSes? Obviously,
s/he would not do this (args=orig_args) without good reason.

Anyway, regarding to the patch, do NOT apply it on the x86 platform, it will
break the error reporting mechanism. Marco's fix would not, however.

I have no problem on running apache having php-4.0.1pl2 (patched or not)
compiled with gd-1.8.2 using "--with-gd=" directive. Please see:

http://www.quthinker.com/

The above system is patched, even it is on a PC.

However, I strongly suggest you follow Marco Pratesi's idea despite my
concerns. I'll change the above server to Marco's fix very soon.

Edwin Tam


--

My PGP Public key is available at:
http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x08158FC3

/*

*** WARNING ***
The information is transmitted over a public channel. For transmission of
sensitive information, please encrypt the content using my PGP public key
above.

*/


> From: "Michael A. Peters" <mpeters@omnilinux.com>
> Organization: Unitek
> Reply-To: mpeters@omnilinux.com
> Date: Tue, 8 Aug 2000 17:29:19 -0700
> To: edwintam@ieee.org, linuxppc-dev@lists.linuxppc.org
> Subject: php compilation fix
>
> I created a patch that makes the changes suggest to php-4.0.1pl2/main/main.c
>
> replace
> args = orig_args;
> by:
> memcpy(args, orig_args, sizeof(orig_args));
>
> in lines 370 & 435
>
> php-4 now builds beautifully on PowerPC, but mod_php-gd does not. Well, it
> builds- but apache won't start with gd.so selected in the php.ini file.
>
> Interestingly enough- on Red Hat 6.2 when I build php-4.0.1pl2 without the
> patch, mod_php-gd loads beautifully but with the same patch needed to even
> build php on PPC, mod_php-gd is broken.
>
> Something about the fix breaks the compilation of gd.so
> Well, it compiles, it just doesn't load.
> All other modules I currently build load after patch.
>
> This is how I build gd.so:
>
> # Build PHP modules.
> build_ext() {
> gcc -fPIC -shared $RPM_OPT_FLAGS -DHAVE_CONFIG_H -I.\
> -I. -I`/usr/sbin/apxs -q INCLUDEDIR` -I./Zend \
> -I/usr/include/freetype -I/usr/include/$1 \
> -I./ext/$1 -I./ext/$1/lib$1 -I./main\
> -I./ext/xml/expat/xmltok -I./ext/xml/expat/xmlparse \
> -DHAVE_CONFIG_H `grep ^CPPFLAGS Zend/Makefile | cut -f2- -d=` \
> $4 $2 -o $1.so $3 -lc
>
> build_ext gd "ext/gd/gd.c ext/gd/gdttf.c ext/gd/gdcache.c ext/gd/gdt1.c" \
> "-lpng -lgd -lttf -lt1 -lc" "-DHAVE_GD_PNG  -DHAVE_LIBGD \
> -DHAVE_LIBJPEG -DHAVE_LIBPNG -DHAVE_GDIMAGECOLORRESOLVE \
> -DHAVE_LIBT1 -DHAVE_LIBTTF -DHAVE_LIBGD13 -DCOMPILE_DL_GD"
>
> Any ideas? I'd like to include mod_php-gd if at all possible...
>
> The src rpm I use can be found at
>
> http://staging.omnilinux.com/~mpeters/php-4.0.1pl2-2.src.rpm
>
> please keep in mind that this spec file is still under major work- although
> (with the exception of mod_php-gd) everyhing that's not commented out
> currently
> builds spledidly and works on x86 and ppc, and mod_php-gd works on x86 w/o the
> patch.
>
> --
> Michael A. Peters
> http://www.omnilinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
