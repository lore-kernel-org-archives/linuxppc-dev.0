Date: Wed, 3 Nov 1999 11:59:03 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: compile-error: stdin is not a constant
Message-ID: <19991103115903.A28115@drow.res.cmu.edu>
References: <99110313351500.00438@localhost.localdomain> <19991103103617.A26462@drow.res.cmu.edu> <382076B7.B14665A2@univ-rennes1.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <382076B7.B14665A2@univ-rennes1.fr>; from Martin Costabel on Wed, Nov 03, 1999 at 05:53:59PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 03, 1999 at 05:53:59PM +0000, Martin Costabel wrote:
> Maybe this will work (1):
> 
> FILE *foo = (FILE *) STDIN_FILENO;


No no no no no!  STDIN_FILENO is a -number-, not a -pointer-!

> In a similar situation, I learned from Tom Rini that the correct way
> would be (2)
> 
> static file *file ;
> static void file_construct (void) __attribute__((constructor));
> static void file_construct (void) { file = stdin; }

Yes, that's it.  gcc specific, but works.  (1) is DEFINITELY wrong.


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
