Date: Sun, 12 Sep 1999 18:28:26 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Possible bug in quik
Message-Id: <19990912182826.028542@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In quik 2.0, in main.c (bottom of function main()), I found:

    /*
     * For the sake of the Open Firmware XCOFF loader, the entry
     * point may actually be a procedure descriptor.
     */
    start = *(unsigned *)entry;
    if (start < load_loc || start >= load_loc + len
	|| ((unsigned *)entry)[2] != 0)
	/* doesn't look like a procedure descriptor */
	start += entry;
    printf("Starting at %x\n", start);
    (* (void (*)()) start)(params, 0, prom_entry, 0, 0);
    prom_exit();

I was wondering why, when we don't find an XCOFF desc, do we _add_ entry to
start. I would have replaced start completely since in this case, we may
want to
enter the kernel at entry directly. Did I miss something ?



-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
