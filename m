Return-Path: <SRS0+4befd073f6bde5688508+1025+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6107E67B30
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 10:04:00 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17551.20066.365036.256580@cargo.ozlabs.ibm.com>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
	<17551.16830.186314.247458@cargo.ozlabs.ibm.com>
	<1150241510.11159.159.camel@shinybook.infradead.org>
	<17551.20066.365036.256580@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 01:04:14 +0100
Message-Id: <1150243455.11159.176.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-14 at 09:46 +1000, Paul Mackerras wrote:
> > We already did it in Fedora. We don't default to READ_IMPLIES_EXEC 
> > for 32-bit processes on the 64-bit kernel.
> 
> By patching include/asm-powerpc/elf.h? 

By patching fs/binfmt_elf.c -- it's part of the exec-shield patch.
http://cvs.fedora.redhat.com/viewcvs/devel/kernel/linux-2.6-execshield.patch?rev=1.20&view=auto

shinybook /home/dwmw2 $ cat foo.c
int foo[2] = { 0x3860005a, 0x4e800020 };
int main(void)
{
        int (*foofn)(void) = (void *)foo;
        int f = foofn();
        printf("%x\n", f);
}
shinybook /home/dwmw2 $ ./foo
5a
shinybook /home/dwmw2 $ scp foo pmac: ; ssh pmac
foo                                             100% 9996     9.8KB/s
00:00
Last login: Wed Jun 14 00:58:26 2006 from shinybook-bcm.infradead.org
pmac /home/dwmw2 $ ./foo
Segmentation fault
pmac /home/dwmw2 $ setarch ppc -X ./foo
5a

-- 
dwmw2
