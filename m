Date: Sun, 3 Oct 1999 12:46:47 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: trouble with open()
Message-ID: <19991003124647.A1406@them.org>
References: <37F78356.5D7C54DF@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37F78356.5D7C54DF@andrew.cmu.edu>; from hollis@andrew.cmu.edu on Sun, Oct 03, 1999 at 12:24:54PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 03, 1999 at 12:24:54PM -0400, hollis@andrew.cmu.edu wrote:
> 
> Ok, maybe I'm just being really stupid, but the following code isn't
> working for me.
> 
> I'm trying to open /dev/dsp. The file descriptor returned by open is 0,
> which is supposed to be stdin, right? Anyways, a subsequent call to
> ioctl doesn't like fd 0 either.
> 
> [dev->path = "/dev/dsp"]
> 
>     printf("attmpting to open %s\n", dev->path);
>     if (dev->dev_fd = open(dev->path, O_RDWR) < 0) {
>         perror(dev->path);
>         fprintf(stderr, "Couldn't open audio device %s!\n", dev->path);
>         return -1;
>     }
>     printf("dev_fd = %i\n", dev->dev_fd);

Nope, not trouble with open(), trouble with if.

Take another good look at your if clause; you need another set
of parentheses around (dev->dev_fd = open(dev->path, O_RDWR). = is
lower precedence than <.


> 
> When I run this code, my output is:
> attempting to open /dev/dsp
> dev_fd = 0
> 
> The permissions are set fine, and I get the same problem with
> /dev/audio.
> 
> What am I doing wrong? I ask because I'm a little frustrated at this
> point.
> 
> -Hollis
> 
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
