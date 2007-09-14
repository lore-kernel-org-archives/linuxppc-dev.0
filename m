Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 08701DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 01:49:44 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1083737wag
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 08:49:43 -0700 (PDT)
Message-ID: <fa686aa40709140849o400fc5d0oaaee540fa416fefe@mail.gmail.com>
Date: Fri, 14 Sep 2007 09:49:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <46EAA65E.5080006@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
	<46EA8CD7.2050304@genesi-usa.com>
	<fa686aa40709140753sb3e0e9cv28fa5215f4db3a@mail.gmail.com>
	<46EAA65E.5080006@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/14/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Grant Likely wrote:
> > On 9/14/07, Matt Sealey <matt@genesi-usa.com> wrote:
> >> sparse, irq_of_find_and_map isn't much help). Maybe I am just not
> >> looking in the right place but not being an MPC52xx PIC Expert I
> >> wouldn't even know where to start...
> >
> > The l2 irq numbers map directly to the interrupt numbers listed in the
> > 5200b user guide.  For example, on p7-11, the masks are listed for
> > main interrupts 0 through 16.  and on p7-17,18, the peripherial
> > interrupts are listed as numbered from 0 to 23 (but notice that it
> > does *not* line up with bit positions).
>
> Wow I even had to search.. it's on p7-13 here..
>
> Right but it does start from a certain bit and progress linearly
> across the rest of the register.
>
> However, what is interrupt 0 and what is interrupt 16? Do you start
> from the left or the right (i.e. Motorola big endian or Rest Of
> World big endian)??
>
> > However, it is interesting to note that other than in the register
> > definitions, I don't think there is anywhere in the 5200b user manual
> > that simple lists the interrupt numbers for each interrupt type.
>
> I think the interesting note is that picking out "what does IRQ 4
> in the main interrupt group handle" or picking out a device and
> saying "this is IRQ 10" is still, even with your explanation, a
> matter of luck and handedness.
>
> Personally I would count from the right (Motorola bit 31) and
> work my way from LSB to MSB, but Motorola likes it's backwards
> representation and so do some other people. So, does bit 31
> equal interrupt 0 or interrupt 16? :)

No, they are explicitly numbered.  Are you looking at the 5200 or the
5200B user manual?  In my copy, on page 7-17, I see this:  PSa0 in
peripheral interrupt 0 (l2=3D0), PSa23 is peripheral interrupt #23
(l2=3D23)

       Bits        Name
         8       PSa23  BestCom
         9       PSa22  BDLC
        10        PSa0  BestCom
        11        PSa1  PSC1
        12         PSa2    PSC2
        13         PSa3    PSC3
        14         PSa4    PSC6
        15         PSa5    Ethernet
        16         PSa6    USB
        17         PSa7    ATA
        18         PSa8    PCI Contr
        19         PSa9    PCI SC In
        20         PSa10   PCI SC In
        21         PSa11   PSC4
        22         PSa12   PSC5
        23         PSa13   SPI modf
        24         PSa14   SPI spif
        25         PSa15   I2C1
        26         PSa16   I2C2
        27         PSa17   CAN1
        28         PSa18   CAN2
       29:30         =97     Reserved
        31         PSa21   XLB Arbit

>
> Then there are the status encoded registers, which report which
> IRQ is firing. They are just values. But which value corresponds
> to which interrupt (left or right reading) here or do they even
> have completely different ones?
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
