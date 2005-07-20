Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 2F52D67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 18:37:49 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Jul 2005 08:30:26 +0200."
	<200507200830.27141.david.jander@protonic.nl>
Date: Wed, 20 Jul 2005 10:37:32 +0200
Sender: wd@denx.de
Message-Id: <20050720083732.0BF7D352676@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200507200830.27141.david.jander@protonic.nl> you wrote:
> 
> I already thought it might be a good idea to subscribe to that list.
> Any hint about how I can figure out exactly which version of MTD code I have?

I already answered this in my previous message: it's a snapshot  from
MTD CVS of March 13, 2005, backported to the 2.4 kernel.

In general, you can find this type of information when  checking  the
CVS  history.  That's  why  we  run a CVS server and not only provide
tarballs.

> The version of linuxppc_2_4_devel I have is about 2 months old, do I have to 
> expect important changes concerning MTD since then?

More changes have been made since, of course, but I'm  not  aware  of
anything that might be relevant to your problem.

> need to log data into flash. Right now I use an oversized jffs2 partition, 
> log via syslogd and logrotate on size. I am getting the impression that this 

This is about the worst case use for JFFS2 - always  appending  small
chunks (sinlge lines of text) to an ever growing file is exactly what
the filesystem was NOT designed for.

> is not workable for mission critical things. At least not with the kernel and 
> MTD code I have. Others must have the same problem, so here's my question: 
> Which way to do such a thing? Write my own filesystem?

No. Don't reinvent the wheel. Use a buffer are with  unlimited  write
cycles  (like  SRAM  or FRAM), or even a reserved area of your system
RAM, and use pramfs on it. If  you're  using  U-Boot,  you  can  even
arrange that such a file system survives warm boots. Then establish a
policy  for writing the data from this buffer area to flash (probably
still using JFFS2) at a much lower rate. Avoid append  mode.  Try  to
write files in a single operation. etc.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Summit meetings tend to be like panda matings. The expectations  are
always high, and the results usually disappointing."   - Robert Orben
