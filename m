Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B67D687DE
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 09:58:24 +1100 (EST)
Date: Wed, 23 Nov 2005 23:58:18 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051123225818.GA21726@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
	<20051119204742.GA17604@suse.de> <20051123202115.GA17320@suse.de>
	<17284.61088.219693.162392@cargo.ozlabs.ibm.com>
	<20051123223827.GA20793@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051123223827.GA20793@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Nov 23, Olaf Hering wrote:

>  On Thu, Nov 24, Paul Mackeras wrote:
> 
> > Olaf Hering writes:
> > 
> > > It just died while uncompressing vmlinux. Some unaligned load.
> > > So we either need a very simple byte by byte memcpy, or my version below.
> > 
> > This should achieve the same effect and is quite a bit simpler.  Your
> > version looks a bit strange - it copies 1-3 bytes to align the source
> > pointer, then copies 1-3 bytes to align the destination pointer, then
> > if the source pointer isn't aligned it goes back and tries again... :)
> 
> Maybe I miss the point, but if the src is unaligned, and we align it,
> dest will change as well and may be unaligned?

Oh yes, it starts with dest. So everything is alright.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
