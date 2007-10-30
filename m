Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0AD8BDE20D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:23:16 +1100 (EST)
To: Stefan Roese <stefan.roese@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Bootup support for watchdog with short timeout
	(touch_nmi_watchdog()?)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Oct 2007 12:16:14 +0100."
	<200710301216.15033.stefan.roese@gmail.com>
Date: Tue, 30 Oct 2007 22:23:13 +0100
Sender: wd@denx.de
Message-Id: <20071030212313.D4CB8247F3@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Stefan,

In message <200710301216.15033.stefan.roese@gmail.com> you wrote:
>
> I already have it running on my system using a quick hack (see patch below) in 
> include/asm-ppc/nmi.h (yes, still arch/ppc for now :-( ). But for a clean 
> implementation, that has chances for upstream merge (in arch/powerpc later), 
> I would really like to hear if I should move on further this way. 
> 
> My impression is, that changing the name from touch_nmi_watchdog() to 
> something like touch_watchdog(), and therefore touching lots of files, makes 
> it more unlikely that this resulting patch will get accepted. But 
> implementing this bootup watchdog support in asm-ppc(asm-powerpc)/nmi.h 
> header seems also not totally correct, since it's not really an NMI in this 
> case.

Indeed. Using the header file <asm/nmi.h> is seriously misleading for
the PowerPC version, as is the function name touch_nmi_watchdog() -
thius has nothing to do with NMIs on PowerPC, and most probably not on
any other non-x86 architecture as well. 

To make this mechanism generally usable (which is a good idea IMO) the
names should be changed to get rid of the "nmi" reference.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It may be that your whole purpose in life is simply  to  serve  as  a
warning to others.
