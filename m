Return-Path: <benh@kernel.crashing.org>
Subject: Re: Time for cell code reshuffle?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200712212015.45088.arnd@arndb.de>
References: <200712211522.03841.arnd@arndb.de>
	<476BF67C.2030405@am.sony.com>  <200712212015.45088.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 23 Dec 2007 08:00:14 +1100
Message-Id: <1198357215.6686.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-21 at 20:15 +0100, Arnd Bergmann wrote:
> > It seems platforms/cell should have the shared and/or generic code,
> and the other
> > stuff moved into a new platform directory, but is it worth the
> effort? 
> 
> There is very little code in platforms/cell that can not be generic,
> so I think
> it's not worth splitting it. The only IBM blade specific files are
> cbe_cpufreq_pmi.c and parts of setup.c and pervasive.c. Everything
> else could
> be shared by about any generic implementation without a hypervisor.

Another option is to have:

platforms/celleb -> platforms/beat

and withing platforms/cell, rename blade specific files to
something (can't find what, works on CAB too) and add celleb
"bare metal" files.

A platform directly doesn't have to deal with one platform. For example,
platforms/44x contains a lot of board support.

Now, one question is how far can we merge celleb support with the common
blade/CAB code...

Cheers,
Ben.
