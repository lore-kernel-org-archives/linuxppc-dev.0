Message-ID: <4051FB08.7030903@embeddededge.com>
Date: Fri, 12 Mar 2004 13:01:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org,
	Stephen Williams <612dlag102@sneakemail.com>
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com> <20040312045451.GA25876@gate.ebshome.net> <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kumar Gala wrote:

> Look in u-boot.  They have some user commands that allow
> reading/writing dcr's.

> Also, it begs the question of should this be extended to SPRs,

This discussion continues to point out that DCR implementations
are poor for programming.  Back in the days of 16-bit address
spaces, using DCRs or alternate I/O spaces was reasonable.  Decades
ago Motorola, among others, proved larger address spaces and
memory mapped I/O was a preferable programming method.  I hope
chip designers are listening........we like memory mapped I/O,
and with greater than 32-bit addressing on many processors, there is
plenty of memory to map :-)

The SPRs are for different purposes.  These are logical extensions
to specific processor functions.  They are used in specific places
in the software, I've never experienced a need (except in the case of
the 403 that can't decide which spr to use for the timebase) that I
needed to have some code use different SPRs based on some input.
I don't see a need to provide a general access SPR function.

Of course, I thought of yet another method :-)  We could emulate
memory mapped I/O with DCRs.  We would reserve some VM space, access
to this would be trapped, and the offset would represent the DCR number.
Decode the GPR number from the load or store, and run the DCR move.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
