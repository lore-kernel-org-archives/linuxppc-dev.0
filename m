Date: Fri, 5 May 2000 16:49:04 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with cross-endian bitfields?
Message-ID: <20000505164904.A29233@drow.res.cmu.edu>
References: <852568D6.006ADE94.00@D51MTA03.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <852568D6.006ADE94.00@D51MTA03.pok.ibm.com>; from jlquinn@us.ibm.com on Fri, May 05, 2000 at 03:27:21PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 05, 2000 at 03:27:21PM -0400, jlquinn@us.ibm.com wrote:
>
> Hi, all.  I'm working on getting the Advansys driver working and what
> appears to be the final stumbling block is a difference in the layout of
> bitfields between little-endian and big-endian systems.  In particular,
> there are structs like the following:
>
> struct blah {
>   uchar a : 3;
>   uchar b : 3;
>   uchar c : 2;
> }
>
> On a little endian machine, this works like I expect.  (blah & 0x07) ==
> blah.a is true.  On linuxppc (and apparently MacOS as well), this is NOT
> true.  blah.a refers to the 3 most significant bits.  The linuxppc behavior
> seems counterintuitive to me because I expected each successive member in a
> struct to be the next physical piece of data I encounter.
>
> Can someone tell me what's going on here?  Am I going to have to have
> ifdef's on these structs, or resort to mask macros, or is there a
> reasonable solution here.

As Dan Malek said, there is no defined ordering.  The compiler is free
to do whatever it wishes.  You can't assume that.  (I think.)

Also, by your intuition, the obvious thing IS happening.  Remember that
we are big-endian - the first thing in memory is big-endian.  Thus, it
follows logically that a should be in the first three (most
significant) bits.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
