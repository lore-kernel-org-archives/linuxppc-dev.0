Return-Path: <stuarth@freescale.com>
Received: from n064.sc1.he.tucows.com (unknown [64.97.136.162])
	by ozlabs.org (Postfix) with ESMTP id E199BDDFA5
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 20:41:55 +1100 (EST)
Subject: Re: options for root file system for MPC8548
From: Stuart Hughes <stuarth@freescale.com>
To: tmorrison@empirix.com
Content-Type: text/plain
Date: Wed, 31 Jan 2007 09:11:37 +0000
Message-Id: <1170234697.25841.90.camel@m20>
Mime-Version: 1.0
Cc: linuxppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Jan 30, 2007, at 4:19 PM, Morrison, Tom wrote:
> <snip intro>
> > We do NOT want to use LTIB (supplied by Freescale) to create one
> > (for multiple reasons - including the same as ELDK).
> 
> Can you elaborate on what issues you have with ELDK/LTIB, is it just  
> package support?  If so it might be useful for the developers to know  
> what packages you're interested in.  Or if there are other issues  
> with them.
> 
> LTIB uses busybox and in general seems very limited in its support
> (as well as currently backdated in terms of kernel support). 
> ELDK has an incredible set of packages that it supports, but 
> things like many of the scripting languages support (e.g.: PERL),
> additional security libraries(e.g.: ipsec), general network 
> libraries (e.g.: libpcap), and some network utilities (e.g.: wget).
> 
> Individually, none of these are serious, but altogether it's a lot
> to manage - if I had 1 stop shopping, I might go there instead of 
> with the ever incredible ELDK!
> 

Hi Tom,

I just wanted to clear up some points about LTIB:

* If you want support for LTIB go here: http://www.bitshrine.org/ and
there is a mailing list here:
http://lists.nongnu.org/mailman/listinfo/ltib

* Busybox is the default for most platforms, but you don't have to use
it.  Also note that as you scale up the size of the root filesystem it
will replace the busybox utilities with the full ones (and manage
dependencies).

* The kernels as supplied for BSPs represent things that are tested and
are known to work.  If you're a kernel developer, or just want to use a
later kernel, simply choose the 'Local Linux directory build' option.
This will build any kernel (with KBUILD_OUTPUT support).  So you can use
git/cvs/tarballs whatever.  All you need is the unpacked source
somewhere on your local machine.

* LTIB does have all the packages you mention.  Any that are not there
are easy to add.

* LTIB should not be used if: you want a full desktop root filesystem
(e.g. graphics, multi-media, office apps).  Instead I'd recommend using
Debian or some other destktop distro.  However for something like the
8548, you'd need to re-built it with the appropriate DPFP aware
toolchain.

Regards Stuart
