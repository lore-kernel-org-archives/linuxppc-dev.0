Message-ID: <3715C58D.1C438D65@wanadoo.fr>
Date: Thu, 15 Apr 1999 12:55:09 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
CC: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org,
        Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
References: <Pine.LNX.4.05.9904141910410.487-100000@pc.wackyland.com> <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>
Content-Type: multipart/mixed;
 boundary="------------9B3DDE1A434ED1416CEE6D1B"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9B3DDE1A434ED1416CEE6D1B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Franz Sirl wrote:
> 
> At 08:54 15.04.99 , Martin Costabel wrote:
> >> > Or could someone find out what's wrong with the fprintf function in
> >> > LinuPPC? Note that this is not specific for one version of glibc. I
> >> > tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.
> >>
> >> It failed under the old libs?
> >
> >Yes, I compiled gnuplot-3.7 under glibc-961212 (rev 1o, IIRC), and the
> >result was the same. I managed to track the problem down to the fprintf
> >call, but I don't know enough C and glibc to go any further.
> 
> The problem could be egcs, there's a known varargs bug on PPC, which
> happens as soon you have more than 8-10 args. There's a testcase for this
> in the egcs testsuite, gcc.c-torture/execute/980608-1.c, which still fails
> in the development sources. I hope this will be resolved for egcs-1.2 if
> the rewrite of the function epilogue/prologue to use RTL makes it in time...

Here is a minimal example, adapted from the gnuplot sources. If used as
"a.out foo.gnu", it segfaults for me. Compiler is egcs-2.91.66 19990314
(egcs-1.1.2 release) (PowerPC GNU/Linux), glibc-2.1.1-3a. 
gbd backtrace gives

#0  0x171fb0c in strlen () at soinit.c:59
soinit.c:59: No such file or directory.
(gdb) bt
#0  0x171fb0c in strlen () at soinit.c:59
#1  0x1703fe0 in _IO_vfprintf () at vfprintf.c:1554
#2  0x170acf8 in fprintf () at fprintf.c:36
#3  0x18004d4 in test_fprintf (fp=0x18408a8) at gpltst.c:6
#4  0x180053c in main (argc=2, argv=0x7ffff8a4) at gpltst.c:32
#5  0x676e7500 in ?? ()


If I take away the 9th line of output, it runs without segmentation
fault, but the output of the last 2 lines is incorrect. If I take away
the 8th line, too, output of line 7 is still incorrect.

If I keep all 9 lines, but change the first argument 1.1 to 11 and the
first format from %g to %d, there is no bug anymore.

I hope this helps some of the experts to find and fix the bug.

--
Martin
--------------9B3DDE1A434ED1416CEE6D1B
Content-Type: text/plain; charset=us-ascii;
 name="gpltst.c"
Content-Disposition: inline;
 filename="gpltst.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>

void test_fprintf(fp)
    FILE *fp;
{
	fprintf(fp, "\
set offsets %g, %g, %g, %g\n\
set pointsize %g\n\
set encoding %s\n\
set %spolar\n\
set %sparametric\n\
set view %g, %g, %g, %g\n\
set samples %d, %d\n\
set isosamples %d, %d\n\
set %ssurface",
	    1.1, 1.2, 1.3, 1.4, 
	    2.1,
	    "3",
	    "4",
	    "5",
	    6.1, 6.2, 6.3, 6.4,
	    71, 72,
	    81, 82,
	    "9"
	    );
	    }

int main(int argc, char** argv)
{
	char* file_name;
	strcpy(file_name, argv[1]);   
	test_fprintf(fopen(file_name, "w"));
	exit(0);
} 

	    

--------------9B3DDE1A434ED1416CEE6D1B--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
