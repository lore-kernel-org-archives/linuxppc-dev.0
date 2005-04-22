Return-Path: <Bjorn.Ostby@combitechsystems.com>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id A05F367A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 20:48:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 22 Apr 2005 12:47:22 +0200
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC06@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
To: <roger.larsson@norran.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Preemption patch problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


OK! Thanks for the info.=20
I've implemented the gfp_debug and fiddled around a bit. Memory
problems is not my specialty and the only new info attached to the error =
message is:

"This architecture does not implement dump_stack()"

...Which seems fair for a ppc.

I have however carefully studied the memfree value in /proc/meminfo and
by every instance I execute of "cat /proc/meminfo" it decreases by 8K.
Since I had ruthless much time this morning, I actually manually =
depleted the whole 32 MB with this call.. When there's about 500kb left, =
suddenly 200kb
is given back, but if I do multiple "cat":s real fast, memfree goes =
below 500kb and the kernel just starts killing processes.

Anyway, im not that keen on start hacking the kernel to get this patch=20
going. I had put my hope to some strange kernel-config option which I =
might
had missed. If anyone knows of this, please let me know.


Best regards,
Bjorn Ostby





-----Original Message-----
From: Roger Larsson [mailto:roger.larsson@norran.net]=20
Sent: den 21 april 2005 22:30
To: linuxppc-embedded@ozlabs.org
Subject: Re: Preemption patch problem


On Thursday 21 April 2005 12.08, Bj=F6rn =D6stby wrote:
> Greetings.
>
> I have been struggling with the famous preemption patch (from Robert=20
> Love) the past few days. Im using mpc823e and tried with kernels=20
> 2.4.{18,21,22,23}. The patch applies flawless and so on, but when the=20
> kernel is up and running strange memory problems start to appear like:
>
> _alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)

[
   #define __GFP_DMA       0x01
* #define __GFP_HIGHMEM   0x02
* #define __GFP_WAIT      0x10    /* Can wait and reschedule? */
   #define __GFP_HIGH      0x20    /* Should access emergency pools? */
* #define __GFP_IO        0x40    /* Can start low memory physical IO? =
*/
* #define __GFP_HIGHIO    0x80    /* Can start high mem physical IO? */
* #define __GFP_FS        0x100   /* Can call down to low-level FS? */

- - -
#define GFP_HIGHUSER    (             __GFP_WAIT | __GFP_IO | =
__GFP_HIGHIO |=20
__GFP_FS | __GFP_HIGHMEM)
- - -
]

So page_alloc is called with GFP_HIGHUSER, from where and why?

Try to find out what is causing this, set the 'vm_gfp_debug' see =
'linux/mm/page_alloc.c'

>
> Right, so... It seems like a giant memory leak of some sort, cause=20
> when I run programs the kernel goes ballistic and starts reaping=20
> processes:
>
> "VM: Killing process <name>"

Well the problem is that it actually is not getting any memory. It might =
be code that retries to allocate memory when there really are none (you =
probably do not use swap)

>
> Eventually it comes down to "VM: killing init" and then it's curtains.
>
> I know that these problems is caused by the patch since the kernel=20
> runs smooth without the patch applied. Does anyone have a clue what to =

> do here (beside let go of the patch)?

Analyze memory usage on the working non patched kernel.

/RogerL
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org =
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
