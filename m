Message-ID: <3C8762B3.4000201@bluewin.ch>
Date: Thu, 07 Mar 2002 13:53:07 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Adam Wozniak <awozniak@comdev.cc>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems with shared memory
References: <Pine.LNX.4.33.0203051631130.24566-100000@rangers.comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Adam,

David Ashley has reported lately a bug in arch/ppc/mm/ppc_mmu.c (see
http://lists.linuxppc.org/linuxppc-embedded/200202/msg00307.html),
which seems to be present in the linuxppc_2_4 tree but not in the
linuxppc_2_4_devel tree.

Hope it helps,

Wolfgang.


Adam Wozniak wrote:

>I've got Linux 2.4.16 running on a custom MPC8260 board.
>
>when I do the program below in a tight loop
>i.e.
>
>while true
>do
>./foo 8675 1024
>done
>
>Things pop after about 20 iterations.  It'll choose a different spot
>in the kernel to pop depending on what options I've compiled into the
>kernel.  I believe I've got some memory corruption going on.  When I
>poke around with a hardware debugger I see values in kernel structures
>which clearly aren't right.
>
>Any known problems with shared memory in the 2.4.16 kernel on the MPC8260?
>
>This should be easy enough for someone to try to reproduce.
>
>=== begin foo.c
>#include <stdio.h>
>#include <sys/types.h>
>#include <sys/shm.h>
>
>int main (int argc, char **argv)
>{
>   int j;
>   char *q;
>   int p;
>
>   p = shmget(atoi(argv[1]),  atoi(argv[2]), IPC_CREAT | 0666);
>
>   q = shmat(p, NULL, 0);
>
>   printf("at @ %p \n", q);
>
>   {
>      int i;
>      for (i = 0; i < atoi(argv[2]); i++)
>      {
>         q[i]++;
>      }
>   }
>
>   shmdt(q);
>}
>=== end foo.c
>
>--
>Adam Wozniak (KG6GZR)   COM DEV Broadband - Digital and Software Systems
>awozniak@comdev.cc      805 Aerovista Place, San Luis Obispo, CA 93401
>                        http://www.comdev.cc
>                        Voice: (805) 544-1089       Fax: (805) 544-2055
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
