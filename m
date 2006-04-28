Return-Path: <SRS0+0c9028459b4cef1b5b40+978+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 553DC679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 20:23:57 +1000 (EST)
Subject: Re: [PATCH] Wire up *at syscalls
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17489.50396.320494.589703@cargo.ozlabs.ibm.com>
References: <jeu08ippb9.fsf@sykes.suse.de>
	<1145924011.16166.465.camel@shinybook.infradead.org>
	<17489.50396.320494.589703@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 11:24:26 +0100
Message-Id: <1146219867.10561.39.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-28 at 17:31 +1000, Paul Mackerras wrote:
> Nice idea, but you didn't change the syscall entry path to multiply
> the syscall number by 24 instead of 16. 

Indeed. Neither did I wire up the spu callbacks. It wasn't meant to be
applied as-is.

>  It would be nice to have a way to do something like that but generate
> two separate tables instead of a single table with 3 entries per
> syscall. 

Arnd apparently tried that once and it was icky. Perhaps we could do
something like this though...

.macro SPU adr
	.section .spu_callbacks,"a"
	.llong \adr		
	.previous
.endm

-- 
dwmw2
