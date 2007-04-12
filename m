Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070412083135.GA3104@iram.es>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
	<20070412042337.GA21832@aepfle.de>
	<1176355566.8061.121.camel@localhost.localdomain>
	<20070412063321.GA23118@aepfle.de>
	<1176359890.8061.131.camel@localhost.localdomain>
	<20070412083135.GA3104@iram.es>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 18:48:11 +1000
Message-Id: <1176367692.5764.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, Arnd Bergmann <arnd@arndb.de>,
	Akinobu Mita <mita@fixstars.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 10:31 +0200, Gabriel Paubert wrote:
> On Thu, Apr 12, 2007 at 04:38:10PM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2007-04-12 at 08:33 +0200, Olaf Hering wrote:
> > > On Thu, Apr 12, Benjamin Herrenschmidt wrote:
> > > 
> > > > Gets altivec and stops working on POWER5 ? no deal :-)
> > > 
> > > If there is a significant performance gain (not only 9%) and if
> > > -mcpu=$cell does not generate instructions that wont work on other
> > > altivec capable cpus and if rpm gets a target ppcaltivec.rpm (or
> > > similar), as separate binary tree can be done.
> > 
> > -mcpu=cell can possibly generate things that won't run on 970 and 74xx.
> > There are some new altivec instructions among others...
> 
> Any pointer to a document describing the differences?

I'm not sure where this is documented. There are a few new ops for
doing load/save of partial vectors (to help handle edge cases),
there are some more precise implementation of some fp osp (though
that should be backward compatible), and maybe a few other things.

I think most public cell docs can be found at

http://www-306.ibm.com/chips/techlib/techlib.nsf/products/Cell_Broadband_Engine

Though I have no idea where those specifics are described.

Cheers,
Ben.
