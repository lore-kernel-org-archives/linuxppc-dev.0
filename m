From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith r128
Date: Wed, 8 Mar 2000 22:11:31 -0500
Content-Type: text/plain
Cc: Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00030822191300.00546@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

I took one more look at the cache flush code for what the loader loads and
would like to make one small change.  The reason is as follows:  if the object
is loaded at an address whose last 5 bits are not 0 (say they are 30 decimal for
the sake of argument and the size is 8 bytes really two cache lines should be
flushed and not just one.  The way it was previously (after your change to
ppc_flush_icache) only 1 cache line was being flushed in this case.

    if(read(fd,ptr,size)!=size)
	FatalError("\n_LoaderFileToMem() read() failed: %s\n",strerror(errno));

#if defined(linux) && defined(__powerpc__)
 {
 int i;
 for (i = 0; i < size; i += 32)
    ppc_flush_icache(ptr+i);

 /* add this line to make sure any partial ending cache line gets flushed too */
 ppc_flush_icache(ptr+size-1)
 }
#endif

#ifdef DEBUGMEM
    ErrorF("=%lx\n",ptr);
#endif


Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
