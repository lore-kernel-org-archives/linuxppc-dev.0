Message-Id: <s87e4deb.082@netstal.com>
Date: Thu, 13 Jan 2000 22:12:46 +0100
From: "Niklaus Giger" <n.giger@netstal.com>
To: <grant@lcse.umn.edu>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Antw:Help Sought: 8390-Ethernet Troubles on PowerPC 4xx Port
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>> Grant Erickson <grant@lcse.umn.edu> 13.01.00 02:10:28 >>>
>
>The latest road bump I've encountered on the path to a Linux port for the
>PowerPC 403GCX running on IBM's "Oak" evaluation board is getting the
>National Semiconductor DP83902AV chip to behave.
>...
Dear Grant,

I had a look at your code. As I cannot (yet) compile and build the kernel, I give you only some
very general advice.

As far as I know there are problems accessing the Ethernet chip directly.
On the PPC403GA there was a maximal wait of 128 clocks for a memory access being delayed,
which the DP83902AV could easily surpass if there was some remote DMA happening on the 
other side.

Therefore there is a register in the MAC which you can test, whether the access to the
8390 was okay or not. (0x01 means okay, adress is probably  0xf4000030.
There is a similar register to test whether reading the DMA port is okay (Adress 0xf4000020).

There are two solutions to this problem the PPC403GCX allows you to wait indefintely on
a memory access (governed by a bit in the IOCR-register I think), (if your HW permits it).
Unfortunatly this is a general setting therefore you really may hang forever (or till power off,
whatever comes first).

The other "solution" is a SW patch, whose structure I sketch like this.

For each memory access (aka inb_p, out_p) do the following.

First disable the Ethernet interrupt, 

Check whether the PageRegister is okay (do not forget after each access to
check for the success bit).

If the page register does not match, write the register (do not forget after each access to
check for the success bit).

Now you may read or write to the register (do not forget after each access to
check for the success bit).

Reenable (if necessary) the ethernet interrupt.

This gives you quite some overhead but it is the only SW-patch which will you garantee
correct operation over longer periods...

I hope this helps.

Regards



                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             !
                                                                       
 
                                                                                                 

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
