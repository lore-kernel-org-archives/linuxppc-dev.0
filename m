Subject: Re: new ATI sleep code freezes
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: mutex@kerneli.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030605163550.GL1982@heliosphan>
References: <20030529154143.GC7896@heliosphan>
	 <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
	 <20030604162837.GF1982@heliosphan> <1054746955.696.7.camel@gaston>
	 <20030605163550.GL1982@heliosphan>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1054844448.27389.418.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 05 Jun 2003 22:20:48 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-06-05 at 18:35, mutex@kerneli.org wrote:
> On Wed, Jun 04, 2003 at 07:15:55PM +0200 or thereabouts,
> Benjamin Herrenschmidt wrote:
> > Also make sure you have APM emulation working (check XFree log to see
> > if it found & opened the APM device)
>
> from my XF86Config file...
>
> (WW) Open APM failed (/dev/apm_bios) (No such file or directory)
>
> But my kernel config says...
> CONFIG_PMAC_APM_EMU=y
>
> The only thing unusual is I am running devfs..
> so i checked /dev
>
> heliosphan dev # find . -name *apm*
> ./misc/apm_bios
> ./apm_bios
>
> /dev/misc/apm_bios has perms:
>
> crw-------    1 mutex    root      10, 134 Dec 31  1969 apm_bios
>
> are those normal permissions ?

I don't know, I don't use devfs, I have:

crw-rw----    1 root     root      10, 134 2003-04-29 13:04
/dev/apm_bios

Anyway, the X server doesn't try to use /dev/misc/apm_bios but
/dev/apm_bios and gets ENOENT.


> Also, I'm running an enlightenment battery applet which afaik uses apm
> layer to report battery level. So something has to be working.

It might use /proc/apm.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
