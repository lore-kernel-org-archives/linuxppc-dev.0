Message-ID: <38DF94A9.CDDBD6FF@cray.com>
Date: Mon, 27 Mar 2000 11:04:41 -0600
From: Mike Wolf <mwolf@sgi.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gc problem with shared libraries
References: <38DF707F.DF49A490@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> I am attempting to run the latest 405gc port and am getting error.
>
> I boot up to sash, and then run the command ls
> everthing seems to run fine untill I get the message
>
> ./ls: error in loading shared libraries: libc.so.6: failed to map
> segment
>  from shared object: Error 19
>
> This message is from ld.so.1.  What is ld.so.1 trying to do?  Any
> suggestions.
>
> Chip
>

First check the archives.  There is some mail from Marcus Sundberg
describing
how to set up the compiler so it will not use floating point.  Make sure
to compile everything with the -msoft-float option.  My guess from your
error is you have already done this.  Also I got this response from Ben
Bodley when I was having a similiar problem

"as far as my progress on shared libraries goes, currently:
 - i have checked the reason for failure, and it occurs in the
'dl-load.c' file from glibc, the initial __mmap() function is failing
the reason is that the kernel mmap_pgoff() is getting passed a null
'file->f_op' pointer, and is exiting the __mmap() function with
-ENODEV.. it's strange though, as even though file->f_op is at
0x00000000, the function file->f_op->mmap() points to a valid address!
so if the file_operations struct is getting allocated at 0x00000000 this
will cause all sorts of problems.. the major one being 0x00000000 is
null, even though it is a valid logical memory address.."




--
Mike Wolf
Cray Research
655-F Lone Oak Drive, Eagan, MN 55121
mwolf@cray.com          (651)683-5313

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
