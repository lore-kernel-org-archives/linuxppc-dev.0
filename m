Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7FA6767A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 22:53:39 +1000 (EST)
Message-ID: <424AA23D.3090207@anagramm.de>
Date: Wed, 30 Mar 2005 14:57:33 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: James E Wilson <wilson@specifixinc.com>
References: <42429E50.4080804@anagramm.de> <424A1936.9020309@specifixinc.com>
In-Reply-To: <424A1936.9020309@specifixinc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: gcc@gcc.gnu.org, linuxppc-embedded@ozlabs.org
Subject: Re: gcc-3.3.3 ppc e500 - Abort of uic from Qt (solved)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Just FYI x-posted to linuxppc-embedded

Hello, James!

Thank you for your hints...
In the meanwhile as I experienced some other strange issues with my 
gcc-3.3.3 toolchain, I concentrated to upgrade to the latest
mainstream  gcc-3.4.3. It also failed during bootstrapping in
the beginning, but after a 'two-iteration' bootstrap I was able
to move up to 3.4.3:

Here is my buildlog:
	./gcc-3.4.3/configure
		--enable-languages=c
		--enable-shared
		--enable-threads=posix
		--enable-__cxa_atexit
		--enable-nls=yes
		--enable-clocale=gnu
	make bootstrap
failed with an occasional segfault but let's give it a second chance
	make bootstrap
which finished successful!
	make install
Ok, now I have a working gcc-3.4.3 at least - well, for c only!
but let me now try a
	make distclean
	../gcc-3.4.3/configure
		--enable-languages=c,c++,objc
		--enable-shared
		--enable-threads=posix
		--enable-__cxa_atexit
		--enable-nls=yes
		--enable-clocale=gnu
	make bootstrap
and voila! successful!
	make check
	make install

Okay, now, I am back to installing Qt... which also works fine.
uic doesn't crash anymore.
I am pretty sure that my initial toolchain (ELDK3.1 for ppc_8xx)
was somehow broken.

The next step is to get optimized code for the mpc8540 but that's low 
priority now.

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

>> /[..]/qt-x11-free-3.3.4/bin/uic -L /[..]/qt-x11-free-3.3.4/plugins
>> -embed designercore [lots of images/*.png's]
>> -o qmake_image_collection.cpp
>> make: *** [qmake_image_collection.cpp] Aborted
>> make: *** Deleting file `qmake_image_collection.cpp'
> 
> 
> uic is dumping core.  We can't really do anything about that, as that 
> isn't part of gcc.  We need a testcase that we can use to reproduce the 
> problem, or evidence of an actual gcc problem.
> 
> If this is a gcc miscompilation problem, and you are compiling with a 
> high optimization level like -O2, you could try using -O or -O0 instead.
> 
> You could try using a different gcc version.  Maybe gcc-3.3.4 has a bug 
> that isn't present in other earlier or later gcc-3.3.x versions.
> 
> You could try debugging uic to figure out why it is failing.
> 
>  >BTW: What are the most current versions for a toolchain which 
> generates >working and efficient code for the MPC8540 (ppc32, e500, spe)?
> 
> There are people supporting the e500 target, so it should be working 
> reasonably well in any gcc release.
> 
> There is a special branch maintained for the e500 by Red Hat, which is 
> called gcc-3_4-e500-branch.  This can be checked out from our cvs 
> repository.  I don't know details about this branch other than what is 
> on the web site.
>     http://gcc.gnu.org/cvs.html#devbranches
> and scroll down to the Architecture-specific section.
