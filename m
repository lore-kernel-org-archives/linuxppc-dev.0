Subject: Re: MBX boot problems
To: bimhoff@ns1.planetspork.com (Brent)
Date: Mon, 22 May 2000 12:23:54 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.05.10005211739380.9894-100000@ns1.planetspork.com> from "Brent" at May 21, 2000 06:28:35 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000522022354.A29AE3C972@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Brent,

Brent writes:
> At this point, things go bad.  I've tried two things. 1) hitting enter and
> letting things fall as they may.  This didn't work since there seemed to
> be a problem with it dropping the middle digit of the first octet of the
> src/dst IP addresses in the boot args.  2)  explicitly defining the boot
> arguments with appropriate settings.

Do you by any chance have the CPU6 workarounds enabled?

If so, try commenting out the following lines in
arch/ppc/kernel/head.S:set_dec:

        lis     r7, cmd_line@h                  ###
        ori     r7, r7, cmd_line@l              ###
        li      r4, 0x2c00                      ###
        stw     r4, 12(r7)                      ###
        lwz     r4, 12(r7)                      ###

This workaround will cause your kernel command line to get trashed.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
