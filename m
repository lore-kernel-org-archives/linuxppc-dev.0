Date: Tue, 19 Dec 2000 18:02:31 +0100 (MET)
From: Tobias Otto-Adamczak <tobias.otto-adamczak@e-technik.tu-chemnitz.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Device driver FAQ/Information
In-Reply-To: <64AFC0D37B2ED411BAB300508B6D90A019AAC1@AVALANCHE>
Message-ID: <Pine.LNX.4.30.0012191801490.20443-100000@pandora.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Dan Winkler wrote:
> I know most drivers used the Dual port ram to send the data but would
> it work just as easily with external ram.

The internal DP RAM is very limited so many device drivers use external
RAM for their data buffers. Don't confuse with the buffer descriptors
which are held in the DP RAM. Using DP RAM for buffers may speed up your
system a little bit (?).

> The macros which I am confused with are the __va __pa etc...  Can I
> find an explaination of this anywhere....

This is due to the fact that the core (the Linux kernel if you want) uses
address translation while the CPM does not. So if kernel code wants to
tell CPM about a RAM address it has to translate from his view of memory
(virtual addresses) to CPM's view (physical addresses). Thats what
__pa(addr) is for and vice versa.

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
