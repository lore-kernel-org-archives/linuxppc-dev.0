Message-ID: <3CC05EBD.6050905@embeddededge.com>
Date: Fri, 19 Apr 2002 14:15:25 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Frank Przybylski <frank.przybylski@vas-gmbh.de>
Subject: Re: MPC8xx and IDMA !?!?
References: <3CBD321A.60CE328@imc-berlin.de> <3CC006F1.5940B04E@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:


> So my workaround for now is to allocate more than I need and correct the
> value for IBASE like
> 	ibase += ibase % 16
>
> Could anyone think of a better solution? Since I waste at least 16 bytes
> in the DPRAM.

That's the way I always did it on 8xx.  For 8260, I added a second alignment
parameter to dpram_alloc().  If the address it would return isn't properly
aligned, it will waste sufficient memory behind your back to make this
happen :-)  At least it won't waste any if you align and the sizes are
modulo the alignment.


> Where is Wolfgangs m8xx_cpm_dpfree() !?!?

Sitting in my basket of things to do.  I wanted to add the alignment
to the 8xx as well, and this complicates the free function because it
doesn't know alignment was done with the region you may have allocated.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
