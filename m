Message-ID: <3EBA4D38.5030905@embeddededge.com>
Date: Thu, 08 May 2003 08:27:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mm_ptov() in pgtable.c
References: <B895EFF5AF34724880036BDB5B5B814813561F@amer22.avnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kerl, John wrote:

> Does anyone know why we have mm_ptov() in
> arch/ppc/mm/pgtable.c, since we already
> have __va?

They are different functions.  The __va() macro
does simple arithmetic on the 1:1 kernel mapped low memory
addresses.  The mm_ptov() is supposed to do the opposite
of where we use iopa(), which can be used on the entire
virtual address space.  Since there isn't sufficient information
in the kernel to properly implement mm_ptov() in a generic way,
it's implementation has been stalled and we have used a
variety of different methods to return physical addresses
dependent on the way memory has been mapped (which unfortunately
seems to be the Linux design preference).

The APUS configuration uses mm_ptov, I kind of broke it at one
point and I'm waiting for them to stumble across it so we can
fix it for them.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
