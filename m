Return-Path: <vijay_padiyar@hotmail.com>
Received: from OMC3-S15.phx.gbl (omc3-s15.bay6.hotmail.com [65.54.249.89])
	by ozlabs.org (Postfix) with ESMTP id B38A767A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 20:48:28 +1000 (EST)
Message-ID: <BAY1-DAV13A9814EECCF1E48C86E2D8B380@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: <dmarty@enib.fr>
References: <20050401100354.70hbtqjfs33cos04@imp.enib.fr>
Date: Fri, 1 Apr 2005 16:06:47 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: Embedded linux on powerpc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David

If your file was compiled statically (i.e. you gave the -static flag while
compiling & linking the file) then it will execute the application without
any problems.

If you have not used that flag (i.e. you're compiling your application using
dynamic library linking, which is preferrable) then you need to have the GNU
library and loader files (libc-2.3.3.so and ld-2.3.3.so and their symbolic
links, libc.so.6 and ld.so.6) in your target's /lib directory. You'll find
these in your toolchain's lib folder
(/home/yourname/tools/powerpc-603e-linux-gnu/lib). Copy these to your root
filesystem's lib directory.

Here is a snapshot of my root filesystem's /lib directory:

[chandrashekharp@linux lib]$ ls
ld-2.3.3.so        libm-2.3.3.so           libnss_files.so.2
libstdc++.so.6
ld.so.1            libm.so.6               libpthread-0.10.so
libstdc++.so.6.0.1
libc-2.3.3.so      libnsl-2.3.3.so         libpthread.so.0
libthread_db-1.0.so
libcrypt-2.3.3.so  libnsl.so               libresolv-2.3.3.so
libthread_db.so
libcrypt.so.1      libnsl.so.1             libresolv.so.2
libthread_db.so.1
libc.so.6          libnss_compat-2.3.3.so  librt-2.3.3.so
libutil-2.3.3.so
libdl-2.3.3.so     libnss_compat.so        librt.so            libutil.so.1
libdl.so.2         libnss_compat.so.2      librt.so.1          modules
libgcc_s.so        libnss_files-2.3.3.so   libstdc++.la
libgcc_s.so.1      libnss_files.so         libstdc++.so

Similarly, you can copy whatever library files you require from your
toolchain's lib folder to your root filesystem's lib folder.

To find out which library files your executable needs, you need to do a
readelf on the executable and search for shared library dependencies:

~ $ powerpc-603e-linux-gnu-readelf -a hello | grep "Shared"

Executing this command will give you an output like this:

 0x00000001 (NEEDED)                     Shared library: [libc.so.6]

This means hello needs libc.so.6 (libc-2.3.3.so) to execute properly. Next,
using the same command on libc.so.6 gives:

~ $ powerpc-603e-linux-gnu-readelf -a libc-2.3.3.so | grep "Shared"

 0x00000001 (NEEDED)                     Shared library: [ld.so.1]

So libc-2.3.3.so needs ld.so.1 (ld-2.3.3.so) to work. I think you can copy
these two files to your root filesystem's /lib directory and your app should
execute fine.

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
----- Original Message ----- 
From: <dmarty@enib.fr>
To: <vijay_padiyar@hotmail.com>
Sent: Friday, April 01, 2005 1:33 PM
Subject: Embedded linux on powerpc


> Hello,
>
> You wrote:
>
> >When I try to execute the resulting file on my target from the Linux
kernel
> >prompt, I get a message saying:
> >
> >/home # ./hello
> >/bin/sh: hello: File not found (or something like that)
>
> I have the same problem did you find a solution,
> thank you in advance for your response
>
> David
>
>
> ----------------------------------------------------------------
> The content of this message is only under the responsibility
> of its sender. Moreover, the internet can not guarantee the
> integrity of this message. The ENIB shall (will) not
> therefore be liable for the message if modified.
> ----------------------------------------------------------------
> Le contenu de ce message est de la seule responsabilite
> de son expediteur. De plus, l'internet ne permettant pas
> d'assurer l'integrite de ce message, l'ENIB decline toute
> responsabilite au titre de ce message, dans l'hypothese
> ou il aurait ete modifie.
>
>
