Message-Id: <4.2.0.56.19990623163213.042ffa40@mail.lauterbach.com>
Date: Wed, 23 Jun 1999 16:37:25 +0200
To: Troy Benjegerdes <hozer@drgw.net>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: dl-load.c (ld.so) bug??
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.04.9906211749280.27642-100000@narn.local.drgw.n
 et>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:52 22.06.99 , Troy Benjegerdes wrote:


>testcase:
>
>#include <stdio.h>
>int main(void){
>         char * ptr;
>         printf("hello world\n");
>         fflush(stdout);
>         ptr = (char *)malloc(100);
>         free(ptr);
>}
>
>
>compile this with:
>gcc test.c -lefence -g -static
>
>On a PPC glibc-2.1 box, this segfaults in dl-load.c:564
>
>On a x86 Red Hat 6.0 system, it works fine (
>[troybenj@mos6 troybenj]$ ./a.out
>
>   Electric Fence 2.0.5 Copyright (C) 1987-1998 Bruce Perens.
>hello world
>[troybenj@mos6 troybenj]$
>
>
>Either dl-load.c has a serious bug, or ElectricFence is broken on PPC.
>I suspect it's the former, and if so, this would explain the weird
>segfaults I've been seeing.
>
>Can someone that knows glibc better please confirm or deny this for me?

This bug is fixed already in cvs-glibc. I've put up mostly untested RPMS 
for a newer glibc under <ftp://dev.linuxppc.org/users/fsirl/R5>.

It might be that the new IP of dev is still not fully propagated, so use 
169.207.1.122 directly in that case.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
