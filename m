Message-ID: <381EB2D4.A5C5DEEF@fi.infn.it>
Date: Tue, 02 Nov 1999 10:45:56 +0100
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Christian Zankel <chris@mvista.com>
CC: Matt Porter <mporter@eng.mcd.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BUGboot 0.2 Patch
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com> <3802668E.C5A6BAC6@fi.infn.it> <19991014094024.A568@fwrsl-11.phx.mcd.mot.com> <3819E280.43C05759@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi again,
now it works!! I can boot from flash!

It was just the problem of endianess; for some reason when I compiled
mkbugboot.c on the board it take it as little-endian; it was sufficient
to force the code putting:

  bbh->entry_offset =header_size;
  bbh->routine_length= MAX_BOOT_SIZE+boot_size+2;

instead of:

  bbh->entry_offset	= cpu_to_be32(header_size);	/* Entry address */
  bbh->routine_length	= cpu_to_be32(MAX_BOOT_SIZE+boot_size+2); 

and everything went fine. I'll look to understand why it take it as
LITTLE_ENDIAN on a big endian computer, but now I'm very happy!

Thank you again for the good work.
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
