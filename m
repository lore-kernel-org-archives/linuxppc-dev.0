To: Geert.Uytterhoeven@sonycom.com
Cc: roikawa@rr.iij4u.or.jp, mlan@cpu.lu,
        schmitz@opal.biophys.uni-duesseldorf.de, daenzerm@student.ethz.ch,
        toe@unlserve.unl.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: Your message of "Wed, 7 Jun 2000 17:10:39 +0200 (MET DST)"
	<Pine.GSO.4.10.10006071705280.652-100000@dandelion.sonytel.be>
References: <Pine.GSO.4.10.10006071705280.652-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000608005823P.roikawa@rr.iij4u.or.jp>
Date: Thu, 08 Jun 2000 00:58:23 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch] VRAM detection in controlfb

>
> On Wed, 7 Jun 2000, Ryuichi Oikawa wrote:
> > Geert did explain the problem. It is due to incorrect offset estimation.
> > Let me explain your case in detail. The authur of fbdev module seems to
> > assume frame buffer size as a multiple of page size:
> >
> > fbdevhw.c
> > void* fbdevHWMapVidmem(ScrnInfoPtr pScrn)
> > {
> > 	fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);
> >
> > 	TRACE_ENTER("MapVidmem");
> > 	if (NULL == fPtr->fbmem) {
> > 		fPtr->fboff = fPtr->fix.smem_len & (PAGE_SIZE-1);
> > 			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 		fPtr->fbmem = mmap(NULL, fPtr->fix.smem_len, PROT_READ | PROT_WRITE,
> > 				   MAP_SHARED, fPtr->fd, 0);
> >
> > but the fact is different from his assumption.  As you know very well,
> > controlfb adjusts fb memory size by subtracting display offset(in your
> > case 80 = 0x50 bytes) so that
> >     fboff = (4M - 0x50) & 0xfff = 0xfb0
> >     fbmem = smem_start & 0xfffff000 = smem_start - 0x50.
> >
> > Thus your Xserver's video memory starts at offset
> >     (fbmem + fboff) - smem_start = 0xfb0 - 0x50 = 0xf60 = 3936 bytes.
> >
> > Now you understand the fix is very simple:
> > -		fPtr->fboff = fPtr->fix.smem_len & (PAGE_SIZE-1);
> > +		fPtr->fboff = fPtr->fix.smem_start & (PAGE_SIZE-1);
>
> That's not sufficient (perhaps it is in this case, though): both fix.smem_start
> and fix.smem_len may be not page aligned. To catch all cases, you have to use
Can't /dev/fb mmap handle this case?  I just thought I saw some page
handling code which adds extra page in fbmem.c. I'm using this for /dev/mem:

  int pages, trailer_page = 0;

  if(basePhys & (PAGE_SIZE - 1))
    ++trailer_page;
  pages = (memSize + PAGE_SIZE - 1)/PAGE_SIZE + trailer_page;
  *baseVirt = (pointer)mmap(0, pages*PAGE_SIZE, PROT_READ|PROT_WRITE,
			    MAP_SHARED, fd, basePhys & PAGE_MASK);
  *baseVirt += basePhys & (PAGE_SIZE - 1);


> the formula from my previous posting.

> > But looking through the XF4 fbdev support code I saw two more mistakes
> > causing potential problem. One is a confusion of virtual screen width
> > with screen pitch:
> >
> > fbdev.c
> > 	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
> >
> > Yes, this is wrong as the authur noted, but interestingly this code spreads
> > over the all drivers supporting fbdev, though I can't distinguish which is
> > the original :^)  Maybe polite solution is to fix each driver, but quick
> > fix will be
> >
> > +	pScrn->displayWidth = fPtr->fix.line_width /
> > +				(fPtr->var.bits_per_pixel >> 3)
>
> Typo: the field is called `line_length', not `line_width'.
 Ah, I see, but I simply cut & pasted it.... where this comes?

> And that formula is valid for chunky displays only, not for interleaved
> bitplanes (I suppose pScrn->displayWidth is the width of one line in memory,
> counted in pixel units?).
Yes, it is used calculate video memory address from the x, y coordinate.
How is displayWidth used for planar architecture? Is setting
displayWidth == xres_virtual necessary to work properly?

> If line_length is 0, you must fallback to xres_virtual / bytes_per_pixel.
Like this?
+	if(fPtr->fix.line_width)
+		pScrn->displayWidth = fPtr->fix.line_width /
+				(fPtr->var.bits_per_pixel >> 3)


Thanks you,

--------------------------------------
Ryuichi Oikawa
roikawa@rr.iij4u.or.jp
http://www.rr.iij4u.or.jp/~roikawa
--------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
