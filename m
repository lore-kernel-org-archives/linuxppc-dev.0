Mime-Version: 1.0
Message-Id: <v04220800b6c12899d73e@[10.0.0.42]>
In-Reply-To: <3A9A2FBF.B304ADD1@valinux.com>
References: <3A76769B.87242FAA@valinux.com>				
 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com>
 <v04220800b6be6735bfd4@[165.247.215.42]> <3A9A246D.72D1B5BE@iiic.ethz.ch>
 <3A9A2A9D.8A779B@valinux.com> <3A9A2E16.6F679EF3@iiic.ethz.ch>
 <3A9A2FBF.B304ADD1@valinux.com>
Date: Tue, 27 Feb 2001 02:03:33 -0800
To: Gareth Hughes <gareth@valinux.com>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: r128 DRI driver now fully functional on PPC
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:28 PM +1100 2/26/01, Gareth Hughes wrote:
>Michel Dänzer wrote:
>>
>>  First I thought I'd stand corrected, but on second thought - it looks for
>>  /usr/X11R6-DRI/lib/modules/dri/r128_dri.so on my machine (if ProjectRoot is
>>  /usr/X11R6-DRI), but /usr/X11R6-DRI/lib isn't in ld.so.conf . It even looks
>>  there if I set LD_LIBRARY_PATH to the exports/lib directory in the
>>build tree.
>>
>>  Am I still not getting it? :)
>
>Sorry, my mistake.  libGL.so opens $MODULEDIR/dri/r128_dri.so, where
>$MODULEDIR is defined by the Imakefiles (and would be
>/usr/X11R6-DRI/lib/modules in your case).  So, the problem may be that
>the wrong libGL.so is being picked up -- and this *is* an ld.so.conf
>problem.

Could the Imakefiles have been broken by the following options in site.def?

#define NothingOutsideProjectRoot YES
#define EtcX11Directory ProjectRoot/etc

I enabled (uncommented) both of these since I thought it might be a
good idea to force X to be completely self-contained within
ProjectRoot.

I just tried a build without these options and it seems to clear up
the library problem.  After doing so I have only two differences from
the config files in CVS: I set ProjectRoot and disabled Glide3.  So
it's entirely possible that setting Nothing... and/or EtcX11Dir...
caused the compiled-in default library search path you describe to
get mangled.


I still have the problem with keyboard/mouse input being ignored once
a GL app starts.  A friend suggested disabling DGA, but that didn't
help.  I do notice this message popping in the system logs, repeated
numerous times:

[drm:drm_lock_take] *ERROR* 1 holds heavyweight lock

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
