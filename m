Subject: Re: Disable cache on 74xx
From: Gary Thomas <gary@mlbassoc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brian Waite <waite@skycomputers.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1045688879.12534.80.camel@zion.wanadoo.fr>
References: <200302191552.01911.waite@skycomputers.com>
	<1045688879.12534.80.camel@zion.wanadoo.fr>
Content-Type: text/plain
Date: 19 Feb 2003 15:48:50 -0700
Message-Id: <1045694930.22231.6567.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-02-19 at 14:07, Benjamin Herrenschmidt wrote:
>
> On Wed, 2003-02-19 at 21:52, Brian Waite wrote:
> > Hi all,
> > 	I am trying to hunt down a memory controller configuration problem and I have
> > been asked to disable all caching so as to remove it from the equation. I can
> > easl disable L2 but when I start ucking with the WIMG bits to set cache
> > inhibit, The kernel panics with stack overflows. Does anyone know where or
> > what I have to set to disable caching?
>
> Hrm... set L2 and L3 off, then hack HID0 to disable L1 ?

There are other problems with this.  With the caches disabled
(via HID0) all data cache instructions (like DCBF) will fail.
There are some of these in the kernel itself, but beware that
GLIBC has it's own set.

... totally disabling the data CACHE with Linux is non-trivial.

--
------------------------------------------------------------
Gary Thomas                 |
MLB Associates              |  Consulting for the
+1 (970) 229-1963           |    Embedded world
http://www.mlbassoc.com/    |
email: <gary@mlbassoc.com>  |
gpg: http://www.chez-thomas.org/gary/gpg_key.asc
------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
