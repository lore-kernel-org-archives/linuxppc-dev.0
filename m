Message-ID: <3CFB620E.9F8643EB@ssh.com>
Date: Mon, 03 Jun 2002 15:33:18 +0300
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 IDMA experience?
References: <NCBBIINEHIPFGJPLBEIFAEPFDHAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
>
> Does anyone have experience with IDMA on the 8260? Are there any special
> considerations if you wanted to use the memory-to-memory copy function in
> place of a memcpy()? (kernel memory only at this time)

I have been using IDMA to transfer data between kernel memory and a
FPGA. I also did some testing with memory-to-memory transfers and i
didn't find them to be worth the trouble. Performance ain't that great.
You probably get more speed by copying with your CPU, though you might
avoid some cache trashing.

I did also notice that when i am doing memory-to-peripheral (or
vice-versa) transfers, IDMA corrupts simultaneous Ethernet traffic
unless IDMA is set to low-priority mode. Same might apply for
memory-to-memory transfers.

Arto

--
Arto Vuori
email: avuori@ssh.com
mobile:	+358 40 754 5223

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
