Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 29EC468871
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 03:01:25 +1100 (EST)
To: pantelis.antoniou@gmail.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 05 Dec 2005 21:15:43 +0200."
	<200512052115.45858.pantelis.antoniou@gmail.com>
Date: Tue, 06 Dec 2005 17:01:22 +0100
Sender: wd@denx.de
Message-Id: <20051206160122.DC581353F5E@atlas.denx.de>
Cc: Robert Applebaum <rapplebaum@silicontkx.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Support 8xx based Silicon Turnkey XTc 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Pantelis,

in message <200512052115.45858.pantelis.antoniou@gmail.com> you wrote:
> Support of Silicon Turnkey's XTc.

Ummm .. a few questions...

>  arch/ppc/platforms/stxxtc.h       |  285 +++++++++++++

Here you include a lot of inlined code, but I have  problems  finding
out  what  it  is  good  for.  For  example,  there  is  a full-blown
bit-banging SPI driver included which is nowhere referenced.

Am I missing something, or should this be cleaned up a bit?

>  drivers/mtd/maps/stxxtc_nor.c     |  326 +++++++++++++++

I think it is not a good idea to embed spaces in the flash map names,
as this will make it impossible  to  select  such  devices  from  the
kernel  command  line  which  you  seem  to intend (at least you have
CONFIG_MTD_CMDLINE_PARTS enabled in your default configuration) ?


And a design question: Why are  you  using  the  concatenating  (NOR)
flash  driver?  Why don't you simply map the flashes (in U-Boot) such
that you have one contiguous region? That would  make  flash  use  in
U-Boot much more convenient, too.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Where would we be without rhetorical questions?
