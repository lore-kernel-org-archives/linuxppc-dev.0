From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ralph Blach <rcblach@raleigh.ibm.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Date: Fri, 21 Sep 2001 22:42:44 +0200
Message-Id: <20010921204244.20773@smtp.wanadoo.fr>
In-Reply-To: <20010921202929.7340@smtp.wanadoo.fr>
References: <20010921202929.7340@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry, part of my previous post got "eaten" by my mailer, here it is.

>On the other side, running with MMU ON makes that small task of setting
>up the kernel environement on exception entry and unwiding it on
>exception exit a lot more tricky. It prevents using MMU off as an
>efficient way of using SRR0/SRR1 without caring about taking TLB misses
>during critical code pat....

So, I was saying that it prevents using MMU off as an efficient wau to
avoid taking TLB misses during those critical code path. Having the
translations always enabled force you to pin down at least one TLB entry
which makes the TLB handlers more complicated (and so adds overhead). It
also make the exception entry/exit path more tricky as those have to
touch datas not covered by pinned TLB entries (like process stacks), more
or less forcing us to use specific exception stacks (pinned down) to
avoid horrible bloat.

This will make some bits of the 32 bits kernel almost as tricky as when
running below Hypervisor on LPAR :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
