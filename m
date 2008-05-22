Return-Path: <david-b@pacbell.net>
Received: from smtp105.sbc.mail.mud.yahoo.com (smtp105.sbc.mail.mud.yahoo.com
	[68.142.198.204]) by ozlabs.org (Postfix) with SMTP id 44C51DDFA5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 13:45:08 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device() to allow two stage
	registration.
Date: Wed, 21 May 2008 17:17:13 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193608.28030.34968.stgit@trillian.secretlab.ca>
In-Reply-To: <20080516193608.28030.34968.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805211717.13206.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 May 2008, Grant Likely wrote:
> 
> This patch splits the allocation and registration portions of code out
> of spi_new_device() and creates three new functions; spi_alloc_device(),
> spi_register_device(), and spi_device_release(). 

I have no problem with the first two, but why the last?

If the devices are always allocated by spi_alloc_device() as
they should be -- probably through an intermediary -- the
only public function necessary for that cleanup should be
the existing spi_dev_put().

- Dave
