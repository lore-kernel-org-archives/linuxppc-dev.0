Message-ID: <00933BFA237CD2119B3400409543582704A275@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Possible bug in CPM interrupt handling
Date: Thu, 12 Oct 2000 14:35:47 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In function cpm_interrupt (commproc.c), the last line is:

	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr |= (1 << vec);

I think this should be:

	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr = (1 << vec);

If there are nested interrupts (are these allowed?) this makes sure
only the specific interrupt we are dealing with is acknowledged.

--
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>             )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587              )=-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
