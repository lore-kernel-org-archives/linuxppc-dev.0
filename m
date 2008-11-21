Return-Path: <timur@freescale.com>
Message-ID: <4926DE26.7030607@freescale.com>
Date: Fri, 21 Nov 2008 10:13:26 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: powerpc: udbg based backend for hvc_console
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
	<4569571e317d43f1b26b087fcdebcba3@bga.com>
	<4925B78B.2040709@freescale.com>
	<22538ec7f241b37d1dfcb94188d414e8@bga.com>
In-Reply-To: <22538ec7f241b37d1dfcb94188d414e8@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:

> We want the last console= parameter on the command line to win.  So if 
> that implys the last call to add_preferred_console wins, then you have 
> code overriding the command line.

Hmm, good point.  However, how likely is it that we'll have more than one
console driver?  Also, without calling add_preferred_console(), the kernel needs
to have a console= on the command line.

In my case, my driver only calls add_preferred_console() if the device tree
contains a specific property that it looks for.  In effect, this property
override the console= line.  However, the console= line goes to the HVC
subsystem, and not my driver, and I can't use it to send the configuration data
the driver needs.

Unfortunately, my driver hasn't been published yet, so it's hard to explain the
details.  I guess I need to think about this more.

-- 
Timur Tabi
Linux kernel developer at Freescale
