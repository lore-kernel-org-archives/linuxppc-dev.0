Subject: Re: Proposal for device-tree walking semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3EF88216.6010106@austin.ibm.com>
References: <3EF88216.6010106@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1056497116.13642.6.camel@gaston>
Mime-Version: 1.0
Date: 25 Jun 2003 01:25:18 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-06-24 at 18:53, Nathan Lynch wrote:
> (Apologies if this doesn't get associated with the original post
> correctly, the original post was forwarded to me.)
>
> I've been looking at this issue a bit from the ppc64 side.
>
>  > The get() function is actually more a try_get()
>  > (the idea is that a remove in progress would make it fail)
>
> Regarding removal of nodes, how might the removal of files under
> /proc/device-tree be handled?  Note that the data pointers associated
> with each proc entry refer to struct property's, not device_node's.
> Should the struct property's have refcounts too?  Also note that
> add_node() in fs/proc/proc_devtree.c creates symbolic links; I haven't
> been able to come up with a pleasing solution for removing those.  It
> seems to require a manual traversal of the proc_dir_entry's subdir list,
> an operation during which the procfs code holds the big kernel lock
> (e.g. proc_lookup()).
>
> I agree with renaming device_node to of_node

I currently have no definitive idea on how to implement removal and
such... I think the kobject mecanism may help, but that's not something
I've studied enough. The problem on how memory is allocated for
properties and then how to free it remains.

For now, what I care about is to have proper semantics for "clients" of
the device-tree so that things like removal can be implemented properly
later on.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
