Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 12/16] cell: add temperature to SPU and
	CPU sysfs entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200610260935.01801.arnd@arndb.de>
References: <20061024163113.694643000@arndb.de>
	<20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
	<1161818364.22582.145.camel@localhost.localdomain>
	<200610260935.01801.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 19:19:02 +1000
Message-Id: <1161854342.5299.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-26 at 09:35 +0200, Arnd Bergmann wrote:
> On Thursday 26 October 2006 01:19, Benjamin Herrenschmidt wrote:
> > > 
> > > Will crash if cpu_add_sysdev_attr_group failed...
> > 
> > 
> > Which is a total PITA. If this is the case, then we should modify the
> > add calls to at least initialize enough fields before they can fail for
> > the remove calls not to crash. You don't want to keep track precisely of
> > what file was added and what not and test all of that in your exit code
> > path, it's just insane.
> 
> Heiko suggested that earlied in http://lkml.org/lkml/2006/10/9/22,
> but Andrew didn't like it.
> 
> Currently, the worst is that sysfs_remove_file can be used
> on a nonexisting file,  but sysfs_remove_group cannot, which is
> inconsistent. Either sysfs_remove_file should WARN_ON or
> sysfs_remove_group should silently return, and I'd prefer the
> latter, as it makes users simpler.

We need to argue with Andrew then. I'll have a go tomorrow

Ben.
