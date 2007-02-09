Return-Path: <akpm@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AE017DDE39
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 20:18:18 +1100 (EST)
Date: Fri, 9 Feb 2007 01:17:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver
Message-Id: <20070209011723.34d1013f.akpm@linux-foundation.org>
In-Reply-To: <20070208203014.GB2579@lst.de>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
	<20070208203014.GB2579@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: James Simmons <jsimmons@infradead.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Linux,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Feb 2007 21:30:14 +0100 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Feb 08, 2007 at 02:58:31PM +0100, Geert Uytterhoeven wrote:
> > Add the PS3 AV Settings Driver.
> > 
> > The AV Settings driver is used to control Audio and Video settings.
> > It communicates with the policy manager through the virtual uart.
> 
> please don't use kernel_thread for new code, but rather kthread_create/
> ktread_run.  And check the possible errors it can return :)

yup.

Plus basically every kernel thread needs a try_to_freeze().

> Using the kthread infrastructure also means you'll have to redo your
> synchronisation scheme as it doesn't work very well with this use
> of semaphores.  But that's a good thing as these useages are not
> easily parseable for most kernel hackers despite beeing tought in
> OS101 :)

Does it actually use sempahores in their counting mode?  If not, mutexes
are preferred.

ps3av_do_pkt() allocates 512 bytes on stack which might be a bit excessive
if you're using a 4k stack.  Especially if that function or a callee does a
__GFP_FS memory allocation.
