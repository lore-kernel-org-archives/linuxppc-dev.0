Message-ID: <38A7C1DF.99A5346@wanadoo.fr>
Date: Mon, 14 Feb 2000 09:50:39 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.43 failed
References: <38A6C19F.92468821@wanadoo.fr> <00021410380401.14021@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> On Mon, 14 Feb 2000, Martin Costabel wrote:
[]
> > Feb 13 15:06:14 rennes-231 kernel: Warning: kfree_skb on hard IRQ
> > c7159770
> > Feb 13 15:07:24 rennes-231 last message repeated 421 times
> > Feb 13 15:12:01 rennes-231 last message repeated 97 times
> > and so on.
> >
> > How can I get rid of the warnings (short of disabling the line that
> > produces it in net/core/skbuff.c)?
>
> Find the places where dev_kfree_skb is called from interrupt context and
> change them to dev_kfree_skb_irq.  If you aren't sure you can say
>
>         if (in_irq())
>                 dev_kfree_skb_irq(skb);
>         else
>                 dev_kfree_skb(skb);

Thanks. Your new version in 2.3.45pre works correctly (shows me once
more why I'm not a kernel developer: I replaced all 3 occurrences of
dev_kfree_skb by if (in_irq()) ... else ..., which worked, too; you
replaced just one of them by dev_kfree_skb_irq; I had tried this before,
but always got the wrong one :-( ).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
