Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id CAB9E67B3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 01:59:04 +1000 (EST)
To: scarayol@assystembrime.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Jun 2005 16:55:19 +0200."
	<OFF1C6B550.9120AF42-ONC1257015.004EFCD3@brime.fr>
Date: Fri, 03 Jun 2005 17:58:49 +0200
Sender: wd@denx.de
Message-Id: <20050603155854.7403CC1512@atlas.denx.de>
Cc: ctrichet@assystembrime.com, linuxppc-embedded@ozlabs.org
Subject: Re: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_starting_RAM_adress_for_lin?=
	=?iso-8859-1?q?ux_kernel?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Sphie,

in message <OFF1C6B550.9120AF42-ONC1257015.004EFCD3@brime.fr> you wrote:
> 
> we need to have the start of Ram at 0x0300 0000 because we use the command
> mem=40M (for uboot) to force Linux
> in the low part of memory and to reserve the high part of memory (218M
> exactly ) for ioremap (for our application) but we keep

I don't see any reason why this would prevent you  from  mapping  the
RAM at physical address 0.

> the same flash mapping (to avoid more problems).

I don't know which problems you want to avoid by your  chosen  memory
map,  but  I  guess  that the problems you *cause* by this choice are
more, and more severe.

> Is the only solution is to inverse the mapping with Ram from 0 to 258M and
> the flash above ?

Yes.

> Finally, will Busybox work with Ram starting at 0x03000000 ?

No, it will not, as BB is application code which requires  a  running
kernel, and your kernel will not run with such a mapping.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It may be that our role on this planet is not to worship God but  to
create him."                                       - Arthur C. Clarke
