Message-ID: <1069153308.3fb9fc1cd5d32@pop-mail.india.tejasnetworks.com>
Date: Tue, 18 Nov 2003 16:31:48 +0530
From: Anil Giri <anil@india.tejasnetworks.com>
To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: SDRAM mirroring problem
References: <8039970AF146314597457D3B51A68B382E042E@cossmgmbx02.email.corp.tld>
In-Reply-To: <8039970AF146314597457D3B51A68B382E042E@cossmgmbx02.email.corp.tld>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  Thanks for the response.

Quoting "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>:
>
> Well, an uninformed response may be better than no response??? Here
> goes...
>
> I don't understand how your hardware is set up.
>
> a) Are you connecting the two 64Mbyte chips in parallel as a 32 bit
> wide data bus (this is implied by your use of one chip select). This
> is contradicted by your statement "My problem is that when i write
> some word in first RAM chip is mirrored in the other RAM chip.And
> Effectivly

Sorry for the goof up, basically whatever i write to 0th (0x0) memory location
in getting replicated to 64th MB (0x4000000) location

> i m able to use only 64 MB of RAM." which implies that the two chips
> are expected to be sequential in memory address space.
>
> b) If you are connecting the two chips up sequentially as 64MB by 16
> bits wide on the data bus, you need separate chip selects with the
> first one providing the first 64MBytes of decoded address space and
> the second one the second 64MBytes.
>
> Cheap ASCII art:
>
> a) +----+----++----+----+ 00000000
>    |byt0|byt1||byt2|byt3|
>    |    |    ||    |    |
>    |    |    ||    |    |
>    +----+----++----+----+ 03FFFFFF
>       chip0      chip1

The ram chips are connected in above fashion with single chip select.

> b) +----+----+ 00000000
>    |byt0|byt1|
>    |byt2|byt3| chip0
>    |    |    |
>    +----+----+ 01FFFFFF
>    +----+----+ 02000000
>    |    |    |
>    |    |    | chip1
>    |    |    |
>    +----+----+ 03FFFFFFF
>
> > -----Original Message-----
> > From: Anil Giri [mailto:anil@india.tejasnetworks.com]
> > Sent: Monday, November 17, 2003 3:54 AM
> > Subject: SDRAM mirroring problem
> >
> >   My board uses SAMSUNG K4S511632M SDRAM in 8M * 16 bit * 4 banks
> > configuration (13 rows & 10 columns).Two such chips are used to get
> > 128 MB and uses CS1 for chip select.My board uses MPC852T processor.
> >
> > MPC to SDRAM configuration is as follows:
> > ======================
> > A29 :A0
> > A28 :A1
> > A27 :A2
> > A26 :A3
> > A25 :A4
> > A24 :A5
> > A23 :A6
> > A22 :A7
> > A21 :A8
> > A20 :A9
> > GPL_A0 : A10
> > A18 :A11
> > A17 :A12
> >
> > A6 :BA0
> > A5 :BA1
> > GPL_A3 :CAS
> > GPL_A2 :RAS
> > GPL_A5 :WE
> > =====================
> > My problem is that when i write some word in first RAM chip is
> > mirrored in the other RAM chip.And Effectivly i m able to use only
> > 64 MB of RAM. What could be the problem??? Following SDRAM settings
> > are used
> >
> > IMMR:0xff000000
> > OR1: 0xf8000e00
> > BR1: 0x00000081
> > MSTAT:0x00000400
> > MAMR: 0x80a06114
> > MAR: 0x88
> > MCR:0x80002105

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
