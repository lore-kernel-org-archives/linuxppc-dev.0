Date: Fri, 8 Mar 2002 20:19:54 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200203090419.g294Jsv00164@dave.home>
To: amitc@brocade.com
Subject: Re: Bugfix in arch/ppc/8260_io/fcc_enet.c linux-2.4.17
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know, I haven't tried that. I would think that when the netboot
stuff takes effect it will bring the ethernet device in question "up".

I have seen other ethernet drivers that actually deallocate the irq when
they are down, and reallocate it when they are up. That's how I determined
fcc_enet.c had a problem. Even when it is down you can watch the
/proc/interrupts count up. So I knew the interrupt was getting called and
inside the interrupt it was passing the packets onto the linux network
stack.

I think it is a safe bet this change won't hurt anything at all. I believe
all functioning ethernet devices are supposed to have their IFF_UP bit set
in the dev->flags field. I think a better fix would be to disable the
interrupt, or even deallocate/reallocate the irq on down/up. I didn't trace
out what happens when an interface is downed though, I don't know how the
driver knows when its interface goes up or down. I tried
strace ifconfig eth0 down
To see what syscall was doing the magic, but I didn't find it.

-Dave


>David,
>
>Is there an impact of your change on the board doing a netboot and
>loading the rootfs from a nfs mount?
>
>Thanks
>Amit
>
>David Ashley wrote:
>> I found a bug which was manifest when linux boots and lots of ethernet
>> packets are coming in. I think the problem is because the fcc_enet.c

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
