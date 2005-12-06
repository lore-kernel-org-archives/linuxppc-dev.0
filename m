Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.204])
	by ozlabs.org (Postfix) with ESMTP id 72DAB68880
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 04:33:25 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so34375nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 09:33:23 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Date: Tue, 6 Dec 2005 19:41:36 +0200
References: <20051206160122.DC581353F5E@atlas.denx.de>
In-Reply-To: <20051206160122.DC581353F5E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512061941.37502.pantelis.antoniou@gmail.com>
Cc: Robert Applebaum <rapplebaum@silicontkx.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Support 8xx based Silicon Turnkey XTc
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 06 December 2005 18:01, Wolfgang Denk wrote:
> Dear Pantelis,
> 
> in message <200512052115.45858.pantelis.antoniou@gmail.com> you wrote:
> > Support of Silicon Turnkey's XTc.
> 
> Ummm .. a few questions...
> 
> >  arch/ppc/platforms/stxxtc.h       |  285 +++++++++++++
> 
> Here you include a lot of inlined code, but I have  problems  finding
> out  what  it  is  good  for.  For  example,  there  is  a full-blown
> bit-banging SPI driver included which is nowhere referenced.
>
> Am I missing something, or should this be cleaned up a bit?
>

It is used in drivers not submitted at this point...
They'll be forthcoming when the time comes. 
 
> >  drivers/mtd/maps/stxxtc_nor.c     |  326 +++++++++++++++
> 
> I think it is not a good idea to embed spaces in the flash map names,
> as this will make it impossible  to  select  such  devices  from  the
> kernel  command  line  which  you  seem  to intend (at least you have
> CONFIG_MTD_CMDLINE_PARTS enabled in your default configuration) ?
> 
> 

Well, I guess you're right. Though I never used the kernel command
line for selecting the devices. 

> And a design question: Why are  you  using  the  concatenating  (NOR)
> flash  driver?  Why don't you simply map the flashes (in U-Boot) such
> that you have one contiguous region? That would  make  flash  use  in
> U-Boot much more convenient, too.
> 

Unfortunately is not possible. Due to the way the flash is mapped on boot it
is not possible to have it continuous. Believe me I've tried :) 

> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Where would we be without rhetorical questions?
> 

Regards

Pantelis
