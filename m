Date: 7 Nov 2001 14:11:24 -0000
Message-ID: <20011107141124.12482.qmail@mailweb22.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dan Malek" <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: "OpenPIC versus EPIC" in MPC8240 !
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> It's not magic, just a bad software hack.  We tell the
> openpic that it has interrupts from 16 to 32, not from
> zero.  OpenPIC interrupt 16 matches EPIC interrupt zero.
   16-32 ? NumSources of OpenPIC = 24. It should be
either (0-23) or (16-40). 16-32 is noWhere.

> The interrupts zero to 15 are given to the 8259.
> The problem with this method is we can't get to some
> of the other EPIC features, but we are discussing
> alternatives.
>
  Its not a "HACK" dan. Its a bug. Just verify
the register layout of OpenPIC and EPIC. You
will find that "openpic_init" is populating
reserved memory areas of EPIC. No wonder, we get
bogus interrupts. You can verify this in the code.
  Moreover Had the code really wanted seperation
of vector spaces of OpenPIC and EPIC, it should have
called "openpic_init" with
"offset value = "NUM_8259_INTERRUPTS"

sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
