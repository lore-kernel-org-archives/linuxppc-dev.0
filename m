Subject: Re: XFS patches and 2.4.20-ben10
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030415034001.20841.qmail@kunk.qbjnet.com>
References: <20030415034001.20841.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Message-Id: <1050389966.6537.103.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 15 Apr 2003 08:59:26 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-04-15 at 05:40, Robert E Brose II wrote:
> I've been using xfs for several months and I wanted to apply the
> current devel xfs patches to the 2.4.20-ben10 kernel and ran into
> a name clash in include/linux/sysctl.h.
>
> In the enumeration of the CTL_VM names, the patch is trying to insert
> VM_PAGEBUF=14
> when there already exists a
> VM_HEAP_STACK_GAP=14
>
> VM_HEAP_STACK_GAP=14 doesn't exist in the stock 2.4.20 kernel.
>
> Is there a preferred way to work around this until the problem is
> solved? I assume that changing VM_PAGEBUF=14 to 15 would mean a
> recompile of all the xfs utils as well.

VM_HEAP_STACK_GAP comes from aa- series "silent stack overflow"
patch that I applied to my tree. You can safely change it's sysctl
number, I don't think any userland util rely on it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
