From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910141600.SAA10832@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <19991014163425.001988@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 14, 1999 04:34:25 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Thu, 14 Oct 1999 18:00:15 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I fixed my minicom by bumping the timeout to 4 seconds:
> 
> --- minicom-1.82.orig/src/main.c	Thu Aug 27 00:54:16 1998
> +++ minicom-1.82/src/main.c	Thu Oct 14 16:20:00 1999
> @@ -158,7 +158,7 @@
>    if (setjmp(albuf) == 0) {
>  	portfd = -1;
>  	signal(SIGALRM, get_alrm);
> -	alarm(2);
> +	alarm(4);
>  #if defined(O_NDELAY) && defined(F_SETFL)
>  	portfd = open(dial_tty, O_RDWR|O_NDELAY);
>  	if (portfd >= 0){

And I fixed it by modifying the serial port startup() code. Seems to work as
well - do we really need to wait that long for the modem to power up, or
will the modem just refuse to handshake while initializing?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
