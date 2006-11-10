Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17749.1504.630761.341652@cargo.ozlabs.ibm.com>
Date: Sat, 11 Nov 2006 10:06:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Brian King <brking@us.ibm.com>
Subject: Re: ipr SATA support is causing problems
In-Reply-To: <45549962.108@us.ibm.com>
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
	<45549962.108@us.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	James Bottomley <jejb@mulgrave.il.steeleye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King writes:

> I'm not sure what the best way to fix this one is... The ideal way is to
> change ipr to select CONFIG_ATA, but kconfig currently doesn't handle
> that and complains about recursive dependencies since IPR depends on
> CONFIG_SCSI and CONFIG_ATA selects CONFIG_SCSI. I'm guessing the
> libsas SATA usage has similar problems. Right now we both use a depends
> CONFIG_ATA statement. Ideally, kconfig should be fixed to handle this.

Well, the systems that use ipr for SATA would be in a very small
minority compared to those that use it for SCSI, wouldn't they?  It
seems annoying to have to include all the libata stuff when I'm
configuring a kernel for a system that only uses ipr for SCSI.  Thus I
would think that the solution is to allow ipr.c to be built without
the SATA bits, if that's what the user wants.

How hard would it be to make the SATA bits conditionally compiled in,
depending on CONFIG_ATA?

Paul.
