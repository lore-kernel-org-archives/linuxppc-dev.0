Message-ID: <3AE08D0F.C73ED990@routefree.com>
Date: Fri, 20 Apr 2001 12:25:03 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and system used memory
References: <A1C99F4731CAD111BA5400A024FC3B0C92A2C2@ESBILMA01EDCGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Billalabeitia, Jose Carlos (IndSys, GEPM)" wrote:
>
> Hi everybody:
>
>         Despite the fact that this title may sound like the problem is
> already solved,
> I have some questions about it. First of all, I have to tell you that am
> working with
> a  006C board and with our own prototype board, and both of them have
> 16MB of RAM. I have already got Linux 2.4.0 (test13-pre3) running on both of
> them,
> with an initrd and sash as the stand alone shell. Further in this email
> there are more
> details about the configuration and set up.
>
> The problem has to do with the size of the initrd. Here are some numbers
> that
> detail the issue:
>
> initrd          total             used           free          shared
> buffers        cached
> -------          ------             -------           -----
> ---------        ---------         ----------
> 4MB     15.699.968    6.660.096    9.039.872   2.236.416   4.194.304
> 1.257.472
> 6MB     15.699.968    9.056.256    6.643.712   2.400.256   6.291.456
> 1.323.008
> 8MB     15.699.968  11.366.400    4.333.568   2.408.448    8.388.608
> 1.323.008
>
> Initially the filesystem occupies about 1.1MB and as you can see here, the
> greater
> the initrd is the larger the amount used memory is and the lower the free
> memory
> available for the filesystem and system. I thought that part of the used
> memory was
> really allocated for the filesystem but every time I add a new file to the
> file system,
> the free memory gets reduced and the used memory increased.
>
> My questions are:
>
>         1.- Why have I got so much used memory at the start-up time? What
>              is this memory used for?

The ram disk will cause a fixed set of buffers to be grabbed equal to
the size of the ram disk.  This memory will be included in the tally
under the buffers heading.

I recently did some analysis of where all the memory was going on our
16M system (not the same board, but still an embedded ppc system) and
found that the static kernel uses about 2M, allocates another 20-30
pages during initialization, and most of the remaining kernel
allocations show up in /proc/slabinfo (for our running system approx 350
pages).  Everything else is user mode stuff (apps + shared libraries
such as libc.so, ld.so if you are using shared libraries, etc.).

>
>         2.- what is wrong in all this ? (see the configuration bellow)
>

The numbers look reasonable to me.
	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
