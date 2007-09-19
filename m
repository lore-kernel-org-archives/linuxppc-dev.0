Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 81788DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 23:24:05 +1000 (EST)
Date: Wed, 19 Sep 2007 14:53:18 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: CONFIG_BLK_DEV_BSG=n
Message-ID: <20070919125318.GE25592@kernel.dk>
References: <1189800008.3343.21.camel@localhost.localdomain>
	<598D5675D34BE349929AF5EDE9B03E27015558EA@az33exm24.fsl.freescale.net>
	<19650.1190040390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19650.1190040390@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, akpm@osdl.org,
	linux-scsi@vger.kernel.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17 2007, David Howells wrote:
> 
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
> > > Which solution would you be more comfortable with?
> > 
> > The one which is currently in -mm is this one:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=49892223f7d3a2333ef9e6cbdd526676e1fc517a
> 
> In my opinion, this is the wrong fix.  There shouldn't be anything in
> the kernel using stuff from bsg.h if CONFIG_BLOCK=n, so there should
> be an error if anything tries to.  The correct fix is to exclude the
> non-userspace-visible contents of bsg.h with #ifdef CONFIG_BLOCK, not
> to declare things that we've tried to make sure specifically aren't
> declared.

I agree, I'll pass your fix on.

-- 
Jens Axboe
