Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 00573B7CB6
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 06:44:04 +1100 (EST)
To: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux patches for XIP on MPC8xx?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4BA865D4.1090403@freemail.hu>
References: <4BA865D4.1090403@freemail.hu>
Date: Tue, 23 Mar 2010 20:44:01 +0100
Message-Id: <20100323194401.0B7724C022@gemini.denx.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Márton Németh,

in message <4BA865D4.1090403@freemail.hu> you wrote:
> 
> I found your homepage at
> http://www.denx.de/wiki/bin/view/DULG/ConfigureLinuxForXIP back
> from 2003. Was there any follow up of your patch for kernel 2.4.4?

There were very few tests done with later kernel versions, and in all
practical system configurations we tested we found that XIP did not
give real benefits. Usually execution from flash was slower than when
running from RAM, and even booting a (inevitably uncompressed) kernel
from flash is typically slower than loading a compressed image to RUM
and booting from there.

So except for some highly specialized applications (you may also call
these "exotic" configurations) XIP for the Linux kernel does not make
much sense to me.

I am aware that there are reports which come to completely different
conclusions - see for example http://www.elinux.org/Kernel_XIP ; but
then look carefully - the examples come from hardware with really
slow processors, which are probably not typical any more.

Actually this is the first thing you should check: the ratio of
processor speed versus flash memory bandwidth versus RAM bandwidth.
Today you can usually expect CPU clocks way over 400 MHz, and many
systems use DDR, while NOR flash speed has noch changed much.

Also check if it is possible to map the flash memory cached for your
system (which you definitly want when using XIP from flash); this may
prevent some flash access methods from working.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Doubt isn't the opposite of faith; it is an element of faith.
- Paul Tillich, German theologian and historian
