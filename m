Date: Sat, 17 Jun 2000 01:05:41 +0200
From: Claus Enneper <cl.en@gmx.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re:  quik-1.3.1and 2.2.16_pmac-stable ?
Message-ID: <20000617010541.B508@olis.north.de>
Reply-To: cl.en@gmx.net
References: <v04210100b56ffd20eb36@[151.189.12.209]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


PB3400

 >rsync'ed 2.2.16 two days ago, built it with the same config, but got
 >this error in OF:
 >DEFAULT CATCH!, Code=FFF00300 at   %SRR0: 0014B008  %SRR1: 00003070

hi,
in '/usr/src/linux-pmac-stable/arch/ppc/kernel/prom.c' line 431:
	/* Find the OF version */
	prom_op = call_prom(RELOC("finddevice"), 1, 1, RELOC("/openprom"));
	RELOC(prom_version) = 0;
	if (prom_op != (void*)-1) {
	    char model[64];
	    int sz;
	    sz = (int)call_prom(RELOC("getprop"), 4, 1, prom_op, RELOC("model"), model, 64);
	    if (sz > 0) {
		if ( strncmp(model,RELOC("IBM"),3) ) {
	    	    char *c;
		    for (c = model; *c; c++)
		        if (*c >= '0' && *c <= '9') {
			    RELOC(prom_version) = *c - '0';
			    break;
		        }
		} else
		    chrp = 1;
	    }
	}
	if (RELOC(prom_version) >= 3)
		prom_print(RELOC("OF Version 3 detected.\n"));

all (prom_version) have their RELOC, so that's not the point.
unfortunatly, I'm not able to make a diff to 2.2.15pre14 to see the difference.

Thanks for any other hint.
--
Yours, ce

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
