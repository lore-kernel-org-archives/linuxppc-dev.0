Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18057.34926.788402.262293@cargo.ozlabs.ibm.com>
Date: Tue, 3 Jul 2007 09:21:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: 2.6.22-rc6-mm1
In-Reply-To: <46890F8D.3080807@windriver.com>
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
	<200706291432.10128.m.kozlowski@tuxland.pl>
	<4685010C.4000108@ru.mvista.com> <4689025C.8000001@windriver.com>
	<46890A52.6020201@ru.mvista.com> <46890F8D.3080807@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jason Wessel writes:

> I suppose the argument could be made to remove the check in the compiled 
> file, but it does serve as a way to protect kgdb for now if someone 
> tries to hard compile in xmon and kgdb.  Completely unpredictable 
> results will occur with the debugger unless some pieces are fixed.  I 
> would rather make sure until that happens there is no way head down the 
> rat hole.

It should all work provided kgdb plays nicely.  We used to be able to
compile in both xmon and kdb and select at runtime which one gets
used.

> That issue aside would it be useful to have xmon+kgdb?  After having 
> looked at the hook points for xmon, if a command was added to xmon to 
> provide an "detach" it would be easy enough to have kgdb and xmon in the 
> same kernel.  Obviously only one or the other can be used at any given time.

Well, xmon_init(0) will do a detach.  However, I don't see that it is
needed; there is plenty of flexibility to choose to have xmon or not
using the CONFIG_XMON_DEFAULT config option and the xmon= boot command
line option.

Paul.
