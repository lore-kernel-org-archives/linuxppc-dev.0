Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id A2B76688C7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2005 11:10:29 +1100 (EST)
Date: Tue, 13 Dec 2005 01:10:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Message-ID: <20051213001028.GS23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
	<20051211193118.GR23349@stusta.de>
	<20051211194437.GB22537@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051211194437.GB22537@flint.arm.linux.org.uk>
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 11, 2005 at 07:44:37PM +0000, Russell King wrote:
> On Sun, Dec 11, 2005 at 08:31:18PM +0100, Adrian Bunk wrote:
> > On Sun, Dec 11, 2005 at 07:21:10PM +0000, Russell King wrote:
> > > On Sun, Dec 11, 2005 at 07:52:12PM +0100, Adrian Bunk wrote:
> > > > defconfig's shouldn't set CONFIG_BROKEN=y.
> > > 
> > > NACK.  This changes other configuration options in addition, for example
> > > in collie_defconfig:
> > > 
> > > -CONFIG_MTD_OBSOLETE_CHIPS=y
> > > -# CONFIG_MTD_AMDSTD is not set
> > > -CONFIG_MTD_SHARP=y
> > > -# CONFIG_MTD_JEDEC is not set
> > 
> > That's not a problem introduced by my patch.
> 
> It's a problem introduced by your patch because the resulting defconfig
> file becomes _wrong_ by your change, and other changes in the defconfig
> are thereby hidden.
>...


No, CONFIG_BROKEN=y in a defconfig file is a bug.

Either the defconfig doesn't use BROKEN code in which case it's simply 
wrong, or it's a wrong workaround (as in the CONFIG_MTD_SHARP case) for 
a wrong BROKEN dependency.


And it's a dangerous workaround:

Consider e.g. that "both marked as obsolete and BROKEN" are the best 
candidates for "remove obsolete code" cleanups - and there goes your 
driver to /dev/null ...


> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
