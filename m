Message-ID: <BE684E2C997AD51199530002A56B2079066241@MCHH2A1E>
From: Babic Stefano <Stefano.Babic@icn.siemens.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Lockup problem with 8260
Date: Mon, 7 Jan 2002 10:10:09 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Also Wolfgang in another thread said he thinks that could be
> a problem with
> the A.1 mask of the 8260 we're using, but I suspect it's not
> that simple,
> this cache trouble is so pervasive it has to be something
> misconfigured.

I can confirm the problems with the A.1 mask. According to Motorola, bus snooping is not working. The fcc_enet driver turns on bus snooping, but in our extensive tests we found a lot of problems (system locked up, wrong frame was sent,...).
For this reason we changed the driver disabling bus snooping and using not cached buffers for DMA (sigh !). The A.1 mask has other big problems, too: the MCC controller simply does not work (confirmed by Motorola). We upgraded to B.3 mask, but we are still using local buffers for DMA.

-Stefano

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
