Message-ID: <3DF5C533.2050809@maxxio.at>
Date: Tue, 10 Dec 2002 11:42:59 +0100
From: Reinhard Schwillinsky <rsw@maxxio.at>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kd@medcare.is>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded:] 8xx_io/enet.c
References: <EADB10BAC266A14A85ECBF8686A73E31938190@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kári Davíðsson wrote:
> Hello,
>
> I am hitting the following code (i.e. the printk() is reached) in the interrupt handler for the ethernet on a custom 823e board in arch/ppc/8xx_io/enet.c
>
> 	/* Check for receive busy, i.e. packets coming but no place to
> 	 * put them.  This "can't happen" because the receive interrupt
> 	 * is tossing previous frames.
> 	 */
> 	if (int_events & SCCE_ENET_BSY) {
> 		cep->stats.rx_dropped++;
> 		printk("CPM ENET: BSY can't happen.\n");
> 	}
>
> Clearly this can happen, even though the comment sais otherwise.
> This happens for a "high" datarate sunrpc interface operating over TCP/IP.

As far as I remember "BSY" in an 8xx SCC means that no more receive
buffers are available. This happens when the driver software isn't fast
enough to return currently received buffers to the SCC. This can occur
when too few buffers are allocated or at very high data rates.


>
> Is it safe to ignore this "error" or is it a real bug that should be investigated?

I don't know the current version of the enet driver but I think it's
"save" to ignore that message but you should check why that occurs. You
can increase the number of buffers allocated for the rx part of that
particular SCC.

>
> I am a litle unclear on the ethernet operation in whole.

This has nothing to do with ethernet directly! Only a received ethernet
packet cannot be stored. Higher protocols (f.e. TCP) should resend the
missing data!


rgs Reinhard


--
----------------------------------------------------
Reinhard Schwillinsky        Tel.: ++43/1/205 255/210
Maxxio technologies GmbH     Fax.: ++43/1/205 255/900
Prinz Eugen Strasse 8        A-1040 Vienna/Austria


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
