Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id DF35E679F4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 16:03:08 +1000 (EST)
To: kylo@kylo.net
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 28 Apr 2005 15:21:30 PDT."
	<61cc712d05042815211d84e870@mail.gmail.com>
Date: Fri, 29 Apr 2005 08:02:53 +0200
Sender: wd@denx.de
Message-Id: <20050429060258.DCCE1C1510@atlas.denx.de>
Cc: Chiradeep Vittal <chiradeep@matissenetworks.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <61cc712d05042815211d84e870@mail.gmail.com> you wrote:
> 
> I have the same issue with gcc3.4.3 and an e500 target.  You can give
> gcc the -mno-string to inhibit generation of those load/store string
> instructions.  I don't know if gcc can be configured such that its
> default is not to generate those instructions.

Yes, it can. In config/rs6000/rs6000.c replace

	if (BYTES_BIG_ENDIAN && optimize_size)
	  target_flags |= MASK_MULTIPLE | MASK_STRING;
by
	if (BYTES_BIG_ENDIAN && optimize_size)
	  target_flags |= 
	    (MASK_MULTIPLE | MASK_STRING) & ~processor_target_table[j].target_disable;

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Do you suppose the reason the ends of the `Intel Inside'  logo  don't
match up is that it was drawn on a Pentium?
