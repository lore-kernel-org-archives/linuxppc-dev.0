From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14784.18464.5736.911672@argo.linuxcare.com.au>
Date: Thu, 14 Sep 2000 14:38:08 +1100 (EST)
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: success 2.4.0-test8 with latest bk
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1000913195933.37860A-100000@unlserve.unl.edu>
References: <200009132025.WAA00853@piglet.grunz.lu>
	<Pine.A41.3.96LJ1.1b7.1000913195933.37860A-100000@unlserve.unl.edu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe writes:

> Could you try the following change for arch/ppc/mm/init.c?
[snip]
> 		Hash = mem_pieces_find(Hash_size, Hash_size);
> 		clear_hash_table();

Huh?  There is a __clear_user(Hash, Hash_size) call in there but it's
commented out, which I don't understand at all.  Certainly the hash
table needs to be cleared.  Using cacheable_memzero would probably be
the fastest way to do it.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
