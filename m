Date: Thu, 22 Jul 1999 13:15:59 -0400
From: Daniel Jacobowitz <drow@false.org>
To: "ian reinhart geiser (ADMIN)" <geiseri@msoe.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Unresolved symbols....
Message-ID: <19990722131559.A4092@drow.res.cmu.edu>
References: <m117LAK-0000WZC@tri-yann.crf.canon.fr> <Pine.OSF.3.96.990722115246.30323A-100000@torres.msoe.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.OSF.3.96.990722115246.30323A-100000@torres.msoe.edu>; from ian reinhart geiser (ADMIN) on Thu, Jul 22, 1999 at 11:54:54AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 22, 1999 at 11:54:54AM -0500, ian reinhart geiser (ADMIN) wrote:
> 
> i am compileing the postgres ODBC drivers and i get the following
> error on linking:
> 
> ld -Bdynamic -shared -soname libpsqlodbc.so.0.25 -Bsymbolic -lc -lm -o
> libpsqlod
> bc.so.0.25 info.o bind.o columninfo.o connection.o convert.o drvconn.o
> environ.o
>  execute.o lobj.o misc.o options.o pgtypes.o psqlodbc.o qresult.o
> results.o sock
> et.o parse.o statement.o gpps.o tuple.o tuplelist.o dlg_specific.o   -lc

I'm not so sure that you want -Bsymbolic.  Plus, using ld for linking
is rarely a good idea; you should always use gcc.

> /lib/libc.so.6: undefined reference to `_r_debug@@GLIBC_2.0'
> /lib/libc.so.6: undefined reference to `_dl_unload_cache@@GLIBC_2.1'

All of these are symbols from the dynamic linker.  That they aren't
being found implies mislinking.


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
