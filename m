Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id BD9B567A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 06:29:55 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 670FAA4021
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 22:29:51 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 21 Apr 2005 22:29:47 +0200
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CC05@ratatosk.combitechsystems.com>
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CC05@ratatosk.combitechsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200504212229.47834.roger.larsson@norran.net>
Subject: Re: Preemption patch problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 21 April 2005 12.08, Bj=F6rn =D6stby wrote:
> Greetings.
>
> I have been struggling with the famous preemption patch (from Robert Love)
> the past few days. Im using mpc823e and tried with kernels
> 2.4.{18,21,22,23}. The patch applies flawless and so on, but when the
> kernel is up and running strange memory problems start to appear like:
>
> _alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)

[
   #define __GFP_DMA       0x01
* #define __GFP_HIGHMEM   0x02
* #define __GFP_WAIT      0x10    /* Can wait and reschedule? */
   #define __GFP_HIGH      0x20    /* Should access emergency pools? */
* #define __GFP_IO        0x40    /* Can start low memory physical IO? */
* #define __GFP_HIGHIO    0x80    /* Can start high mem physical IO? */
* #define __GFP_FS        0x100   /* Can call down to low-level FS? */

=2D - -
#define GFP_HIGHUSER    (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
|=20
__GFP_FS | __GFP_HIGHMEM)
=2D - -
]

So page_alloc is called with GFP_HIGHUSER, from where and why?

Try to find out what is causing this, set the 'vm_gfp_debug'
see 'linux/mm/page_alloc.c'

>
> Right, so... It seems like a giant memory leak of some sort, cause when I
> run programs the kernel goes ballistic and starts reaping processes:
>
> "VM: Killing process <name>"

Well the problem is that it actually is not getting any memory. It might be
code that retries to allocate memory when there really are none (you probab=
ly
do not use swap)

>
> Eventually it comes down to "VM: killing init" and then it's curtains.
>
> I know that these problems is caused by the patch since the kernel runs
> smooth without the patch applied. Does anyone have a clue what to do here
> (beside let go of the patch)?

Analyze memory usage on the working non patched kernel.

/RogerL
