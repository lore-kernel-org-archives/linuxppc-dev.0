Date: Sun, 12 Sep 1999 19:45:54 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        erbenson@alaska.net
Subject: Re: quik 2.0 fix
In-Reply-To: <19990911110100.027102@smtp.calvacom.fr>
Message-ID: <Pine.LNX.4.10.9909121934360.1132-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nice that fixed the following error from quik in my machine:
# /sbin/quik -v
Second-stage loader is on /dev/sdb0
Config file is on partition 6
Fatal error: Cannot open /dev/sdb0

There are a few problems with gcc 2.95.1 though, the second stage loader
gives "Unable to open filesystem" errors reverting to the old files
fixed that.
Since my asm skills are nonexistent i can't tell if its a gcc or a quik
problem, can someone look at it ?

  Kostas Gewrgiou

On Sat, 11 Sep 1999, Benjamin Herrenschmidt wrote:

> 
> It took me a while to figure out why my printf's were displaying crazy
> results until I found out the glibc2.1 dev_t is a long long ! So this fix
> will make quik correctly recognize the partition number:
> 
> --- quik.c.old	Sat Sep 11 10:52:54 1999
> +++ quik.c	Sat Sep 11 10:52:01 1999
> @@ -521,7 +521,7 @@
>  	bootdev[7] += UNIT(st1.st_dev);
>      strcpy(spart, bootdev);
>      if (PART(st1.st_dev) != 0)
> -	sprintf(spart+8, "%d", PART(st1.st_dev));
> +	sprintf(spart+8, "%d", (int)PART(st1.st_dev));
>  
>      if (verbose)
>  	printf("Second-stage loader is on %s\n", spart);
> 
> 
> -- 
>            E-Mail: <mailto:bh40@calva.net>
> BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
> 
> 
> 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
