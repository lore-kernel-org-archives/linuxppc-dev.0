Message-ID: <3E4CF810.8040803@intracom.gr>
Date: Fri, 14 Feb 2003 16:07:12 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: [2.5] Hang on 8xx in head_8xx.S
References: <3E4B9D4E.7080808@intracom.gr> <3E4BCCB8.8030301@embeddededge.com> <3E4C9BC3.3020104@intracom.gr> <3E4CF139.2040909@embeddededge.com>
In-Reply-To: <3E4CF139.2040909@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Pantelis Antoniou wrote:
>
>> Cool. How can I help?
>
>
> Once I get it basically booting there are lots of little things in
> drivers that need updating.
>
>> Could you take the time to  highlight the changes needed?
>
>
> I'm not sure what all of them are just yet :-)
>
>> How about a discussion about some improvements?
>
>
> discuss away........
>
> Thanks.
>
>
>     -- Dan
>
>
>
>
Ok then ;)

1. I think it is time to look into the
artificial (IMO) division between 8xx_io/8260_io.

The CPM is basically the same, but there are two kind
of drivers for every peripheral that is common.

i.e. arch/ppc/8xx_io/enet.c arch/ppc/8260_io/enet.c

I believe we should have one common driver for both.

2. The profusion of platform specific #defines in the
drivers. Typically something like the configuration of
the port I/O for the ethernet/uart whatever.

How about having a platform specific source file
that will export functions for the platform specific
part of the configuration?

i.e. instead of

#if defined(CONFIG_XXX)
    .. blah ..
#elif defined(CONFIG_YYY)
    .. blah blah ..
....

something like this

    m8xx_platform_ethernet_port_config(int scc);

3. Ability to have the drivers built as modules.
I believe I have made my case in a previous mail
so I'll spare you this time.

How about taking a look at the patches I have sent
you earlier about the dpalloc/hostalloc problem?

Thanks for taking the time to  respond, and
when you get it booting I'm willing to work
at any of these areas.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
