From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: install with Debian CD ok, but can't boot any kernel
Date: Fri, 18 Oct 2002 20:35:05 +0200
Message-Id: <20021018183506.17444@192.168.4.1>
In-Reply-To: <200210181610.SAA19888@ipnmail.in2p3.fr>
References: <200210181610.SAA19888@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Now that I can see the hard disk I can do all the steps to install the
debian
>except the last one. I'm using the woody CD. the yaboot step seems to create
>a good yaboot.conf file in /target/etc but the only thing I have is a blank
>screen.
>
>Any idea ?

I'm not too sure right now, I suspect the yaboot installer isn't
properly setting up the OF path for the kernel or yaboot itself
(it's probably doing hd: which is wrong as OF thinks this is
the ATA/100, at least that's my understanding of the situation).

What I would do as a workaround (until something better is found)
is to put yourself yaboot, the kernel and a yaboot.conf file
on an HFS (or HFS plus) partition, edit that yaboot.conf so
that it just loads the kernel next to it with "image=vmlinux",
then, from OF console (enter it manually), boot that yaboot.

You may have to type the whole path to the ATA/66 disk in
OF instead of "hd", which is something like
"/pci@f2000000/mac-io/ata-4" or maybe with an additional
pci-bridge in between. To see the actual nodes in OF, type
"dev /" then "ls". To see the "shortcuts" (aliases), do
"dev /aliases" then ".properties"

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
