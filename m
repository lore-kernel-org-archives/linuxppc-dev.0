Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 500C3B7DD4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 13:44:31 +1000 (EST)
Date: Tue, 11 May 2010 20:44:24 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
Message-ID: <4BEA2375.7040802@nerdbynature.de>
References: <20100511174749.19309.44615.stgit@muvarov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maxim Uvarov wrote on 2010-05-11 10:47 :
> This patch is required in case if you are using new toolchains.

I'm on Debian/stable (binutils 2.18, gcc 4.3.2), so I applied your patches=
=20
to the latest -git checkout:

First, compilation fails with:

cc1: warnings being treated as errors
kexec/arch/ppc/kexec-ppc.c: In function =E2=80=98get_base_ranges=E2=80=99:
kexec/arch/ppc/kexec-ppc.c:258: error: value computed is not used
make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1

Somehow a "-" hyphen made it into one of the functions:

> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
[...]
>  =09=09=09if (local_memory_ranges >=3D max_memory_ranges) {
> -=09=09=09=09fclose(file);
> -=09=09=09=09break;
> +=09=09=09=09if (realloc_memory_ranges() < 0){
> +=09-=09=09=09=09fclose(file);


Removing this, gets me further, until:


purgatory/arch/ppc/crt.o: In function `__lshrdi3':
(.text+0xf0): multiple definition of `__lshrdi3'
purgatory/arch/ppc/misc.o:(.text+0x50): first defined here
collect2: ld returned 1 exit status
make: *** [purgatory/purgatory.ro] Error 1

And has been defined in purgatory/arch/ppc/crt.S and
=2E/purgatory/arch/ppc/misc.S. Removing it from e.g. crt.S
makes it compile, I have not tested it yet, though :-)

Thanks,
Christian.

PS: Where is -Werror defined? I could not find it anywhere in the kexec=20
    source (execpt in arch/mips)...
--=20
make bzImage, not war
