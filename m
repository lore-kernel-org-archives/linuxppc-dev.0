From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Robert E Brose II" <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: usb-storage.o - Unresolved symbol ppc_generic_ide_fix_driveid
 in 2.4.20-pre7-ben0
Date: Fri, 4 Oct 2002 14:05:38 +0200
Message-Id: <20021004120538.12787@192.168.4.1>
In-Reply-To: <20021004052905.2189.qmail@kunk.jriver.com>
References: <20021004052905.2189.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Tried to get all the info in the title..
>
>usb-storage.o - Unresolved symbol ppc_generic_ide_fix_driveid in 2.4.20-
>pre7-ben0
>
>This worked in 2.4.19.
>
>Ide is not enabled on this machine which is a SuperMac S900 (though if
>I remember right, enabling it didn't make any difference).

It doeds make a difference, that function is only exported if you have
IDE enabled in the .config. However, if you just enable it and redo
the make, it may not work, as the actual export table may not be
rebuilt properly.

I suggest you enable IDE, backup .config, make distclean,
restore .config, make oldconfig, then make.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
