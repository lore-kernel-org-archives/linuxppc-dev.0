Date: Fri, 30 Jul 1999 03:07:39 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
Subject: nasty powerpc mmap problems (was: Re: Vger broken w.r.t. gdb)
Message-ID: <19990730030738.A1450@them.org>
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org> <199907290548.PAA02760@tango.anu.edu.au> <19990730011819.A364@them.org> <199907300524.PAA03967@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907300524.PAA03967@tango.anu.edu.au>; from Paul Mackerras on Fri, Jul 30, 1999 at 03:24:26PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[CC me in replies, I'm not on linux-kernel]

Background from the thread on linuxppc-dev: with the current vger tree,
gdb's breakpoints are apparently being set in the wrong copy of a
shared library, and not properly removed.  After running gdb over any
program, even with no extra breakpoints set, every dynamically linked
program run inside or outside of gdb dies with SIGTRAP.  The SIGTRAP
appears to be in _dl_debug_state or thereabouts in ld.so.

However, it now appears that this is symptomizing some much larger
problems with mmap().

On Fri, Jul 30, 1999 at 03:24:26PM +1000, Paul Mackerras wrote:
> Daniel Jacobowitz <drow@false.org> wrote:
> 
> > Now I'm really confused.
> > 
> > >From my readings it appears that we should only reach this point if a
> > trap instruction was encountered.  But from what I can see no trap
> > instruction exists at that address.  At
> 
> A common thing that gdb does is to put trap instructions into the
> memory image of a process being debugged.  It sounds to me as though,
> with all the page cache and memory management changes that have gone
> on in 2.3, we now have the undesirable situation that a trap
> instruction put in by gdb hasn't stayed confined to the process being
> debugged but has leaked into the copy of the page that is being used
> by other processes.

Woah!

I've found a much simpler test case for this problem.  It seems to me
to be more than ptrace being broken.  I wrote two test programs; mmap1
merely opens a file, mmaps it, closes it, prints some debugging info,
sleeps, and prints a little more.  Notice the permissions:
  int fd = open("testfile", O_RDONLY);
  ptr = mmap(0, 0x4000, PROT_READ|PROT_EXEC, MAP_SHARED, fd, 0);
  close(fd);

'attach' attaches to mmap1 and changes one value via PTRACE_POKEDATA.

Regard this:

drow:~/mmap$ dd if=/dev/zero of=testfile bs=4096 count=4
4+0 records in
4+0 records out
drow:~/mmap$ od testfile
0000000 000000 000000 000000 000000 000000 000000 000000 000000
*
0040000
drow:~/mmap$ ./mmap1
ptr[0x3000] is 0.
ptr + 0x3000 is 0x30017000.
And I am 1446

(in another window)
drow:~/mmap$ ./attach 1446 0x3001700
Value read was 0.
Value reread was 1.

(in the first window)
ptr[0x3000] is 1.
drow:~/mmap$ od testfile
0000000 000000 000000 000000 000000 000000 000000 000000 000000
*
0030000 000000 000001 000000 000000 000000 000000 000000 000000
0030020 000000 000000 000000 000000 000000 000000 000000 000000
*
0040000




Now hold on one second here!  We just changed the testfile that we'd
opened readonly and mmaped read|exec.  Something is definitely messed
up here.  Worse yet, this happens even if I have no permission to write
to the testfile.

Hopefully this is just on powerpc; could anyone running vger unstable
on another architecture test this?  The test programs are at
<http://www.them.org/~drow/mmap/>.  Can anyone offer insight?




Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
