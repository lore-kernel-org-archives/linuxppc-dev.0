Message-ID: <3D2DC734.9040503@attbi.com>
Date: Thu, 11 Jul 2002 10:58:12 -0700
From: Henry Worth <haworth15@attbi.com>
MIME-Version: 1.0
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XV lockups with SMP 2.4.19-rc1-ben0
References: <3D2A09D1.3080700@attbi.com> <1026165472.1263.654.camel@tibook>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

>
>This is very likely related to DRI. Disable it or start a second server
>with it disabled for Xv or try
>http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-optiondmaforxv.diff
>
>
I've had a chance to try 4.2.99 and this patch against 4_2-branch, both
synced to
CVS today, a few observations:

4_2-branch with patch:

_Xine plays fine with dri enabled with both 4.2.99 and patched 4_2-branch.

_With both server versions, glxgears will run concurrently with xine, with
  great performance, for about 30 secs, and then will hang the X server.

_With 4.2.99 and dri enabled, glxgears does display correctly. Instead of
   the gears, the window is filled with fragments of very large polygons
   of the correct colors, moving in a vaguely circular, but still scrambled
   pattern with many appearing to be the tips of the gear teeth.

   Perhaps an endian problem? Works fine with dri disabled. Are there
   any test programs available that exercise dri directly to isolate the
   problem to libGL or DRI.

_Both the YDL installed 4.2 binaries and the patched 4_2-branch with DRI
  enabled, the kdm login window is nearly unreadable. The subwindow
  background has a cross-hatch, same as startup stipple, that blends with
  the prompt and input field. Will sometimes clearup after a few VT
switches
  or X restarts. Does not occur with DRI disabled or at all with 4.2.99.

This is on a dual 450MHz G4 AGP PMAC with YDL 2.2 and Rage 128 PF
in 24bpp mode:


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
