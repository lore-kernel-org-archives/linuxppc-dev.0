From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>, <linuxppc-commit@fsmlabs.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PVR hell
Date: Wed, 28 Mar 2001 00:51:38 +0200
Message-Id: <20010327225138.22949@smtp.wanadoo.fr>
In-Reply-To: <3AC0EF44.E2BCE2F6@mvista.com>
References: <3AC0EF44.E2BCE2F6@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I think we should just continue the ppc_md indirect function call
>concept and just use it earlier in the kernel for more things.  All
>of the low level initialization in 'head.S' or other processor specific
>things in other files should just be indirect fucntion calls that are
>processor specific.  Sure makes porting and understanding the software
>much easier.

Well, at one point, we must fill up this function table depending on the PVR
value. For my immediate Altivec & L2 needs (and for quite a bit of things
with the "desktop" family of CPUs), a feature bit mask is enough.

So what I propose is to have head.S parse a table, and when a matching
CPU is found, call it's init function (pointed to by a table entry) and
load the feature value from it.

The init function can then fill other ppc_md fields if needed. That can
be done
as a second step

I'm not sure however there is real need of completely "virtualizing" CPU
features as hard as MMU implementation or cache implementation. There is
a quite clear distinction between embedded CPUs and "desktop" CPUs, and
I see no immediate need to have a binary kernel that can run them all.
(I may be wrong here, please correct me if I am).

For now, my primary concern is about things that will affect the desktop
systems, especially the powermacs using the whole range of PPC "32 bit
desktop" CPUs from 601 to 7450. I don't think it's wise to try to have
a common binary kernel that support both those and 4xx and 8xx.

But it can be done if you really want. My proposed init table allow you
to implement it on top of it.

A typical table layout would be:

 u32    pvr_mask;
 u32    pvr_value;
 u32    feature_bits;
 void   (*init_cpu)(void)
 char*  name;

The head.S code would then iterate the table, checking if

 (PVR & pvr_mask) == pvr_value

And when found, would copy feature_bits to a global, eventually the table
entry as well (to get the CPU name and whatever other stuffs we want to
put in the table for this CPU), and call the init_cpu function.

If you want to fill additional ppc_md entries from init_cpu(), then
you are free to do it ;)

For now, I want something simple that can fit in _2_4 easily

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
