Message-ID: <3EF88216.6010106@austin.ibm.com>
Date: Tue, 24 Jun 2003 11:53:42 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposal for device-tree walking semantics
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(Apologies if this doesn't get associated with the original post
correctly, the original post was forwarded to me.)

I've been looking at this issue a bit from the ppc64 side.

 > The get() function is actually more a try_get()
 > (the idea is that a remove in progress would make it fail)

Regarding removal of nodes, how might the removal of files under
/proc/device-tree be handled?  Note that the data pointers associated
with each proc entry refer to struct property's, not device_node's.
Should the struct property's have refcounts too?  Also note that
add_node() in fs/proc/proc_devtree.c creates symbolic links; I haven't
been able to come up with a pleasing solution for removing those.  It
seems to require a manual traversal of the proc_dir_entry's subdir list,
an operation during which the procfs code holds the big kernel lock
(e.g. proc_lookup()).

I agree with renaming device_node to of_node.

Nathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
