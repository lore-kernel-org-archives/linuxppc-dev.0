Date: Thu, 17 Jun 2004 11:55:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 7/9] Support for old IBM PReP boxes
Message-ID: <20040617185506.GA811@smtp.west.cox.net>
References: <1859.80.7.99.14.1086887283.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1859.80.7.99.14.1086887283.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 2004 at 06:08:03PM +0100, Leigh Brown wrote:

>
> This is to support the old OpenPICs in old E20/E30 machines.  They
> seem to be mapped as I/O instead of memory mapped.  These also seem
> to have a bug that the spurious interrupt always seems to be reported
> as 255.  Changing the OPENPIC_VEC_SPURIOUS to 239 (which maps to
> 255 after adding the offset of 16) seems to make it work.  As the
> change seems to make no difference on other machines, it seems better
> to do that than have special code for it.  However, I don't really
> understand how this spurious vector stuff works, so....

If we don't change OPENPIC_VEC_SPURIOUS, how do the E20/E30 behave?  Do
they blow up badly, or just have some spurious bad interrupts?  I've
played with that hunk a bit on a sandpoint and lopec, and didn't see
anything go wrong (lopec didn't get any bad w/ or w/o, sandpoint, always
gets a few bad ones).  If it's a non-fatal problem, I'd rather err on
the side of caution, and leave it be, or export openpic_set_spurious, so
you can give it the right setting on E20/E30.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
