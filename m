Date: Sun, 1 Aug 1999 22:45:36 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu
Subject: Re: nasty powerpc mmap problems (was: Re: Vger broken w.r.t. gdb)
Message-ID: <19990801224536.A376@them.org>
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org> <199907290548.PAA02760@tango.anu.edu.au> <19990730011819.A364@them.org> <199907300524.PAA03967@tango.anu.edu.au> <19990730030738.A1450@them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=EeQfGwPcQSOJBaQU
In-Reply-To: <19990730030738.A1450@them.org>; from Daniel Jacobowitz on Fri, Jul 30, 1999 at 03:07:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii

I think I've found the problem.  access_process_vm() would trigger a
page fault for write if the page was unmapped, but not if it was
already mapped for read.  The attached patch fixed all my problems.


On Fri, Jul 30, 1999 at 03:07:39AM -0400, Daniel Jacobowitz wrote:
> [CC me in replies, I'm not on linux-kernel]
> 
> Background from the thread on linuxppc-dev: with the current vger tree,
> gdb's breakpoints are apparently being set in the wrong copy of a
> shared library, and not properly removed.  After running gdb over any
> program, even with no extra breakpoints set, every dynamically linked
> program run inside or outside of gdb dies with SIGTRAP.  The SIGTRAP
> appears to be in _dl_debug_state or thereabouts in ld.so.

...

> I've found a much simpler test case for this problem.  It seems to me
> to be more than ptrace being broken.  I wrote two test programs; mmap1
> merely opens a file, mmaps it, closes it, prints some debugging info,
> sleeps, and prints a little more.  Notice the permissions:
>   int fd = open("testfile", O_RDONLY);
>   ptr = mmap(0, 0x4000, PROT_READ|PROT_EXEC, MAP_SHARED, fd, 0);
>   close(fd);


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-ptrace.diff"

Index: ptrace.c
===================================================================
RCS file: /cvs/linux/linux/kernel/ptrace.c,v
retrieving revision 1.2
diff -c -p -r1.2 ptrace.c
*** ptrace.c	1999/07/23 02:04:32	1.2
--- ptrace.c	1999/08/02 02:23:45
*************** repeat:
*** 38,43 ****
--- 38,45 ----
  	pgtable = pte_offset(pgmiddle, addr);
  	if (!pte_present(*pgtable))
  		goto fault_in_page;
+ 	if (write && !pte_write(*pgtable))
+ 		goto fault_in_page;
  	page = pte_page(*pgtable);
  	if (MAP_NR(page) >= max_mapnr)
  		return 0;

--EeQfGwPcQSOJBaQU--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
