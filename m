Date: Mon, 21 Jun 1999 23:09:21 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: dl-load.c (ld.so) bug??
Message-ID: <19990621230921.A20471@drow.res.cmu.edu>
References: <Pine.LNX.4.04.9906212045480.27642-100000@narn.local.drgw.net> <Pine.LNX.3.96L.990621222014.5237C-100000@unix47.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96L.990621222014.5237C-100000@unix47.andrew.cmu.edu>; from Hollis R Blanchard on Mon, Jun 21, 1999 at 10:48:12PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 21, 1999 at 10:48:12PM -0400, Hollis R Blanchard wrote:
> 
> > No. Electric Fence is designed to catch programming errors, such as
> > attempting to access memory which was not 'malloc'ed. I have traced this
> > down extensively a couple of months ago, and found that it does indeed
> > appear to overrun what it malloced.
> 
> I have two even simpler test cases for you:
> 
> int main(void){
>     char *ptr=NULL;
>     free(ptr);
> }

Well, that one would probably segfault anyway (or at least, is not
guaranteed not to).

> int main(void){
>     char *ptr = (char *)malloc(100);
> }        

That one's a problem, though :)

> If this were the case, wouldn't you expect ridiculous levels of instability?

Depends entirely on what it overwrote.

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
