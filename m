Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 2D31F67D21
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 19:50:21 +1000 (EST)
To: Raphael Bossek <raphael.bossek@gmx.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Jul 2005 11:11:02 +0200."
	<42E0B826.2070800@gmx.de>
Date: Fri, 22 Jul 2005 11:50:09 +0200
Sender: wd@denx.de
Message-Id: <20050722095009.AF0DF352672@atlas.denx.de>
Cc: debian-embedded@lists.debian.org, linuxppc-embedded@ozlabs.org
Subject: Re: Experiences with Debian Sarge on MPC8xx ? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Raphael,

in message <42E0B826.2070800@gmx.de> you wrote:
> 
> Debian GNU/Linux v3.1 (Sarge) is out so give it a try on my MPC850
> running Debian v3.0 for more then 1 year with Denx's 2.4.20 kernel.
> 
> It failed with more or less the same reason as described May 2004
> in this posting 
> http://lists.debian.org/debian-embedded/2004/05/msg00032.html
> 
> Things changed since May 2004 but the problem seams to be. I'm using
> 100% binary compatible Debian GNU/Linux 3.0 (Woody) without any
> problems on my MPC860 board with kernel FPU emulation enabled. This
> math-emu implementation seams to be stable enought to work with libc6
> 2.2.5 and very many server application and large C++ application at high
> load (our stress tests are really horrible for the compleate system!).

I guess you are aware that the FPU emulation is a  nightmare  perfor-
mance-wise  -  you  take  a  kernel  exception  for each and every FP
instruction. FP execution is  several  orders  faster  when  you  use
soft-float  (which,  of  course,  requires  all soft-float libraries,
too).

> I've also heard from people on IRC that 100% Sarge works for them on
> FPU-less MPC boards without trouble. So while I'm investigating the
> problem would like to hear some more respond on this issue from
> people who spend more time on getting Sarge running with 100% Debian
> v3.1 (Sarge) on their MPC8xx environment.

This is probably not a FP issue but may be related to the cache  line
size  and/or  the  infamous  "dcbz"  misbehaviour.  The  standard fix
(removing memset.S when building glibc) has been discussed many times
before; see for example the patches / build scripts for  our  EDK  or
Dan Kegel's crosstool.

> The -msoft-float advice is not what I'm looking for. I'm not sure if
> the FPU is responsible for the problem. Maybe the Debian libc6 2.3.2
> package is missing something important for the MPC8xx PowerPC (the
> cache-line-size is 4 for Debian's libc on PowerPC by default). The

4 what? Bytes? 

> big advantage using a standard distribution is the big number of
> precompiled packages. I do not intent to recompile more then 18000
> due to this first failed tests.

You don't intend to use 18000 packages on your embedded system either
;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Free markets select for winning solutions."        - Eric S. Raymond
