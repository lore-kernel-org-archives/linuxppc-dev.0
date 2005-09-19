Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 79D99682C0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 01:38:06 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Sep 2005 11:55:36 +0200."
	<200509191155.36540.david.jander@protonic.nl>
Date: Mon, 19 Sep 2005 17:37:47 +0200
Sender: wd@denx.de
Message-Id: <20050919153747.78ACC352682@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200509191155.36540.david.jander@protonic.nl> you wrote:
> 
> Kernel of choice seems to be denx linuxppc_2_4_devel, but I cannot trust the 
> version of jffs2 used in that kernel anymore. Somtimes gc.c crashes with a 
> BUG() in line 139, and sometimes processes are frozen for a looong time 

Can you provide a little more details? The MTD / JFFS2 code  in  this
kernel  is  not too old, andwe use it in a couple of projects without
such problems.

> waiting for GC. I have debugged that problem a little bit, and definitely, 
> the FLASH access works ok, and the chip is new. No CRC- or read-errors, but 
> still gc.c crashes.

Can you provide soem more information for debugging?

> The version of mtd/jffs2 drivers in that kernel seem to be from march/2005 cvs 
> code, but when I read the following, I get even more scared:
> http://www.linux-mtd.infradead.org/source.html#kernelversions

Don't worry. We backported the MTD / JFFS2 code. See the  history  of
changes on our CVS or git server.

> This must be a very common task (to store logfiles in flash), but I just can't 
> seem to find the right way to do it.

Note that log files may cause a lot of trouble  when  using  a  JFFS2
file  system. Youmay want to addd a buffering layer, like pramfs in a
dedicated RAM area (SRAM ideally).


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never underestimate the bandwidth of a station wagon full of tapes.
                                -- Dr. Warren Jackson, Director, UTCS
