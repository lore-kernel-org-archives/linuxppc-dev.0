Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DF8420A.4040409@intracom.gr>
Date: Thu, 12 Dec 2002 10:00:10 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	joakim.tjernlund@lumentis.se, acurtis@directvinternet.com,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se> <3DF70C55.3010709@intracom.gr> <20021211145658.GA19456@opus.bloom.county> <3DF754CE.7030608@intracom.gr> <3DF8057D.3040106@embeddededge.com>
In-Reply-To: <3DF8057D.3040106@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Pantelis Antoniou wrote:
>
>> Perhaps the best way to proceed is just to fix the
>> xxx_cpm_hostalloc() and
>> xxx_cpm_dpalloc() routines to work more intelligently, and to
>> forget about consistent_alloc entirely...
>
>
> You are totally missing the proper use of these functions.  The 'cpm'
> functions are used specifically to assist the management of memory
> for the CPM peripherals on the 8xx and 82xx processor.  There are often
> unique attributes of mapping these spaces that must be considered.  The
> only thing to "fix" in these functions is to make a resource free (and
> smarter resource management) that works for loadable modules.
>
> The purpose of consistent_alloc() functions is to provide a method of
> allocating DMA consistent (i.e. non-cached in our case) memory spaces
> for _any_ purpose.  These are functions you will find in other processor
> architectures and have become standard part of many Linux processor
> ports.
>
> The 'cpm' and PCI (and other non-PCI functions like USB OHCI) functions
> will rely on the consistent_alloc() functions to provide consistent
> spaces when necessary.  There are some memory mapping assumptions made
> about the way consistent memory is allocated for the purposes of
> portabilty
> and performance.
>
> All of these functions are required and work reasonably well as currently
> implemented when they are used properly.
>
> Thanks.
>
>
>     -- Dan
>
>
>

Fine,

I see now.

Since what I'm doing regards the CPM the proper thing to do
is to actually use the 8xx routines.

They only reason that I considered the consistent() routines was
that the 8xx routines are unsuitable for use in modules.

I will prepare a patch that deals with the inefficiencies
of the 8xx routines.

I believe you are the person that is assigned for maintaining
the 8xx series. Can you audit them after I post them
to the list?

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
