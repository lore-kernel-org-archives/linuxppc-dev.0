Date: Wed, 3 Nov 1999 10:36:18 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: compile-error: stdin is not a constant
Message-ID: <19991103103617.A26462@drow.res.cmu.edu>
References: <99110313351500.00438@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99110313351500.00438@localhost.localdomain>; from Wolfgang Haeuptli on Wed, Nov 03, 1999 at 01:25:44PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 03, 1999 at 01:25:44PM +0100, Wolfgang Haeuptli wrote:
> 
> Hello people
> 
> sorry for the (probably) basic question...
> 
> Since I installed R5, some programs (that used to compile OK on R4) 
> complain about : 
> 
> initializer element for 'foo' is not constant
> 
> while compiling constructs like:
> 
> FILE *foo = stdin;   (or FILE *foo = {(FILE *) stdin};  )

Because it isn't a constant any more.

> 
> when I replaced this line with: FILE *foo = STDIN_FILENO; 
> ( defined in unistd.h), compilation works, but the resulting program
> segfaults...

Which should generate one hell of a warning, since STDIN_FILENO is a
small number, not a struct FILE *.

You need to initialize the variable early in main() or something along
those lines, or you can declare a constructor using __attribute__,
although I do not remember the syntax (search list archives).

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
