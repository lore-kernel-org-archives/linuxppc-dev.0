Date: Wed, 27 Sep 2000 21:07:16 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14802.16462.166588.375647@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009272059060.9291-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > So here we have three fb devices in the kernel (you could check with
>  > fbset that each is in fact accessible via /dev/fb[0-2]), and XFree unable
>  > to cope.
>
> The ati driver unable to cope.  The fbdev driver copes without
> complaint.

That's what I mean - the fbdev driver knows about the correct addresses
(it gets them from the fb.fix strucure).

>  > You specify the PCI bus ID but not the corresponding framebuffer
>  > device node
>
> In the XF86Config?  That has both the bus id and the dev node:
>
>         Option     "UseFBDev"
>         Option  "fbdev" "/dev/fb0"
>         Driver      "fbdev"
>         BusID       "PCI:0:18:0"

S**t. I overlooked that. Ok, I officially declare the ati driver unable to
cope. Please disable the fb_open_pci() call in fbdevhw.c:

Bool
fbdevHWInit(ScrnInfoPtr pScrn, pciVideoPtr pPci, char *device)
{
 	fbdevHWPtr fPtr;

	TRACE_ENTER("Init");

	fbdevHWGetRec(pScrn);
	fPtr = FBDEVHWPTR(pScrn);

	/* open device */
#if 0
	if (pPci)
	        fPtr->fd = fbdev_open_pci(pPci,NULL);
	else
#endif
	    	fPtr->fd = fbdev_open(device,NULL);


> Hmm, if change the driver to "ati", am I also supposed the change the
> device node Option to "ati", ie 'Option "ati" "/dev/fb0"'?  I never
> tried that.

Nope, the syntax should be OK. Question is does the ati driver parse that
option if fb_open_pci is used.

I'm just speculating here, and I've never tried using the traditional fb
open so no guarantee it will work - and you're on your own if the ati
driver insist on using PCI.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
