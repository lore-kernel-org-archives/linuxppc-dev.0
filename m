Subject: Re: XV lockups with SMP 2.4.19-rc1-ben0
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Henry Worth <haworth15@attbi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3D2DC734.9040503@attbi.com>
References: <3D2A09D1.3080700@attbi.com> <1026165472.1263.654.camel@tibook>
	 <3D2DC734.9040503@attbi.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 11 Jul 2002 22:46:06 +0200
Message-Id: <1026420371.1199.2006.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-07-11 at 19:58, Henry Worth wrote:
> Michel Dänzer wrote:
>
> >
> >This is very likely related to DRI. Disable it or start a second server
> >with it disabled for Xv or try
> >http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-optiondmaforxv.diff
> >
> I've had a chance to try 4.2.99 and this patch against 4_2-branch, both
> synced to CVS today, a few observations:
>
> 4_2-branch with patch:
>
> _Xine plays fine with dri enabled with both 4.2.99 and patched 4_2-branch.

I think the patch has been applied on the trunk.

> _With both server versions, glxgears will run concurrently with xine, with
>   great performance, for about 30 secs, and then will hang the X server.

If this is with agpgart, try without.

> _With 4.2.99 and dri enabled, glxgears does display correctly. Instead of
>    the gears, the window is filled with fragments of very large polygons
>    of the correct colors, moving in a vaguely circular, but still scrambled
>    pattern with many appearing to be the tips of the gear teeth.
>
>    Perhaps an endian problem? Works fine with dri disabled. Are there
>    any test programs available that exercise dri directly to isolate the
>    problem to libGL or DRI.

If you want to work on DRI, you should get the DRI CVS, which is broken
differently and will be merged into XFree86 for 4.3.0. The driver is
broken since it's been updated for Mesa 4.0.x, and I don't have hardware
to test and fix it anymore.


> _Both the YDL installed 4.2 binaries and the patched 4_2-branch with DRI
>   enabled, the kdm login window is nearly unreadable. The subwindow
>   background has a cross-hatch, same as startup stipple, that blends with
>   the prompt and input field. Will sometimes clearup after a few VT
> switches or X restarts. Does not occur with DRI disabled or at all with 4.2.99.

If this only happens on server reset,
http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-indirectBuffer.diff should help. This is also on the CVS trunk already, and the radeon driver has been fixed even better in DRI CVS.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
