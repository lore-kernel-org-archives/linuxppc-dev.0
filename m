From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cardbus issues on TiBook
Date: Thu, 6 Sep 2001 23:10:35 +0200
Message-Id: <20010906211035.8782@smtp.wanadoo.fr>
In-Reply-To: <3B97DA58.6894B342@acm.org>
References: <3B97DA58.6894B342@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>As some of you may know I am trying to get an IBM microdrive working on
>my TiBook.  I know there is an issue with irq's which I am trying to
>work out but I have run into another issue I don't understand.
>
>I get the following message in my startup:
>
>kernel: Can't get bus-range for /pci@f2000000/cardbus@1a

This one existed since the new PCI code in PPC 2.3.x. It's
mostly harmless ;) Basically, it says that OF didn't setup a
ranges property for the cardbus bridge, but Linux will assign
it some bus numbers anyway.

>I rsync'ed with Ben H's kernel recently and I found that the ioports and
>memory ranges I had set for cardmgr were not working anymore.  So I
>started changing them.  In my efforts to find ranges that worked I found
>that "cat /proc/ioports" would result in a segfault.  From what I can
>tell it is running off the end of the buffer in vsnprintf?

Well, my recent kernels do add things to /proc/iomem (but not ioports),
as I basically request IO ranges for all OF devices.

This shouldn't affect /proc/ioport nor cardbus, but well, you might
have found a real bug/

>Before the Cardbus modules are loaded "cat /proc/ioports" works fine.
>
>So my question is, what does the above message mean?  It is something
>which is worked around later, or could it be the root of my problem?

Some more infos about the panic would be useful. Enable xmon and tell
me what it sayd about the PC & LR of the crash, and the backtrace
(obtained with the "t" command). If you use a recent yaboot and kernel,
you may even add sysmap=<of_path_to_System.map> in yaboot.conf to get
the System.map loaded along with the kernel. This will allow xmon to
display function names as well as addresses in the backtrace.

>Thanks,
>Ira Weiny
>iweiny@acm.org
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
