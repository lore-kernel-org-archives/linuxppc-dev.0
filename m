Date: Mon, 1 Apr 2002 11:53:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Message-ID: <20020401185335.GA23174@opus.bloom.county>
References: <0203292359.AA12953@ivan.Harhan.ORG> <3CA4E98B.F7A7ECE0@mvista.com> <20020401152507.GB6360@opus.bloom.county> <3CA87831.974F719D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CA87831.974F719D@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 01, 2002 at 10:09:37AM -0500, Mark A. Greer wrote:
> Tom Rini wrote:
>
> > OK.  The problem is that the original PPC location of the bi_recs was
>
> Acutally, my problem was that I misread his respone.  I thought he was trying to
> say the find_bootinfo was in the bootloader or something like that.
>
> > So the always-correct call for platform_init() is:
> > parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
>
> Is there a reason we shouldn't just fix find_bootinfo then?

The intent of parse_bootinfo taking a location was to allow it to be a
per-platform thing.  Eg pmac/chrp/prep don't use r3, and can't always
anyhow.  Everything else uses r3 just because it's where the
bootloader/wrapper caneasily put things.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
