Return-Path: <shin@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 0991EDDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 15:59:19 +1000 (EST)
Received: from mail37.sony.co.jp (localhost [127.0.0.1])
	by mail37.sony.co.jp (R8/Sony) with ESMTP id l585xH9v020296
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 14:59:17 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail37.sony.co.jp (R8/Sony) with SMTP id l585xHI9020293
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2007 14:59:17 +0900 (JST)
In-Reply-To: <4668176D.7060002@am.sony.com>
References: <20070606024407.786638029@am.sony.com>
	<20070606024407.786638029@am.sony.com>>
	<46662326.4030706@am.sony.com> <200706061621.59963.arnd@arndb.de>
	<4668176D.7060002@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <8f8e586b9cdbc24316f9b29a2d0e4a84@sm.sony.co.jp>
From: Takao Shinohara <shin@sm.sony.co.jp>
Subject: Re: [patch 05/18] PS3: Fix sparse warnings
Date: Fri, 8 Jun 2007 14:59:08 +0900
To: Geoff Levand <geoffrey.levand@am.sony.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-5--1035797828
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, "Noguchi,
	Masato" <Masato.Noguchi@jp.sony.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Apple-Mail-5--1035797828
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=BIG5;
	format=flowed

On 2007/06/07, at 23:34, Geoff Levand wrote:

> Arnd Bergmann wrote:
>> On Wednesday 06 June 2007, Geoff Levand wrote:
>>> -=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Zspu->local_store =3D =
ioremap(spu->local_store_phys, LS_SIZE);
>>> +=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Zspu->local_store =3D (__force void=20
>>> *)ioremap(spu->local_store_phys,
>>> =
+=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1=
Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1=
Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z=A1Z =A1Z LS_SIZE);
>>
>> I haven't noticed this before, but it seems to be a preexisting bug:
>> You map the local_store as with the guarded page table bit set, which
>> causes a performance degradation when accessing the memory from =
kernel
>> space.
>>
>> If you're lucky, your hypervisor knows this and will fix it up for
>> you, but I would replace the ioremap call with an
>> ioremap_flags(..., _PAGE_NO_CACHE); to be on the safe side.
>>
>> If you want to measure the impact, I'd suggest timing a user space
>> read() on the mem file of a running SPU context.
>
> Hi Arnd,
>
> I asked Noguchi-san to check the performance and below is his
> report and test program.  I'll add the change into my patch set.
>
> -Geoff
>
> -------- Original Message --------
> Subject: RE: [patch 05/18] PS3: Fix sparse warnings
> Date: Thu, 7 Jun 2007 05:39:43 -0700
> From: Noguchi, Masato <Masato.Noguchi@jp.sony.com>
> To: Levand, Geoff <Geoffrey.Levand@am.sony.com>
>
>  << A time to read a whole of LS by read system call >>
> not patched: avg. 21053.7800 tick ( 263.831830 microseconds )
> patched:     avg. 20809.2412 tick ( 260.767434 microseconds )
>
> about 1% faster.
> I think it's a valid difference. (not a measurement error.)

Let me correct above measurements and analysis.

My understanding is:

	1) caching-inhibited loads are usually implemented as guarded. =
Thus,
	   guarded property will not affect load performance.

	2) caching-inhibited and non-guarded sequential stores are =
usually
	   gathered (merged) in store buffer. Thus, guarded property =
will
	   affect store performance much.

Therefor, we should measure write(2) performance to evaluate the impact
of the patch.

Attached is a little modified test program based on Noguchi-san's one.
It measures write(2) performance. Buffer area is 'pre-touched' to avoid
VM overhead.

***** test results *****

before:	103903	[TB cycles]	(best value out of 100 tries.)
after:	14277	[TB cycles] (best value out of 100 tries.)

-- Takao Shinohara


--Apple-Mail-5--1035797828
Content-Type: text/plain;
	x-unix-mode=0644;
	name="test_write_ls.c"
Content-Disposition: attachment;
	filename=test_write_ls.c
Content-Transfer-Encoding: quoted-printable

#include <sys/types.h>=0D
#include <sys/stat.h>=0D
#include <sys/syscall.h>=0D
#include <sys/mman.h>=0D
#include <sys/wait.h>=0D
#include <fcntl.h>=0D
#include <unistd.h>=0D
#include <stdio.h>=0D
#include <signal.h>=0D
#include <string.h>=0D
#include <stdint.h>=0D
#include <stdlib.h>=0D
=0D
#include <pthread.h>=0D
=0D
#define =5F=5FNR=5Fspe=5Frun 278=0D
#define =5F=5FNR=5Fspe=5Fcreate 279=0D
=0D
#define LS=5FSIZE 0x40000=0D
=0D
#define SPENODE "/spu/stoplooptest"=0D
=0D
#define MFTB(RA) =5F=5Fasm=5F=5F volatile("mftb %0":"=3Dr"(RA))=0D
=0D
=0D
long long do=5Ftest(void)=0D
{=0D
	int spefd =3D -1, lsfd =3D -1;=0D
	int npc, status;=0D
	long long ret =3D -1;=0D
=0D
	char buf[LS=5FSIZE];=0D
	int n;=0D
	uint32=5Ft t1, t2;=0D
=0D
	/* create context */=0D
	spefd =3D syscall(=5F=5FNR=5Fspe=5Fcreate, SPENODE, 0,=0D
			S=5FIRUSR | S=5FIWUSR | S=5FIXUSR);=0D
	if (spefd < 0) goto out;=0D
=0D
	/* run once to assign physical spe */=0D
	npc =3D 0;=0D
	syscall(=5F=5FNR=5Fspe=5Frun, spefd, &npc, &status);=0D
=0D
	/* get /mem file descriptor */=0D
	lsfd =3D open(SPENODE "/mem", O=5FRDWR,=0D
		    S=5FIRUSR | S=5FIWUSR);=0D
	if (lsfd < 0) goto out;=0D
=0D
	/* make sure main memory is allocated and writable for 'buf' */=0D
	memset(buf, 0, sizeof buf);=0D
=0D
	/* write mem */=0D
	MFTB(t1);=0D
	if (write(lsfd, buf, LS=5FSIZE) !=3D LS=5FSIZE) {=0D
		goto out;=0D
	}=0D
	MFTB(t2);=0D
=0D
	ret =3D t2 - t1;=0D
 out:=0D
	if ( lsfd >=3D 0 ) close(lsfd);=0D
	if ( spefd >=3D 0 ) close(spefd);=0D
=0D
	return ret;=0D
}=0D
=0D
int main(int argc, char *argv[])=0D
{=0D
	long long r;=0D
	r =3D do=5Ftest();=0D
	printf("%lld\n", r);=0D
=0D
	return 0;=0D
}=0D

--Apple-Mail-5--1035797828
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-5--1035797828--
