Subject: Re: kgdb and console output
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030314172536.GF6421@ip68-0-152-218.tc.ph.cox.net>
References: <1047642589.367.19.camel@muse>
	 <20030314172536.GF6421@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1048172718.4458.15.camel@muse>
Mime-Version: 1.0
Date: 20 Mar 2003 15:05:18 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-03-14 at 17:25, Tom Rini wrote:
> On Fri, Mar 14, 2003 at 11:49:50AM +0000, Ibon Gotxi Garcia wrote:
>
> [snip]
> > INIT: INIT: NIT: IT: T: : version 2.78 bootingersion 2.78 bootingrsion
> > 2.78 bootingsion 2.78 bootingon 2.78 booting
> >

>
> It's related to the 'console' support inside of the serial driver / kgdb
> stub.  The best way, IMHO, around this is to use the 'kgdb_demux'
> script.  I don't have the URL handy, but google knows.

I have found it in
http://linux.junsun.net/porting-howto/src/kdmx-1.02.tar.gz

but I'm still unable of making it work. I seems fine when the kernel is
loading, but it begins to do funny thing when we move to userland.

I think the hole point is character scape: GDB packets are
$data#checksum, so when some output (no debug output, just normal one)
is made to the console having '$', '#' or even '+' and '-', the kdmx
script goes mental.

I'm thinking in two possible solutions:

1.- Wait till kgdb has LAN support (gdb packets over udp, instead of
over the serial port).
2.- Patch the console driver (no idea how) to avoid printing '$' or '#'.
Probably a terrible hack, but perhaps useful for development.

Any idea about this?


Cheers.
Ibon.

>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>
--
Ibon Gotxi Garcia <igotxi@jazzfree.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
