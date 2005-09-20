Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id BAA4B68310
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 04:08:21 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Sep 2005 11:17:39 +0200."
	<200509201117.40454.david.jander@protonic.nl>
Date: Tue, 20 Sep 2005 20:07:58 +0200
Sender: wd@denx.de
Message-Id: <20050920180758.9020C353AB3@atlas.denx.de>
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

In message <200509201117.40454.david.jander@protonic.nl> you wrote:
> 
> Is there something like memtest86 for linux-ppc (i.e. written in portable C)?

Yes, there is. Run the system with root file system mounted over NFS,
and then put some load on the system, like  by  compiling  the  linux
kernel  on  the  target.  Anything  else which adds DMA load does not
hurt, either. In such a situation, with a lots of  context  switches,
stress  on  the  memory  management  system  and having a lots of DMA
traffic going on you may see some memory problems. Unfortunately none
of the standard memory tests will catch thse, as  the  tests  usually
provide  only plain read / write accesses, while the problems show up
only in burst mode, i. e. when filling the caches and/or doing DMA.

There is an attempt of a burst mode memory test in the  U-Boot  code,
but  I  have to admit that I didn't work to show the exact problem on
the system it was written for.

> Hmm, but.... there is no data corruption. I have not seen one file on flash 
> that had other data than intended, and that inspite of the GC freaking out.

Maybe there is no corruption of the data in flash. But are  you  sure
that  correct  data are loaded to and read from RAM? We had a similar
problem on a board where data got corrupted only when doing a lot  of
transfers flash->RAM.

> That commit only changed 3 files, non of them directly related to jffs2 code, 

This is correct.

> and only seemed to add support for FUJITSU flash chips. What am I missing?
> MTD developers say that cvs from march-2005 _is_ broken, so there must be some 

Yes, of course it's broken. Like  all  computer  code.  There  are  a
couple  of  known  issues  (especially  with NAND flash), but I don't
think they could explain the type of problems you are seeing.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No  such  faith  comforts
the software engineer.                             - Fred Brooks, Jr.
