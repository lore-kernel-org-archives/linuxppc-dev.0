Date: Mon, 12 Jun 2000 14:46:03 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Out of memory?
In-Reply-To: <200006121039.MAA03014@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10006121406480.19735-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Jun 12 10:53:13 piglet kernel: VM: killing process gimp
> Jun 12 10:55:03 piglet kernel: VM: killing process X
> Jun 12 10:59:46 piglet kernel: VM: killing process X
> Jun 12 12:04:27 piglet kernel: VM: killing process xfs
>
> and so on... acording to the comment in arch/ppc/mm/fault.c, this
> happens when for some reason the kernel cannot satisfy a paging request.
>
> xfs gets killed when rendering a really big font, X when sending it over
> to gimp, and gimp when working with large images....
>
> What reason is there to kill a process for memory reasons? Does a single
> process need to fit _entirely_ into RAM, or can part of a process be
> swapped out? In all of the above cases, I've always had over 100 megs of
> swap free. Or is there a fixed limit on how big a process can get?

There's a limit on process VM size but that's quite large and shouldn'
affect you there. I'd look into the exact reason why the kernel could not
satisfy a paging request in your specific case. You might be attempting to
free pages in order to swap in what you need but kswapd didn't succeed in
swapping out anything. Or maybe there's nothing left on any of the free
lists that are used by __get_free_page(GFP_USER). How much swap space
remains is meaningless as long as there isn't any page in RAM that's "old"
enough to be swapped out.

Try to adjust the page aging parameters to make kswapd more aggressive
about swapping out stuff that's only moderately old (probably done via
/proc/sys/vm/kswapd). Or add some debug code to __get_free_pages to find
out where it gets stuck (i.e. is the paging request even happening at a
stage where the number of free pages is below the highwater mark for
kswapd).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
