Message-ID: <3CABC065.6050107@embeddededge.com>
Date: Wed, 03 Apr 2002 21:54:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:


> It's becoming easier though, with the __cacheline_aligned macro.  Plus
> I think if the buffer is individually kmalloc()ed it will be properly
> aligned.

Alignment is only half the problem.  You have to ensure the object is
modulo cache line size as well.  You can't be sharing cache lines subject
to DMA with other DMA or processor core data.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
