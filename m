Date: Tue, 23 Apr 2002 08:20:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Morin <rmorin@miranda.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8240 PTE setup
Message-ID: <20020423152053.GB15715@opus.bloom.county>
References: <200204221807.g3MI7Uh27005@ares.gdc.ca> <3CC46932.4040805@embeddededge.com> <200204221907.g3MJ7th27102@ares.gdc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200204221907.g3MJ7th27102@ares.gdc.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 22, 2002 at 03:08:10PM -0400, Robert Morin wrote:
>
> Hi Dan,
>
> > > I have based my work on the Linux kernel 2.5.8 ....
> >
> > You don't want to use that yet :-)  Use the 2_4_devel kernel.
>
> Ok, I will look to it.

Also, the zx4500 port (and the sandpoint one which it is based upon)
relied on an old hack to get the EPIC going which was to overload
OpenPIC_NumInitSenses like so:
static void __init
zx4500_init_IRQ(void)
{
	OpenPIC_InitSenses = zx4500_openpic_initsenses;
	OpenPIC_NumInitSenses = sizeof(zx4500_openpic_initsenses);
	openpic_init(1, 0, NULL, -1);

These need to be replaced with calls to openpic_set_sources(int first,
int total, void *first_ISU);

I'm in the middle of making this switch for the LoPEC boards as an
example for how the rest need to look, but if you get yours working
please post what you did. (what I've tried, and what Matt Porter and I
_think_ is right isn't working, and I'm looking into that now).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
