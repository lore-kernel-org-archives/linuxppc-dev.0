Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FA6F@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'Peter Desnoyers'" <pdesnoyers@chinook.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem during decompressing kernel routine
Date: Mon, 10 Sep 2001 10:08:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I did add some print statements and it gets to the inflate() routine and
does not return. I forgot to mention this. I printed the parameters for the
inflate routine and they seem to be correct.

	s.next_in =   0020533A
	s.avail_in =  0007224A
	s.next_out =  00000000
	s.avail_out = 00400000


Wolfgang wrote:
>Somewhere in the last version of the Linux kernel  they  changed  the
>clock from MHz to Hz. Check you version of the source, and modify the
>value passed in the bd_info structure as needed.

I checked it and the value was correct.

Thanks,

Cindy Peters

-----Original Message-----
From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
Sent: Monday, September 10, 2001 9:53 AM
To: Cindy Peters
Subject: Re: Problem during decompressing kernel routine


You could try debugging with printouts in the decompression routine.  In
arch/ppc/boot/mbx/misc.c, decompress_kernel() you'll find the following
lines:

        puts("\nUncompressing Linux...");

        gunzip(0, 0x400000, zimage_start, &zimage_size);
        puts("done.\n");
        puts("Now booting the kernel\n");

You're clearly going off into the weeds on the second line, and puts()
is working so you can use it to debug.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
