Date: Tue, 27 Feb 2001 05:14:45 -0700
From: Matt Porter <mporter@mvista.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bogus interrupt
Message-ID: <20010227051445.A32137@cx258813-a.chnd1.az.home.com>
References: <NDBBIFIMCKPOADMAJOKMEEEOCPAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMEEEOCPAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Mon, Feb 26, 2001 at 12:54:19PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 26, 2001 at 12:54:19PM +0100, Stefano Coluccini wrote:
>
> Hi everyone,
>   I'm trying to run kernel 2.5 on Motorola MVME5100 and, after the sti
> istruction in start_kernel, the kernel hangs due to a spurious interrupt.
> (Bogus interrupt -1)
> Is this a well-known problem also in other ports ? or have anyone of you a
> suggestion to solve this ?

If you are using the default openpic initsenses in prep_pci.c then you
might see this problem since MPIC input 1 now has the 550 UART.  You'll
need to change the initsenses since the edge triggered ECC interrupt
used to be on input 1 on the older boards.

--
Matt Porter
MontaVista Software, Inc.
mporter@home.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
