Message-ID: <3BBDD48C.EBF4CE98@mvista.com>
Date: Fri, 05 Oct 2001 11:41:00 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John_McRoberts@Mitel.COM
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hard disk and segmentation violation.
References: <85256ADC.00515614.00@kanmta01.software.mitel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John_McRoberts@Mitel.COM wrote:

> ioremap: addr=FF000000 to FF000000
> ioremap: addr=30000000 to 30000000
> ioremap: addr=40000000 to 40000000
> ioremap: addr=50000000 to 50000000


This is the whole problem, you can't do this..........

All you did was call ioremap() too early in the kernel initialization
and got 1:1 mapping.  The only valid mapping is the first one for
the IMMR space, the other ioremaps have to be done at a later time,
or preferably by the drivers themselves.  There are lots of discussions
about this in mailing list archives and FAQs.....

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
