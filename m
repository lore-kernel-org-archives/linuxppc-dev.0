Date: Mon, 3 Jun 2002 17:53:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020603075322.GI6765@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To narrow down the cause of the problem I tried copying a 1M file of
random data through the loopback interface (using netcat).

The file was corrupted, specifically certain sections became zero in
the destination copy.  Oddly enough the zeroed chunks were always 2684
bytes long and the next byte after the affected region was a multiple
of 32k (e.g. bytes 0xc7584-0xc8000 zeroed).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
