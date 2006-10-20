Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id EDAB567B56
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:28:21 +1000 (EST)
Date: Fri, 20 Oct 2006 08:24:31 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020062431.GB14390@powerlinux.fr>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161323797.10524.150.camel@localhost.localdomain>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, Olaf Hering <olaf@aepfle.de>, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 03:56:37PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-10-20 at 07:44 +0200, Olaf Hering wrote:
> > On Fri, Oct 20, Benjamin Herrenschmidt wrote:
> > 
> > > On Thu, 2006-10-19 at 09:03 +0200, Olaf Hering wrote:
> > > > On Thu, Oct 19, Benjamin Herrenschmidt wrote:
> > > > 
> > > > > On Wed, 2006-10-18 at 09:38 +0200, Olaf Hering wrote:
> > > > > > On Wed, Oct 18, Michael Ellerman wrote:
> > > > > > 
> > > > > > > But it's called '/proc/ppc64' right now on lots of machines, so you
> > > > > > > can't go changing it.
> > > > > > 
> > > > > > if test -d /proc/ppc64 .. is a quick way to check wether the system is
> > > > > > 64bit or not. Similar to if test -d /proc/iSeries ..
> > > > > 
> > > > > That's really ugly ! You really do that ? Gack...
> > > > 
> > > > What way should I use?
> > > 
> > > uname ? /proc/cpuinfo ? Whatever but not that.
> > 
> > uname can be faked with powerpc32 or setarch. grep POWER /proc/cpuinfo
> > might be an option. I think its only used in rpm preinstall scripts to
> > reject 64bit kernel on 32bit systems or the other way around.
> 
> grep POWER won't do good on 970 among others.
> 
> uname can be faked but why do you care ?
> 
> In fact, is somebody is faking it, maybe it's because they -want- your
> scripts to think they are running on a 32 bits box....
> 
> I still think uname is the way to go.
>  

Ben, would it make sense to add two informations to /proc/cpuinfo ?
It would be great to have a field there which will allow to check for the
kernel flavour to run, namely if the kernel/processor/whatever is running in
32bit or 64bit mode. The second field would be a generalized machine field,
or plateform or whatever, which would easily allow to differentiate between an
apple machine, a ibm chrp, a pegasos or other genesi product, etc. Without
necessarily having to maintain a huge amount of userlanf mappings from all
those different machine: fields, which all have CHRP, true, but no finer
grained informations, while we do have it in the kernel.

Friendly,

Sven Luther
