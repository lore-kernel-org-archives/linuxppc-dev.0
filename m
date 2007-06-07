Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 662A4DDEE3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 00:34:28 +1000 (EST)
Message-ID: <4668176D.7060002@am.sony.com>
Date: Thu, 07 Jun 2007 07:34:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 05/18] PS3: Fix sparse warnings
References: <20070606024407.786638029@am.sony.com>
	<20070606024407.786638029@am.sony.com>>
	<46662326.4030706@am.sony.com> <200706061621.59963.arnd@arndb.de>
In-Reply-To: <200706061621.59963.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 06 June 2007, Geoff Levand wrote:
>> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDspu->l=
ocal_store =3D ioremap(spu->local_store_phys, LS_SIZE);
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDspu->l=
ocal_store =3D (__force void *)ioremap(spu->local_store_phys,
>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD LS_SIZE)=
;
>=20
> I haven't noticed this before, but it seems to be a preexisting bug:
> You map the local_store as with the guarded page table bit set, which
> causes a performance degradation when accessing the memory from kernel
> space.
>=20
> If you're lucky, your hypervisor knows this and will fix it up for
> you, but I would replace the ioremap call with an
> ioremap_flags(..., _PAGE_NO_CACHE); to be on the safe side.
>=20
> If you want to measure the impact, I'd suggest timing a user space
> read() on the mem file of a running SPU context.

Hi Arnd,

I asked Noguchi-san to check the performance and below is his
report and test program.  I'll add the change into my patch set.

-Geoff

-------- Original Message --------
Subject: RE: [patch 05/18] PS3: Fix sparse warnings
Date: Thu, 7 Jun 2007 05:39:43 -0700
From: Noguchi, Masato <Masato.Noguchi@jp.sony.com>
To: Levand, Geoff <Geoffrey.Levand@am.sony.com>

 << A time to read a whole of LS by read system call >>
not patched: avg. 21053.7800 tick ( 263.831830 microseconds )
patched:     avg. 20809.2412 tick ( 260.767434 microseconds )

about 1% faster.=20
I think it's a valid difference. (not a measurement error.)

FYI,=20
The attached file is source code to measure it.
I run it 10000 times and calc an average.


#include <sys/types.h>

#include <sys/stat.h>

#include <sys/syscall.h>

#include <sys/mman.h>

#include <sys/wait.h>

#include <fcntl.h>

#include <unistd.h>

#include <stdio.h>

#include <signal.h>

#include <string.h>

#include <stdint.h>

#include <stdlib.h>



#include <pthread.h>



#define __NR_spe_run 278

#define __NR_spe_create 279



#define LS_SIZE 0x40000



#define SPENODE "/spu/stoplooptest"



#define MFTB(RA) __asm__ volatile("mftb %0":"=3Dr"(RA))





long long do_test(void)

{

	int spefd =3D -1, lsfd =3D -1;

	int npc, status;

	long long ret =3D -1;



	char buf[LS_SIZE];

	int n;

	uint32_t t1, t2;



	/* create context */

	spefd =3D syscall(__NR_spe_create, SPENODE, 0,

			S_IRUSR | S_IWUSR | S_IXUSR);

	if (spefd < 0) goto out;



	/* run once to assign physical spe */

	npc =3D 0;

	syscall(__NR_spe_run, spefd, &npc, &status);



	/* get /mem file descriptor */

	lsfd =3D open(SPENODE "/mem", O_RDWR,

		    S_IRUSR | S_IWUSR);

	if (lsfd < 0) goto out;



	/* read mem */

	MFTB(t1);

	if (read(lsfd, buf, LS_SIZE) !=3D LS_SIZE) {

		goto out;

	}

	MFTB(t2);



	ret =3D t2 - t1;

 out:

	if ( lsfd >=3D 0 ) close(lsfd);

	if ( spefd >=3D 0 ) close(spefd);



	return ret;

}



int main(int argc, char *argv[])

{

	long long r;

	r =3D do_test();

	printf("%lld\n", r);



	return 0;

}
