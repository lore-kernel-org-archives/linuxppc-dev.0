Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33CE6DDEC4
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 07:31:25 +1100 (EST)
Date: Thu, 8 Feb 2007 21:30:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver
Message-ID: <20070208203014.GB2579@lst.de>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0702081458190.19437@pademelon.sonytel.be>
Cc: James Simmons <jsimmons@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2007 at 02:58:31PM +0100, Geert Uytterhoeven wrote:
> Add the PS3 AV Settings Driver.
> 
> The AV Settings driver is used to control Audio and Video settings.
> It communicates with the policy manager through the virtual uart.

please don't use kernel_thread for new code, but rather kthread_create/
ktread_run.  And check the possible errors it can return :)

Using the kthread infrastructure also means you'll have to redo your
synchronisation scheme as it doesn't work very well with this use
of semaphores.  But that's a good thing as these useages are not
easily parseable for most kernel hackers despite beeing tought in
OS101 :)
