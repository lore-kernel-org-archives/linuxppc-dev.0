Message-ID: <3805EE77.DFC69FCA@fadata.bg>
Date: Thu, 14 Oct 1999 17:53:43 +0300
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: serial on lombard
References: <19991014163425.001988@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> --- minicom-1.82.orig/src/main.c        Thu Aug 27 00:54:16 1998
> +++ minicom-1.82/src/main.c     Thu Oct 14 16:20:00 1999
> @@ -158,7 +158,7 @@
>    if (setjmp(albuf) == 0) {
>         portfd = -1;
>         signal(SIGALRM, get_alrm);
> -       alarm(2);
> +       alarm(4);
>  #if defined(O_NDELAY) && defined(F_SETFL)
>         portfd = open(dial_tty, O_RDWR|O_NDELAY);
>         if (portfd >= 0){

I think the code should be as follows:
   signal( SIGALRM, a_signal_handler_which_just_returns );
   alarm(4);
   portfd = open( dial_tty, O_RDWR|O_NONBLOCK);
   alarm(0);
   if( portfd >= 0 ) {
      ...

In old code (and in the patched one too) there is a race condition
between clearing the alarm and signal delivery. A sequence similar
to the above one relies only on the return value of open().
Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
