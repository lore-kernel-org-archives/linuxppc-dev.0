Return-Path: <bgat@billgatliff.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 75322B7D2F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 12:50:09 +1000 (EST)
Received: by gwj17 with SMTP id 17so1017893gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 19:50:07 -0700 (PDT)
Message-ID: <4BC7D0BA.5000502@billgatliff.com>
Date: Thu, 15 Apr 2010 21:51:38 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
	<4BC70E47.9010408@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
In-Reply-To: <201004151553.53426.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roman Fietze wrote:
> Yes. I added a routine like
>
> /* Swap frame buffer bytes in 32 bit value.  */
> static __inline unsigned int
> fbbits_swap32(unsigned int __bsx)
> {
>     return ((((__bsx) & 0xff000000) >> 8) | (((__bsx) & 0x00ff0000) << 8) |
> 	    (((__bsx) & 0x0000ff00) >> 8) | (((__bsx) & 0x000000ff) << 8));
> }
>   

I baked the above code into shadowUpdatePacked(), and it didn't seem to
help anything--- my icewm mouse cursor was still quite jagged, as was
all the text on the screen (clock widget, etc).  So I replaced the above
code with a return 0, and the icewm desktop went completely black--- and
everything else remained unchanged.

Apparently, there are several similar modifications that need to be
made, i.e. the shadowUpdatePacked() function isn't the only way to the
framebuffer memory?  I'm really looking forward to seeing your code, as
I have no idea how to even identify the places that need hacking.  I
understand the utility of the hack, however.

Makes me think that we're all just soldering this chip down to the wrong
data lines, and makes me wonder if there isn't an "endianness bit" in
the memory bus controller that can undo this damage for us.  I know I've
seen such a bit in other SoCs...


Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
