Content-Type: text/plain;
  charset="iso-8859-1"
From: Skip Gaede <sgaede@attbi.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Memory leak
Date: Fri, 21 Jun 2002 22:22:56 -0400
References: <200206200352.32895.sgaede@attbi.com>
In-Reply-To: <200206200352.32895.sgaede@attbi.com>
MIME-Version: 1.0
Message-Id: <200206212222.56162.sgaede@attbi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday 20 June 2002 03:52, Skip Gaede wrote:
> Folks,
>
>
> I'm looking for a recipe on how to track where my memory
> is disappearing to. I am running kernel
> 2.4.19-pre10-ben0, patched for the nubus-pmac platform. I
> have 40 MB RAM and a 100 MB swap file on the local hard
> disk.
>
OK, I recompiled the kernel with CONFIG_DEBUG_SLAB. The
memory is being consumed by the size-2048 cache, which I
believe is being used for network traffic.

I have two scenarios:

1) boot the system off the local hard drive and run X -query
192.168.0.1

2) boot the kernel+initrd off the local hard drive and mount
root via NFS, then run X -query ...

In the first case, the 2048 cache works well. After 30
minutes of continuous network traffic,

size-2048      5   50  2048    3    25  1

In the second case, after only 15 minutes

size-2048   187 228  2048  94  114  1  (15 min)
size-2048   918 928  2048 460 464  1  (60 min)

So the number of active buffers is much higher and it
continues to grow. Does anyone have any idea as to why this
is happening, or how to debug it?

Thanks,
Skip

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
