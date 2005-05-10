Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id D8850679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 01:14:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 10 May 2005 08:14:16 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B007228DB0@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, "Kumar Gala" <kumar.gala@freescale.com>
Cc: Tom Rini <trini@kernel.crashing.org>, cpclark@xmission.com,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
> On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> > On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> > > Couldn't you eliminate the ($shell ..) construct altogether, like=20
> > > this?:
> > >
> > > $(obj)/uImage: $(obj)/vmlinux.gz
> > > ??????? $(Q)rm -f $@
> > > ??????? $(call if_changed,uimage)
> > > ??????? @echo -n '? Image: $@'
> > > ??????? @if [ -f $@ ]; then echo 'is ready' ; else echo 'not
made'; fi
> >=20
> > Yes, and this seems to actually work.
> >=20
> > Sam, does this look reasonable to you.  If so I will work up a
patch.
>
> Looks ok - but I do not see why use of $(shell ...) did not work out.
> Please bring your working version forward.
=20
It's because both any $(xxx) in the command will be expanded prior to
the command being executed ("command" meaning all lines in the complete
command script for the target in question - not on a line-by-line
basis).

Thus, the original $(wildcard), and also the $(shell) above are
evaluated/expanded by gmake prior to running any of the the "rm -rf",
"if_changed", and "echo" commands, and hence run before the uImage file
is created, and hence always think that it doesn't exist.

The only solution is to get the shell to do the evaluation of whether
uImage exists - that way, the evaluation is guaranteed to happen after
the uImage is (hopefully) created.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
