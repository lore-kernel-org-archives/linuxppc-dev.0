From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>,
	yellowdog-devel@lists.linuxppc.org
Subject: Fwd: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Date: Wed, 10 Oct 2001 22:53:18 -0400
Cc: Herbert Duerr <duerr@sun.com>, Olaf Hering <olh@suse.de>,
	kevin.hendricks@sympatico.ca
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_UCT0WVO2FHDMEA7K7API"
Message-Id: <20011011025115.HNCD13446.tomts8-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_UCT0WVO2FHDMEA7K7API
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Michel (and FYI Herbert).

The bug was in XF 4.1.0 in Xrender.c not in OpenOffice

The patch is attached.  They (XF4 guys) simply missed changing a variable
name and ended up using random garbage in an "if"

Dan and Olaf, if you haven't gone to press with new releases, you probably
should include this one in your next respin builds of XFree86 4.1.0

Michel will you see that this makes it into the next XF 4.X release for us.

Thanks,

Kevin



> Will you please look at the following diff from Xrender.c in XF 4.0.2 to
> Xrender.c in XF410.  It looks very strange.  Starting in lie 190.
> It seems they no longer Xmalloc a value for xFormat (they now use xData)
> but just one line later they check if xFormat is zero.

> The code before that in XRenderQueryFormats() doesNOT set a value for
> xFormat at all after its is declared and before it is tested.

> I think someone just missed changing and xFormat to an xData unless I am
> missing something here.

> Kevin



>@@ -190,19 +191,20 @@
>               rep.numScreens * sizeof (xPictScreen) +
>               rep.numDepths * sizeof (xPictDepth) +
>               rep.numVisuals * sizeof (xPictVisual));
>-    xFormat = (xPictFormInfo *) Xmalloc (rlength);
>+    xData = (void *) Xmalloc (rlength);
>
>     if (!xri || !xFormat)
>     {
>        if (xri) Xfree (xri);
>-       if (xFormat) Xfree (xFormat);
>+       if (xData) Xfree (xData);
>        _XEatData (dpy, rlength);
>        UnlockDisplay (dpy);
>        SyncHandle ();
>        return 0;

--------------Boundary-00=_UCT0WVO2FHDMEA7K7API
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xf410_render.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xf410_render.patch"

LS0tIHhjL2xpYi9YcmVuZGVyL1hyZW5kZXIuYy5wcmV2CVdlZCBPY3QgMTAgMjI6Mzg6MjUgMjAw
MQorKysgeGMvbGliL1hyZW5kZXIvWHJlbmRlci5jCVdlZCBPY3QgMTAgMjI6Mzk6MDkgMjAwMQpA
QCAtMTkzLDcgKzE5Myw3IEBACiAJICAgICAgIHJlcC5udW1WaXN1YWxzICogc2l6ZW9mICh4UGlj
dFZpc3VhbCkpOwogICAgIHhEYXRhID0gKHZvaWQgKikgWG1hbGxvYyAocmxlbmd0aCk7CiAgICAg
Ci0gICAgaWYgKCF4cmkgfHwgIXhGb3JtYXQpCisgICAgaWYgKCF4cmkgfHwgIXhEYXRhKQogICAg
IHsKIAlpZiAoeHJpKSBYZnJlZSAoeHJpKTsKIAlpZiAoeERhdGEpIFhmcmVlICh4RGF0YSk7Cg==

--------------Boundary-00=_UCT0WVO2FHDMEA7K7API--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
