Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Date: Wed, 10 Oct 2001 21:53:37 -0400
Cc: linuxppc-dev@lists.linuxppc.org, kevin.hendricks@sympatico.ca
References: <20011011011945.DFYL19597.tomts17-srv.bellnexxia.net@there> <1002764279.4001.662.camel@pismo>
In-Reply-To: <1002764279.4001.662.camel@pismo>
MIME-Version: 1.0
Message-Id: <20011011015130.DBWA27994.tomts14-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > If I specify depth 32, I used to get 24 bits of color depth with 32
> > bpp in the Rage 128 driver.
>
> No you didn't. XFree86 4 has never supported depth 32.

I thought that the 24 depth was the broken one that was not supported
early on and all that did work was 8, 16, and 32 (or am I confusing the
kernel driver versus the XFree86 driver).

> > But if I specify 24 bits of color depth I seem to be getting cfb24
> > being used instead of cfb32.
>
> Only if you specify DefaultFbBpp 24 in Section "Screen" or -fbbpp 24 on
> the command line. The default for depth 24 is 32 bpp in the r128 driver
> - has always been AFAIR.

Okay, I must have misread it.

> In contrast to framebuffer devices, XFree86 strictly separates the terms
> 'depth' and 'bits per pixel'.

It never used to ;-)   It used to confuse them all the time for a depth of
15 in 16bpp called a depth of 16.  That used to drive the JDK crazy.

> > and the resulting visuals have changed.
>
> The problem might be related to visuals, things have changed about them
> due to the RENDER extension and other things; I don't know details, you
> might want to check out the Xpert mailing list archives.

Yes, the error happens in the XRender lib but it is partially our fault.
I am just trying to figure out what changed.  Here is the relevant code
from OOo:

  // the 8bit alpha mask format must be there
    XRenderPictFormat aPictFormat={0,0,8,{0,0,0,0,0,0,0,0xFF},0};
    mpGlyphFormat = (*pXRenderFindFormat)( mpDisplay, 0, &aPictFormat, 1 );

    // and support for the visual
    XRenderPictFormat*  pVisualFormat =  (*pXRenderFindVisualFormat)(
mpDisplay, _pVisual );
    if( pVisualFormat != NULL )
        mbUsingXRender = true;

The problem is that the call to XRenderFindFormat() is returning 0 under
XF4.1.0 under Rage 128 but it previously returned a proper value under XF
4.0.2 using Rage 128.

> If this is the problem, it's most likely an OpenOffice bug. Applications
> tend to make false assumptions about visuals and/or not handle them
> correctly.

Quite probably, the interesting thing here is that this all works under XF
4.0.2 using Rage 128 and now fails under XF 4.1.0 using Rage 128 (but
works if the straight framebuffer is used).

So the issue is tied to the Rage 128 code in some way.

I will keep looking.

Thanks for your help!

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
