Date: Tue, 5 Mar 2002 16:37:29 -0800 (PST)
From: Adam Wozniak <awozniak@comdev.cc>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: problems with shared memory
Message-ID: <Pine.LNX.4.33.0203051631130.24566-100000@rangers.comdev.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got Linux 2.4.16 running on a custom MPC8260 board.

when I do the program below in a tight loop
i.e.

while true
do
./foo 8675 1024
done

Things pop after about 20 iterations.  It'll choose a different spot
in the kernel to pop depending on what options I've compiled into the
kernel.  I believe I've got some memory corruption going on.  When I
poke around with a hardware debugger I see values in kernel structures
which clearly aren't right.

Any known problems with shared memory in the 2.4.16 kernel on the MPC8260?

This should be easy enough for someone to try to reproduce.

=== begin foo.c
#include <stdio.h>
#include <sys/types.h>
#include <sys/shm.h>

int main (int argc, char **argv)
{
   int j;
   char *q;
   int p;

   p = shmget(atoi(argv[1]),  atoi(argv[2]), IPC_CREAT | 0666);

   q = shmat(p, NULL, 0);

   printf("at @ %p \n", q);

   {
      int i;
      for (i = 0; i < atoi(argv[2]); i++)
      {
         q[i]++;
      }
   }

   shmdt(q);
}
=== end foo.c

--
Adam Wozniak (KG6GZR)   COM DEV Broadband - Digital and Software Systems
awozniak@comdev.cc      805 Aerovista Place, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
