Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A8E9DE095
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 10:01:12 +1000 (EST)
Date: Thu, 9 Apr 2009 10:01:12 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090409000112.GI16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<1239173283.10104.38.camel@localhost>
	<20090408134736.682bd56d@manatee.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090408134736.682bd56d@manatee.lan>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 01:47:36PM -0500, Nathan Lynch wrote:

> I think I had some reason for doing it this way, but I'm drawing a
> blank right now.
> 
> In the meantime, can someone post the warnings that gcc emits for
> cacheinfo.c, as well as the gcc version?  I can't reproduce them with
> 4.3.2 on Fedora.

---
[tony@thor ~]$ egrep cacheinfo tmp/build.log 
/scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function 'associativity_show':
/scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:562: warning: 'associativity' may be used uninitialized in this function
/scratch/tony/working/arch/powerpc/kernel/cacheinfo.c: In function 'size_show':
/scratch/tony/working/arch/powerpc/kernel/cacheinfo.c:513: warning: 'size_kb' may be used uninitialized in this function
tony@Sprygo:~/scratch$ /opt/crosstool/gcc-4.4.0-20090216-nolibc/powerpc-linux/bin/powerpc-linux-gcc -v
Using built-in specs.
Target: powerpc-linux
Configured with: /home/tony/buildall/src/gcc/configure --target=powerpc-linux --enable-targets=all --prefix=/opt/crosstool/gcc-4.4.0-20090216-nolibc/powerpc-linux --program-prefix=powerpc-linux- --disable-bootstrap --with-mpfr=/usr --enable-languages=c --without-headers --enable-sjlj-exceptions --with-system-libunwind --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --enable-checking=release
Thread model: single
gcc version 4.4.0 20090216 (experimental) (GCC) 
tony@Sprygo:~/scratch$ 
---

That's the compiler in rawhide

Yours Tony
