From: Paul Mackerras <paulus@linuxcare.com>
To: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.43 failed
Date: Mon, 14 Feb 2000 10:25:39 +1100
Content-Type: text/plain
References: <38A6C19F.92468821@wanadoo.fr>
MIME-Version: 1.0
Message-Id: <00021410380401.14021@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Feb 2000, Martin Costabel wrote:

> On my 6400, it compiles and boots OK, but there are some little itches:
>
> - rsync complains about "send_files failed to open
> Documentation/kernel-docs.txt: Permission denied"

Fixed now.

> - rsync copies a spurious file drivers/net/.#ppp_generic.c which is a
> dead symlink

It was an emacs lock file or something.

> - during booting, there is a message
> "/proc/sys/net/ipv4/ip_always_defrag is missing - Cannot control IP
> fragmentation"

Rusty (Paul Russell) here reckons that he personally ripped that out
(leaving a bleeding stump :-) early in the 2.3 series, because it isn't
needed any more.

> - while using my ethernet card with the de4x5 driver, I get hundreds of
> "kernel: Warning: kfree_skb on hard IRQ c010ded8". Seeing that this
> address is inside the de4x5 driver, I tried to compile it as a module,
> so that I could also compare it to the tulip driver. Didn't work at
> first:

Apparently you now have to use dev_kfree_skb_irq instead of dev_kfree_skb
in hardware interrupt routines.  Presumably the de4x5 driver hasn't been
converted yet.

> - the tulip module loads without problem, but doesn't seem to like my
> ethernet card (DEC 21041 chip). It gives me hundreds of "kernel: eth0:
> 21041 transmit timed out, status fc6800". With 2.2.14 kernels, the tulip
> module works OK.
>
> - the de4x5 module complains about missing symbols; and this is in fact
> a bug I had mentioned already some days ago. I repeat the patch below.
> It seems to be necessary, and it cures the problem. I am now on the net
> with de4x5 as a module, but I still get the warnings, now with an
> address in the module:
> Feb 13 15:06:14 rennes-231 kernel: Warning: kfree_skb on hard IRQ
> c7159770
> Feb 13 15:07:24 rennes-231 last message repeated 421 times
> Feb 13 15:12:01 rennes-231 last message repeated 97 times
> and so on.
>
> How can I get rid of the warnings (short of disabling the line that
> produces it in net/core/skbuff.c)?

Find the places where dev_kfree_skb is called from interrupt context and
change them to dev_kfree_skb_irq.  If you aren't sure you can say

	if (in_irq())
		dev_kfree_skb_irq(skb);
	else
		dev_kfree_skb(skb);

> Here is the patch needed by pci driver modules:

Thanks, I've applied that to my sources.

I just tried 2.3.44 on the powerbook 3400 and it fell over during boot.
Oh well.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
