Subject: Re: [PATCH/RFC] add proc_dir_entry fields to device_node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3F7DA229.7090409@austin.ibm.com>
References: <3F7DA229.7090409@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1065254150.645.16.camel@gaston>
Mime-Version: 1.0
Date: Sat, 04 Oct 2003 09:55:50 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-10-03 at 18:22, Nathan Lynch wrote:
> Hi-
>
> I am doing some ppc64 work to enable dynamic addition and removal of
> nodes in /proc/device-tree.  It seems that recording a node's directory
> and symlinks (if any) in the device_node is the easiest way to assure
> that a node is cleaned up properly after deletion.
>
> I need to add a few lines to fs/proc/proc_devtree.c::add_node() to
> record the proc entries for each node as it is processed.  These will
> refer to fields that do not yet exist in ppc's device_node.  I propose
> adding these fields to ppc's device_node (patch attached).  If that
> comment in prom.h about breaking BootX is still valid, there are
> alternatives, but they would likely involve ifdefs and macros.

The comment is valid. You cannot change the format of struct
device_node on ppc32 without breaking BootX booting :(

The solution to this is to finally break it by having a conversion
step between the BootX-passed device-tree and the in-kernel one

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
