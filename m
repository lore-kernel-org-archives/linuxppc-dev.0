Message-ID: <3DE501C1.2080700@iram.es>
Date: Wed, 27 Nov 2002 18:32:49 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: wilhardt@synergymicro.com
Cc: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455 and lwarx
References: <3DE3EF0B.F3204162@synergymicro.com> <3DE4C207.8020500@iram.es> <3DE4DAE1.9060602@embeddededge.com> <3DE4FCC9.E62EF5B1@synergymicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave Wilhardt wrote:
>>
>>Why do you want to use these instructions on a data space that isn't
>>cached?  Further, why are you running this class of processor with
>>uncached memory?
>>
>
>
> I have a "shared memory" region that is used between VME boards in
> a chassis.  The "master pool" is located on the system controller in DRAM.
> In order to maintain coherency between the boards, I have marked the region
> as non cached.  This was fine for non-MPC745x boards.  Time for a redesign...


Are you sure that it even worked to start with ? Consider a system with 3
processor boards (processor 1 is the system controller):
- processor 2 does lwarx on the shared memory
- processor 3 does another lwarx before 2 has time to perform the stwcx.
- processor 2 does the stwcx.
- processor 3 does not notice it since the address is taken by processor 1
VME<->PCI bridge and it does not snoop it
- processor 3 does the stwcx. but modifies a stale value, for example a
counter will be incremented once instead of twice, or both processors will
have taken a lock and who knows what the consequences are.

I believe that the scheme could work with 2 master boards accessing shared
memory on one of the boards, never with 3 or more.

As the author of one of the Tundra Universe drivers, I'd suggest using
semaphores to do this. Disclaimer, Ie never used them since several of my
boards have a Universe I (with an impressive list of bugs) and all are
single master systems. So I never defined an API to access the semaphores
in my drivers.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
