Date: Sun, 20 Jun 1999 09:51:27 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Gilles Depeyrot <Gilles.Depeyrot@wanadoo.fr>
Cc: linuxppc-user <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC1999: shared libraries and dlopen not working ?
Message-ID: <19990620095127.A12081@drow.res.cmu.edu>
References: <199906201323.PAA19742@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199906201323.PAA19742@wanadoo.fr>; from Gilles Depeyrot on Sun, Jun 20, 1999 at 03:22:25PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 20, 1999 at 03:22:25PM +0200, Gilles Depeyrot wrote:
> Hi,
> 
> I'm having trouble getting shared libraries and dlopen to work under
> LinuxPPC1999.
> 
> I have attached three small files dltest.c, lib1.c and lib2.c. lib1 and
> lib2 must be built as shared libraries and dltest as an executable.
> 
> The test does the following:
> 
> /* dltest
>  * test functionality of dlopen(), dlsym() and dladdr()
>  *
>  * dlopen()  test, w/ and w/o .init function
>  * dlsym()   test, can we retrieve address from symbol
>  * dladdr()  test, given an address, can we find where its from
>  */
> 
> It fails on the first dlopen...

First of all: learn to use dlerror().  It is your friend in places like
this.  It tells me: "Invalid mode for dlopen()".  From glibc I see this
(use the source, Luke!):

  if ((mode & RTLD_BINDING_MASK) == 0)
    /* One of the flags must be set.  */
    _dl_signal_error (EINVAL, file, _("invalid mode for dlopen()"));

You didn't give it a binding mask.  RTLD_GLOBAL isn't enough.  Give it
one of RLTD_NOW or RTLD_LAZY or'd with RTLD_GLOBAL.

All your tests pass after that change.


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
