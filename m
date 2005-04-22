Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A018C67A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 11:31:36 +1000 (EST)
Date: Fri, 22 Apr 2005 03:31:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Message-ID: <20050422013134.GB27755@wohnheim.fh-wedel.de>
References: <20050421103234.ED367C1510@atlas.denx.de>
	<200504211502.48761.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200504211502.48761.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 21 April 2005 15:02:48 +0200, Marco Schramel wrote:
> 
> > > /dev # date > /dev/mtd1
> > > MTD_open
> > > MTD_ioctl
> > > MTD_write
> > > MTD do_write_buffer(): software timeout
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ERROR ERROR ERROR ERROR ERROR ERROR ERROR
> 
> This only occurs if i write the second time to the flash memory without erasing it before.

That's harmless.  Flash is a write-once medium between erases.

Your setup appears sane in principle, so there must me a subtle
mistake you made (bugs are out of the question of course ;).  Missing
a real howto, let me run through the sequence:

1. Erase the flash partition.  Either
   o eraseall /dev/mtdX or
   o cat file_filled_with_0xff > /dev/mtdblockX

2. Do *not* write anything to it afterwards.  Jffs2 would just error
   out.

3. Mount jffs2.  Either
   o mount mtdX -t jffs2 <mount_point> or
   o mount /dev/mtdblockX -t jffs2 <mount_point>
  

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
