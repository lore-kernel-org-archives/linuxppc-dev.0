Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C65FDDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 20:49:20 +1000 (EST)
Date: Fri, 14 Sep 2007 03:48:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pcmcia: Convert io_req_t to use kio_addr_t
Message-Id: <20070914034854.1658a9cf.akpm@linux-foundation.org>
In-Reply-To: <20070905142742.GA1760@lixom.net>
References: <20070905142742.GA1760@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, hch@lst.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2007 09:27:43 -0500 Olof Johansson <olof@lixom.net> wrote:

> Convert the io_req_t members to kio_addr_t, to allow use on machines with
> more than 16 bits worth of IO port address space (ppc64 in this case,
> but it applies to others as well).

drivers/usb/host/sl811_cs.c: In function 'sl811_cs_config':
drivers/usb/host/sl811_cs.c:263: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'kio_addr_t'
drivers/usb/host/sl811_cs.c:263: warning: format '%04x' expects type 'unsigned int', but argument 3 has type 'long unsigned int'

That's not just a cosmetic thing - the printk can print junk and if there's
a %s in the control string after the %x's, printk() will crash.

I don't know how many instances of this are in the tree, but they'll all
need to be found and fixed.
