Message-ID: <3AD21750.173DEEE6@mvista.com>
Date: Mon, 09 Apr 2001 16:10:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Schleef <ds@schleef.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bugfix patch to arch/ppc/8260_io/fcc_enet.c
References: <20010406071644.A2517@stm.lbl.gov> <3AD01011.A8FAB831@mvista.com> <20010408152817.A5105@stm.lbl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Schleef wrote:

> The other (and more likely) is:

>         if(cep->skb_cur == cep->skb_dirty)break;

OK, I kind of found this too.  My last message indicated this
should have been fixed, and if this _exact_ line of code is in
your driver, it is too old.  The proper test checks for the buffer
pointers equal, and also adds the 'tx_full' condition so the
wrap around case is properly handled.

The current version of this driver has been subjected to the
University of New Hampshire Interoperability testing lab by
a very large communication company.  The test reports were sent
to me, I made some changes according to their recommendations,
and I believe they were happy with the results.  I would hope
they found all of the errors :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
