Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 417F72BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 04:39:34 +1100 (EST)
To: morten.banzon@axxessit.no
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Nov 2004 11:49:59 +0100."
	<OFD0B78DE0.9222EE0F-ONC1256F50.003811B2-C1256F50.003B80FF@axxessit.no>
Date: Thu, 18 Nov 2004 18:38:57 +0100
Sender: wd@denx.de
Message-Id: <20041118173902.86E09C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OFD0B78DE0.9222EE0F-ONC1256F50.003811B2-C1256F50.003B80FF@axxessit.no> you wrote:
> 
> I do not understand all the intricacies of what happens regarding hardware 
> configuration during the eraly stages of booting linux, but I conclude 
> that when making a uImage one have to modify u-boot and the kernel if one 
> want to relocate the usage of dpram1 by the cpm uart driver. This might 
> have been obvious to most of you, but I was lost on this issue.

There is no need to modify U-Boot nor  the  kernel.  Each  driver  is
supposed to perform all required initialization steps itself. It must
not  make  any assumptions about it's previous state except that it's
"harmless", i. e. interrupts are disabled etc.  when  the  driver  is
starting.

> A mystery is why Dan Malek said it was a "very bad idea" to relocate the 
> smc buffer descriptors to anohter part of dpram1.
> Maybe I will understand that one day too.

Read the code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Vulcans believe peace should not depend on force.
	-- Amanda, "Journey to Babel", stardate 3842.3
