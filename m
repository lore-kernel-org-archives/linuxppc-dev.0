Date: Fri, 25 Oct 2002 17:50:35 +0200
Subject: Re: PrPMC800 interrupt problem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Tom Rini <trini@kernel.crashing.org>
From: Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <20021025154020.GA30713@opus.bloom.county>
Message-Id: <805E3F14-E831-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On fredag, oktober 25, 2002, at 05:40 , Tom Rini wrote:

> On Fri, Oct 25, 2002 at 05:15:46PM +0200, Anders Blomdell wrote:
>
>> The problem seems to be that the UART generates an Harrier internal
>> interrupt. This should be handled as any other MPIC interrupt, but it isn'
>> t. This lack of an appropriate handler (irq_desc[16].handler == 0) makes
>> the Harrier chip wait forever for an EOI.
>>
>> A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:
>
> Did you update the initsenses table as well?  And are you sure you are
> calling openpic_set_sources() correctly?  That only maps OpenPIC source
> 16 to be Linux interrupt 16, and doesn't catch any of the other sources
> ('tho I don't have the prpmc800 manual in front of me)
The initsenses table was correct already, but open_pic.c relies on the
number of interrupt sources returned from the feature reporting register,
that excludes the internal sources (in Harrier, Hawk and Raven chips at
least). Thus these interrupts are not correctly setup. I posted a possible
(==untested) solution a few minutes ago.

BTW: Is there any documentation on the OpenPIC controllers, the AMD link
seems to have disappeared.

Regards

Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
