Mime-Version: 1.0
Message-Id: <v04220800b75a8da0ed9d@[10.0.0.42]>
In-Reply-To: <3B34616F.2090403@noos.fr>
References: <3B2E747A.6090607@noos.fr>
 <01061823464800.00690@reality.internal> <3B2F0871.2070304@noos.fr>
 <0106192003070C.00609@reality.internal> <3B34616F.2090403@noos.fr>
Date: Sat, 23 Jun 2001 11:19:01 -0700
To: Guillaume =?iso-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: another endianness issue...
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:29 AM +0200 6/23/01, Guillaume Laurès wrote:

>And I guess on ppc we would need all the bits line reversed.
>
>So, my question is how to handle this in the best approach, the goal
>being a unified driver nt too difficult to maintain

Kill the struct definition, and replace it with a bunch of accessor
macros that mask-and-shift.  When moving the register value to or
from the hardware, use le32_to_cpu() and cpu_to_le32() as appropriate.

Bitfields are not a good way to describe hardware registers.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
