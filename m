Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id DBE0B2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 19:32:04 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 14 Dec 2004 09:31:55 +0100
References: <20041213213743.GA2487@schottelius.org>
In-Reply-To: <20041213213743.GA2487@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200412140931.55802.g.jaeger@sysgo.com>
Cc: Nico Schottelius <nico-linux-ppc@schottelius.org>
Subject: Re: [BUG?] [PPC/403/IBM] compile error 2.6.9 and earlier
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Monday 13 December 2004 22:37, Nico Schottelius wrote:
> [repost: posted on linux-kernel before / hit the wrong list]
> 
> Hello!
> 
> I didn't find linux-ppc list on vger, so I hope this list is correct:
> 
> When trying to compile a kernel for my ibm thinclient, which has a
> 403 PPC processor, I get the attached compile error. 
> 
> The error exists since 2.6.X, but the times before I tried to cross-compile,
> this time I tried to built the kernel from my 'new' g3-ibook, which
> failed again (so this is not a cross-compile error).
> 
> Thanks for any hints,
> 
> Nico
> 
> P.S.: See http://marc.theaimsgroup.com/?l=linux-kernel&m=110293175523284&w=2
> for one 'possible answer' to my question. If that's true, is anyone
> out there who wants me to guide to fix it? I'd really love to let the
> IBM thinclients live with Linux.

when having a closer look at the ppc4xx_pic.c you might find out, that there
are two "sections" one for CONFIG_403 and another for the other 4xx parts.
I'm not familiar with the 403 ones, but I think you should concentrate your work
on the config options there. Selecting "OAK" sets CONFIG_403GCX but not CONFIG_403,
correct me if I'm wrong, but regarding the IRQ stuff they should be more or less
the same chips...
After fixing that, you also have to fix oak.c, as this is also somewhat broken, but 
should be no big deal.

Hope this helps a bit.
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
