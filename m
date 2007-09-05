Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C0C1DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 23:27:33 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISuuf-00055l-5m
	for linuxppc-embedded@ozlabs.org; Wed, 05 Sep 2007 15:27:21 +0200
Received: from p5497d37b.dip.t-dialin.net ([84.151.211.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 05 Sep 2007 15:27:21 +0200
Received: from dzu by p5497d37b.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 05 Sep 2007 15:27:21 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Breakpoint is not hitting for Kernel Debugging
Date: Wed, 05 Sep 2007 15:27:22 +0200
Message-ID: <m2wsv58cp1.fsf@ohwell.denx.de>
References: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
	<7c1681440709032107u3feb0684x34dcf44b5e43616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> Try adding this line to your BDI config to clear/invalidate the page
> table base address so that the MMU translation works before the MMU
> has been initialised.
>
>   ;; Following is to clear the page table base address
>   WM32    0x000000f0      0x00000000

Did you really need this under any circumstance?  To only hit a
breakpoint?

I am asking because recent experiences with BDI debugging showed that
there are some pitfalls that one can fall into (and these are only the
ones that I got aware of):

a) - PTBASE is 0x00 (!) for head_fsl_booke, head_44x,
   - PTBASE is 0xf0 for head_4xx

   Don't ask me if this makes any sense, but that's how it is right
   now.

   So for the original poster I would say a PTBASE 0x0 would be in
   order.

b) Moreover even with a _wrong_ PTBASE on a 440EPx the BDI translated
   start_kernel just fine by only subtracting 0xc0000000 (using a
   "default" translation) - it was only later (debugging dynamic
   modules) that the wrong PTBASE hit me hard.

What proved very useful for me is the bdi command "phys <addr>" to
check the translation the BDI uses [you can use the command (as all
BDI commands) through gdb with "mon phys <addr>" btw.] - a wrong
PTBASE led to subsequent "JTAG instruction overruns" so I was pretty
sure that this was my real problem.

Best wishes
  Detlev

-- 
The limits of my language stand for the limits of my world.
                                        -- Ludwig Wittgenstein
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
