To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fast ethernet LXT972A support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Aug 2002 16:51:25 PDT."
             <3D6578FD.6020105@redswitch.com>
Date: Fri, 23 Aug 2002 01:56:58 +0200
Message-Id: <20020822235703.7FB1C11822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D6578FD.6020105@redswitch.com> you wrote:
>
> > Ummm.... you must be looking in the wrong place; our  kernel  version
> > supports  AMD79C874, LXT970, LXT971, QS6612, DP83843, and DP83846A on
> > MPC8xx processors, and AMD79C873, LXT970, LXT971, QS6612  on  MPC8260
>
> Well, the version I got is linux-2.4.4-08-09. And I'm sure there are no
> DP83843 and DP83846A support. So you must have made progress in
> supporting new PHYs. :) The file I'm looking at is arch/ppc/8xx_io/fec.c.

That's what I was looking at, too. But you mentioned "latest kernel",
and I have here:

----------------------------
revision 1.20
date: 2002/08/11 11:09:33;  author: wd;  state: Exp;  lines: +369 -42
1. Added support for PHY DP83843BVJE.
2. Added support for PHY DP83846A.
3. Added a timer callback to periodically probe the DP83846A (or any
   other chip, it is easy to adapt) for link changes. The delays are
   hard-coded, though. Someone could add some configuration
   parameters for it, of course! The periods depend on the link
   state:
   - 1 second when the link is up.
   - 100ms when the link is down.
4. Added the standard IOCTL support to manipulate the PHY registers.
5. A bugfix (in fec_restart(), if the flag 'tx_full' is set, it must
   be cleared, and the network interface queue needs to be awakened.)

Based on patch by Jean-Denis Boyer <jdboyer@mediatrix.com>, 22 Mar 2002
See http://lists.linuxppc.org/linuxppc-embedded/200203/msg00200.html
----------------------------

For me, latest == top of CVS :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The greatest threat towards future is indifference.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
