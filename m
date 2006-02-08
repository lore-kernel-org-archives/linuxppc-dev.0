Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A39568A92
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 23:40:50 +1100 (EST)
Date: Wed, 8 Feb 2006 13:40:45 +0100
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: asm-powerpc/highmem.h missing
Message-ID: <20060208124045.GA14370@suse.de>
References: <20060208093439.GA9240@suse.de>
	<20060208211600.28252f22.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060208211600.28252f22.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Feb 08, Stephen Rothwell wrote:

> On Wed, 8 Feb 2006 10:34:39 +0100 Olaf Hering <olh@suse.de> wrote:
> >
> > 
> > Why was asm-ppc/highmem.h not migrated? linux/highmem.h and pagemap.h wants it.
> 
> I guess it was not migrated because it is only required for CONFIG_HIGHMEM
> and, of course, ppc64 does not need HIGHMEM and presumably noone has tried
> to build with CONFIG_HIGHMEM set in ARCH=powerpc until now.

zaptel wants it as well, via netdevice.h/skbuff.h. I wonder why 32bit
compiles anyway, given the many users of linux/highmem.h. Looking...




Argh, still these hacks:

lrwxrwxrwx  1 olaf users 64 2006-02-04 13:16 arch/powerpc/include/asm ->
/home/olaf/kernel/olh/ppc64/linux-2.6.16-rc2-olh/include/asm-ppc/

So better move it over quick.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
