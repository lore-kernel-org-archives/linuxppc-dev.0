Message-ID: <3C10E6C0.923FA543@ssh.com>
Date: Fri, 07 Dec 2001 17:56:48 +0200
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Ricardo Scop'" <scop@digitel.com.br>,
	linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, andy_lowe@mvista.com
Subject: Re: Kernel oops while routing
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E7F@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:
> IMHO, I could suggest an easier patch, that would result in modifying only
> one line of code, without changing the 'tx_full' logic. In function
> fcc_enet_start_xmit, instead of checking the ready bit (which is bad), we
> could only check if cur_tx has reached dirty_tx, and then call
> netif_stop_queue. Does it make sense?

I have fixed our version of the driver with very similar modifications.
Since that it has not leaked any memory while it has been under testing
for several months.

>
> BTW, I worked hard last week in debugging the fcc_enet driver. It was not
> handling correctly some transmission errors, resulting in the transmitter
> completely stopping, without restarting. This is related to an errata
> (CPM37) from Motorola about the 8260, concerning the way of restarting the
> transmitter. If someone is interested, I can release a patch for that.
>

I have noticed the same problem on old kernel versions. I think i
mentioned about it on the mailing list and i understood that it had been
already fixed on later versions, but i didn't check the status of the
latest driver version.

- Arto

--
Arto Vuori
email: avuori@ssh.com
mobile:	+358 40 754 5223

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
