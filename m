From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <christopher.murtagh@wcg.mcgill.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mmu_context_overflow
Date: Thu, 15 Feb 2001 23:27:35 +0100
Message-Id: <19350110155919.4689@smtp.wanadoo.fr>
In-Reply-To: 
 <Pine.LNX.4.21.0102151523330.3305-100000@saraswati.wcg.mcgill.ca>
References: <Pine.LNX.4.21.0102151523330.3305-100000@saraswati.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I just saw this message for the first time on one of my machines (G4/450)
>as well. I've been getting a lot of 'eth0: transmit timed out, resetting'
>which would freeze the network in kernel 2.2.17 (I'm now running 2.2.18,
>which seems to survive it). My machine is taking on about 120,000 http
>requests per hour though and there doesn't seem to be any effect on the
>performance. Is this something I should worry about?
>
> Any info would be much appreciated.

No, I don't think you should worry about these. those messages simply
need that the kernel ran out of VSIDs and had to re-assign them all. It's
perfectly harmless as long as it doesn't happen too often.

I'm more concerned about your network problems however. I beleive the
chip is a GMAC chip with a 5201 PHY (can you confirm ?). With 2.2.18, you
should not have transmit timeouts. If you have some, then there's either
a bug in the driver (which seemed to be rock-solid so far) or, we are
hitting a HW issue.

Does the gmac driver display some version informations when the kernel boots ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
