Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B47A0DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 16:08:49 +1000 (EST)
In-Reply-To: <4672EE95.3030407@freescale.com>
References: <111819314606b8b45671.846930886.miltonm@bga.com>
	<4672EE95.3030407@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fbae4506b772f07d2a8c1d230bea82c8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] boot: find initrd location from device-tree
Date: Mon, 18 Jun 2007 01:08:43 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[replying to David and Scott the second sub-thread]

On Jun 15, 2007, at 2:55 PM, Scott Wood wrote:
> Milton Miller wrote:
>> The file name dtscan reflects the possibility that simiar functions
>> like the rmo_top might be added to the file.
> Aren't these kind of things what devtree.c is for?

Hmm... i guess .. I didn't need the fixups in that file, but I guess 
the xlate routines couuld be useful for find top of memory.

That file is for "not specific to device tree library (firmware 
callback vs flat tree)" utilities?

On Mon Jun 18 13:18:22 EST 2007, David Gibson wrote:
> On Fri, Jun 15, 2007 at 12:34:30PM -0500, Milton Miller wrote:
> >
> > The types.h header now includes libgcc limits.h for UINT_MAX.
> >


> > ---
> > The file name dtscan reflects the possibility that simiar functions
> > like the rmo_top might be added to the file.
>
> Hrm, not sure if it's worth creating a new file for this, it could
> probably go in devtree.c.

Ok, two votes.  I'll move it next post.

> > +void dt_find_initrd(void)
> > +{
> > +     int rc;
> > +     unsigned long long initrd_start, initrd_end;
> > +     void *devp;
> > +     static const char start_prop[] = "linux,initrd-start";
> > +     static const char end_prop[] = "linux,initrd-end";
>
> I see no point to using these constants, just use literals in the
> getprop() calls.

When I had them inline, the get-property and the printf calls exceeded 
80 characters, making lots of multi-line function calls.  And 
seperating them out out made the error printfs the same, so they could 
be collapsed by gcc.  Either isn't a real strong argument, so if you 
insist I will write it out, but I thought it was nicer this way.

>
> > +     devp = finddevice("/chosen");
> > +     if (! devp) {
> > +             return;
> > +     }
> > +
> > +     /* The properties had to be 8 bytes until 2.6.22  */
> > +     rc = getprop(devp, start_prop, &initrd_start, 
> sizeof(initrd_start));
> > +     if (rc < 0)
> > +             return;
> > +     if (rc == sizeof(unsigned long)) {
> > +             unsigned long tmp;
> > +             memcpy(&tmp, &initrd_start, rc);
> > +             initrd_start = tmp;
> > +     } else if (rc != sizeof(initrd_start)) {
> > +             printf("unexpected length of %s in /chosen!\n\r", 
> start_prop);
> > +             return;
> > +     }
> > +
> > +     rc = getprop(devp, end_prop, &initrd_end, sizeof(initrd_end));
> > +     if (rc < 0) {
> > +             printf("chosen has %s but no %s!\n\r", start_prop, 
> end_prop);
> > +             return;
> > +     }
> > +     if (rc == sizeof(unsigned long)) {
> > +             unsigned long tmp;
> > +             memcpy(&tmp, &initrd_end, rc);
> > +             initrd_end = tmp;
> > +     } else if (rc != sizeof(initrd_end)) {
> > +             printf("unexpected length of %s in /chosen!\n\r", 
> end_prop);
> > +             return;
> > +     }
> > +
> > +     if (!initrd_start)
> > +             return;
> > +
> > +     /* if the initrd is above 4G, its untouchable in 32 bit mode */
> > +     if (initrd_end <= UINT_MAX && initrd_start < initrd_end) {
> > +             loader_info.initrd_addr = initrd_start;
> > +             loader_info.initrd_size  = initrd_end - initrd_start;
> > +     } else {
> > +             printf("ignoring loader supplied initrd parameters\n");
>
> Saying why might be helpful.

Hmm... well, that would mean seperating the && of the if; there are two 
possible reasons. (1) this 32-bit code can't handle such large 
addresses (in which case a 64-bit kernel may work), and (2) end is >= 
start (which means there really isn't any data.  I suppose I could 
reverse the sense of the if, use an else if, and make the final else 
the good path.



>
> > +     }
> > +}
...
> > Index: kernel/arch/powerpc/boot/types.h
> > ===================================================================
> > --- kernel.orig/arch/powerpc/boot/types.h     2007-06-15 
> 03:36:21.000000000 -0500
> > +++ kernel/arch/powerpc/boot/types.h  2007-06-15 03:44:34.000000000 
> -0500
> > @@ -1,6 +1,9 @@
> >  #ifndef _TYPES_H_
> >  #define _TYPES_H_
> >
> > +#define _LIBC_LIMITS_H_              /* don't recurse to system's 
> headers */
> > +#include <limits.h>          /* MAX_UINT, etc */
> > +
>
> I think it's really a bad idea to use any headers from outside the
> boot context here.  We're dealing with explicit sized ints, so we can
> safely define our own constants giving the limit values.

As I said in the patch changelog, the only headers picked up here are 
libgcc.  The compiler is part of the boot context, and we already pick 
up stdarg from there.   The flag there appears to be what libgcc 
expects the library to use.

I could change the comment to say /* get libgcc header only */ or 
something else you suggest.

milton
