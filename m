Message-ID: <37385A58.BE9B4396@fi.infn.it>
Date: Tue, 11 May 1999 18:27:04 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: David De Ridder <david.de.ridder@bitsmart.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
References: <Pine.SO4.4.05.9905111658130.18026-200000@hsins.uia.ac.be>
Content-Type: multipart/mixed;
 boundary="------------C686E5DD3CCA30F028852E07"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------C686E5DD3CCA30F028852E07
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi David,
thanks for the file. 

This time at least I can give to you an answer: looking carefully in the
Gabriel directory I found that vmetest.c is a new file, and I discover
also that the patches were newer than the ones I used )this was the
reason of the compilation failing). I downloaded them, recompiled
everything, and I could also compile testvme.c.

I find also a new file universe.tex in /usr/src/linux/drivers/vme/ with
some more info (I'm reading it carefully in this moment).

In any case I used your program and by simply changing the "window" with
"attr" (both in VME_window than in VME_GET_WINDOW and VME_SET_WINDOW) I
could compile it on the new patches and run it without error.

The problem is in the next step, when I try to write in the remapped
region I get a bus error (probably is right, because I don't know what
that region is), but at least when I try to read I have the dataway
display showing me activities on the bus, and this is enogh for the
moment!

Now the problem is to understand how to map a board that has a fixed
address set by jumpers in this way, and I'm still very confused by all
these VME_AM... constants.
I'm sending the "improved" version of your program in attachement, the
only things that it does is to read (showing bus activity) and get a bus
error when it try to write.

Bye
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"
--------------C686E5DD3CCA30F028852E07
Content-Type: text/plain; charset=us-ascii;
 name="test.c"
Content-Disposition: inline;
 filename="test.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/vme.h>
#include <errno.h>
#include <sys/mman.h>

#define PATTERN 0x55

#define MBUFSIZE (1<<20)
/* static char membuf[MBUFSIZE]; */

int main(int argc, char ** argv)
{
        u_char *mp,*rp;	
  	int fd;
	int error;
	int i, j;

	VME_attr memdesc = {
	  base:  0xd00000, 
	  limit: 0xdfffff,
	  flags: VME_AM_A24(16) | VME_USE_MAP | VME_USE_RMW
	};
	VME_atomic_access rmw = {
	  offset: 0,
	};

	fd = open("/dev/vme",O_RDWR);
	if (fd < 0) {
	  perror("error opening vme"); 
	  exit(0);
	}
	printf("/dev/vme opened.\n");

	error = ioctl(fd, VME_SET_ATTR, &memdesc);
	if (error) perror("Failed VME_SET_ATTR");

	error = ioctl(fd, VME_GET_ATTR, &memdesc);
	if (error) perror("Failed VME_GET_ATTR");

	printf("memdesc: flags %x, vme_addr %x, length %x\n", memdesc.flags,
	       memdesc.base, memdesc.limit-memdesc.base+1);

	mp = mmap(0, MBUFSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0); 
	if ((u_long)mp == -1) perror("Mmap failed with");
	else printf("mem mapped at %p\n", mp);

	/* new code from testvme.c */
	printf("Try to read\n");
	rp=mp;	
	for (i=0; i<0x100; i++) {
	  j=*(rp++);	
	  printf("Read %x at %x\n",j,rp);
	  usleep(1000);
	}

	printf("Try to write \n");
	for (i=0; i<MBUFSIZE; i+= 512) {
		memset(mp+i, PATTERN, 512);
		usleep(1000);
	}
	printf("Finished \n");


	close(fd);
	return 0;
}

--------------C686E5DD3CCA30F028852E07--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
