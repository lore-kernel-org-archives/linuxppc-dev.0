Date: Wed, 9 Aug 2000 09:26:34 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809084422.4567@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000809091229.866B-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:

> >Until now I've found a single place where sys_tz.dsttime is used in the
> >kernel: fs/fat/misc.c when converting between Unix and FAT timestamps.
> >Interestingly it's used only in one direction, so it definitely looks like
> >a bug. Some other filesystems (affs/hfs/ncpfs/ufs) use the timezone
> >information but not the dst field, making FAT time handling look even
> >buggier.
>
> Yep. My understanding (and that's also how MacOS uses it) is that the DST
> correction is _included_ in the timezone offset, the dst field beeing
> just an indication. So yes, FAT is probably broken.

I agree that the way FAT does appear to buggy, but it would be better to
use *minuteswest and *dsttime in kernel as in userland IMHO.  When
localtime() in /usr/include/time.h is called, two global variables are
set.  One is timezone and the other is daylight, and here is how it works:

$ cat t.c
#include <stdio.h>
#include <time.h>

int main()
{
	time_t gmt;
	struct tm cur_tm;

	gmt = time( NULL );
	cur_tm = *gmtime( &gmt );
	printf("UTC %02d:%02d:%02d\n",cur_tm.tm_hour,cur_tm.tm_min,cur_tm.tm_sec);
	cur_tm = *localtime( &gmt );

	printf("local %02d:%02d:%02d\n",cur_tm.tm_hour,cur_tm.tm_min,cur_tm.tm_sec);
	printf("timezone = %d\n", timezone);
	printf("daylight = %d\n", daylight);

	return 0;
}

$ gcc -o t t.c
$ ./t
UTC 14:11:31
local 09:11:31
timezone = 21600
daylight = 1
$

As you can see, "timezone" does not include the DST offset, so any
applications which care need to use "daylight" flag.  Since the kernel's
struct timezone has two equivalent fields, I would think it's easier to
maintain timezone related codes if its usage are also somewhat equivalent
to userland.  Otherwise, I see no point in having a separate useless DST
info.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
