Date: Mon, 21 Jun 1999 17:52:13 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: dl-load.c (ld.so) bug??
Message-ID: <Pine.LNX.4.04.9906211749280.27642-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



testcase:

#include <stdio.h>
int main(void){
        char * ptr;
        printf("hello world\n");
        fflush(stdout);
        ptr = (char *)malloc(100);
        free(ptr);
}   


compile this with:
gcc test.c -lefence -g -static

On a PPC glibc-2.1 box, this segfaults in dl-load.c:564

On a x86 Red Hat 6.0 system, it works fine (
[troybenj@mos6 troybenj]$ ./a.out

  Electric Fence 2.0.5 Copyright (C) 1987-1998 Bruce Perens.
hello world
[troybenj@mos6 troybenj]$ 


Either dl-load.c has a serious bug, or ElectricFence is broken on PPC.
I suspect it's the former, and if so, this would explain the weird
segfaults I've been seeing.

Can someone that knows glibc better please confirm or deny this for me?

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
