Message-ID: <03a001c0d74e$60022c70$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Dan Malek" <dan@mvista.com>, "Gabriel Paubert" <paubert@iram.es>
Cc: <brian.kuschak@skystream.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com>
Subject: Re: dcache BUG()
Date: Mon, 7 May 2001 16:35:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> How can this happen?  The reservation for the lwarx in 1) has
> long been broken, so this swtcx. will fail.....
>
> -- Dan

Because reservation is held per processor in the "Reservation bit", and it
doesn't seem like the 405GP checks the reservation address.

>From the PPC manual:
"Because the hardware doesn't compare reservation address when executing the
stwcx. instruction, operating systems software MUST reset the reservation if
an exception or other types of interrupt occurs to insure atomic memory
references of lwarx and stwcx. pairs."

-eli


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
