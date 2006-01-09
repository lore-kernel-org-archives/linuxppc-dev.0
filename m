Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 1DB9A68A44
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 19:45:30 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Date: Mon, 9 Jan 2006 09:45:21 +0100
References: <20060106150854.918FF353A43@atlas.denx.de>
In-Reply-To: <20060106150854.918FF353A43@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601090945.22564.david.jander@protonic.nl>
Cc: HappyPhot <happyphot@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 06 January 2006 16:08, Wolfgang Denk wrote:
> This is a serious misunderstanding. There is no  such  thing  like  a
> specific kernel version which is supported by the ELDK.

True, but not entirely.
ELDK-3.1.1 has a glibc compiled with support of a certain version of the 
kernel (I guess it's 2.4.xx), so newer kernels might run (because they are 
obviously backwards compatible), but some features of 2.6 cannot be used 
(e.g. support for the latest syscalls, different HZ, etc...)

A second issue is the boot procedure. If you are a beginner with linux, you'd 
probably start booting from NFS root as it gets installed in the ELDK/ppc_xxx 
directory. That probably won't work very well with latest 2.6 kernels (device 
files missing, sysfs not mounted, shmfs has different name, etc...)

A third issue is the compiler issue. Some newer kernels might not compile 
correctly anymore with older compilers.

These three things are what I meant with "supported" or "not supported".

> The ELDK is primarily a *toolkit* which works with  arbitrary  C  and
> C++  programs  and  with  any version of the kernel tree (at least in
> theory; very recent version s of the Linux kernel [ > 2.6.14]  cannot
> be compiled with ELDK 3.1.x any more, but this is a different issue).

See what I mean? HappyPhot did just that: compile 2.6.14.2 with ELDK 3.1.1!!!

> > >   Do you know where to get the infomation about which kernel version it
> > > supports?
>
> The ELDK supports *any* kernel version.

Ok, let's talk about "recommended" kernel then. I would never recommend 
someone unexperienced to start with a combination of ELDK-3.1.1 and kernel 
2.6.xx.

> > The one that comes with that version of ELDK? Just a guess ;-)
>
> Wrong guess.

But it'd still be the one with most chances of success unless there are known 
problems with that kernel on a Sandpoint board.

Greetings,

-- 
David Jander
Protonic Holland.
