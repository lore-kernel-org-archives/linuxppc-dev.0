To: Geert.Uytterhoeven@cs.kuleuven.ac.be
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: New XF68_FBDev
In-Reply-To: Your message of "Sat, 5 Dec 1998 20:43:38 +0100 (MET)"
	<Pine.LNX.4.02.9812051920310.864-100000@cassiopeia.home>
References: <Pine.LNX.4.02.9812051920310.864-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981207010902R.roikawa@rr.iij4u.or.jp>
Date: Mon, 07 Dec 1998 01:09:02 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Oops, I meant `Ryuichi's latest changes for mach64im.c'. I start to wonder
> > > whether I really need them, since these things worked fine before, too. Or am I
> > > getting insane and talking nonsenses?
> >  Excuse me, what are "them" exactly ?
> 
> The byteorder stuff in mach64im.c. I don't see a difference with or without
> them.
 Sorry, but I don't believe that different data give the same result.
I think you can see difference for example by experimentally changeing to
    if ( 1 /* (alu != MIX_SRC) || ((planemask & PMask) != PMask)*/ ) {
	mach64ImageWriteHW(x, y, w, h, psrc, pwidth, px, py,
			   alu, planemask);
and executing XPutImage function.

As a matter of fact, I added byte/bit reordering because I didn't any
documents about Mach64 registers other than XFree86 code. Now that I
have got the documents(thanks!), I understand all should be done is
simply setting host control register appropriately, for at least
Mach64VT or above. I intend to rewrite mach64im.c faster and more
efficiently.

> Never trust mail ordering.
 Indeed. Original messages are coming several days after followups
these days. It is difficult for me to understand what are discussed.
I wonder I subscribe the list wrong way.

BTW, I think it is better to revert this to the original
 because mach64MaxX and mach64MaxY are not sizes but coordinates.
+    mach64VirtX = mach64MaxX = mach64InfoRec.virtualX;
+    mach64VirtY = mach64MaxY = mach64InfoRec.virtualY;

Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
