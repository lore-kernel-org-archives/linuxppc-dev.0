Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4612C48F.9080805@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
	<1175568133.16182.15.camel@concordia  <4612C48F.9080805@am.sony.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:28:42 +1000
Message-Id: <1175650122.30879.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 14:18 -0700, Geoff Levand wrote:

> I'm in the middle of implementing the zImage and kexec support for the
> 2.6.21 kernel, but haven't pushed all of it out to ps3-linux.git yet.
> Once that is done, there is little need for a 2.6.16 based bootloader,
> since it would be just as well to use a recent kernel.
> 
> In the interim, for compatibility with the legacy 2.6.16 based bootloader,
> I have the hack ps3-no-bootwrapper-hack.diff.  Ben Collins did his
> hack for Ubuntu (follows) which tries to use the DT passed from
> the bootloader.  I planed to add it, or similar hack to ps3-linux.git
> sometime soon.  As I mentioned in another mail, the proper way is to
> just grab the command line passed from the bootloader and use it with
> the built-in DT.  Ben's patch does effectively the same thing.

I think that "hack" should be done differently and merged because we
should really support booting off 2.6.16.

The way to do so is to reset the LMB's from ps3_mm_init() before
starting adding to them... or more specifically, reset the LMB's
available region (NOT the reserved ranages !)

We also want to "Fixup" the device tree memory node to make sure that
what is exposed to userspace contains only the RMO as the first region
in there (exposing the rest of memory in a second region or not is
unimportant).

Ben.
