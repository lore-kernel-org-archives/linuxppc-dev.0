Message-ID: <40CDB84A.7010906@intracom.gr>
Date: Mon, 14 Jun 2004 17:38:02 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>, Matt Porter <porter@cox.net>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Stefan Nickl <Stefan.Nickl@kontron.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH][RFC] I2C support for MPC107 and relatives
References: <1087207803.7360.83.camel@newt> <1087208600.7360.102.camel@newt> <1087210866.18442.5.camel@lucy.pep-kaufbeuren.de> <1087213025.7360.181.camel@newt> <1087218066.18446.11.camel@lucy.pep-kaufbeuren.de> <1087219489.7360.278.camel@newt> <36790086-BE08-11D8-8344-000393DBC2E8@freescale.com>
In-Reply-To: <36790086-BE08-11D8-8344-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kumar Gala wrote:

>
> Adrian,
>
> It would be really helpful if you could take a look at getting the
> driver working on a MPC107 based systems.  We have not had time to look
> at that fully.  However, are intent has always to get the same driver
> working for MPC10x, 824x, 85xx systems since the block is very similar.
>
> - kumar
>
> On Jun 14, 2004, at 8:24 AM, Adrian Cox wrote:
>
>> On Mon, 2004-06-14 at 14:01, Stefan Nickl wrote:
>>
>>> On Mon, 2004-06-14 at 13:37, Adrian Cox wrote:
>>>
>>>> On Mon, 2004-06-14 at 12:01, Stefan Nickl wrote:
>>>>
>>>>> FYI: The Motorola folks recently pushed a I2C driver called
>>>>> i2c-mpc.c
>>>>> into the 2.4 tree, it seems to be fully OCP'ed, save it seems the
>>>>> platform hooks are only present for 8540 yet.
>>>>
>>>>
>>>> Do you know which 2.4 tree? It's not in linuxppc_2_4_devel or in the
>>>> main 2.4 kernel. If their driver works with my OCP patch, it would
>>>> save
>>>> a whole lot of effort.
>>>
>>>
>>> Sorry, I was talking about
>>> bk://ppc.bkbits.net/linuxppc-2.4
>>
>>
>> It does similar things to mine, but it can support the controller on 8
>> as well as 32 bit busses.  I may try putting it into my 2.6 tree and
>> using it on the MPC107.
>>
>> - Adrian Cox
>> Humboldt Solutions Ltd.
>
>
>
>
>
>
I'm thinking about taking the plunge and OCPfying 8xx so perhaps we
can get this thing organized.

I'd like to have a hierarhy of the peripherals like so:


                  ______- CPM -______  ___________  ___
                 /        /          \            \     \
                /        /            \            \     \
            Timers     SCC1..n _       SMC__      IDMA   DSP-f  etc.
                      /  |  \   \      |    \
                     /   |   \   \      \    \
                 UART  HDLC Enet QMC     UART Transp.
                                 /   \
                         HDLC0..63  Transp0..63

Of course with only one protocol active per SCC/SMC.

Is something like this supported with the OCP code, and if not
how could I get around in making it work?

IMO, we could share alot of the stuff between the CPM1/CPM2/CPM3...

Regards

Pantelis

P.S. I suck at ASCII art


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
