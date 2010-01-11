Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 3EF3EB6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 08:21:09 +1100 (EST)
Received: by yxe9 with SMTP id 9so10973157yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 13:21:06 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100111204302.B42B23F6DA@gemini.denx.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
	<20100111204302.B42B23F6DA@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 14:20:46 -0700
Message-ID: <fa686aa41001111320x53835478ie56d85a18e221631@mail.gmail.com>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2010 at 1:43 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
> In message <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com> =
you wrote:
>>
>> Please don't. =A0I know that a lot of other 5200 code uses register map
>> structures in this way, but I consider it bad practice. =A0I coded this
>
> May I ask _why_ you consider this bad practice?

Many reasons.  First off, while C structures somewhat represent the
layout of a hardware register set, I still find them a poor fit.
Registers do not data structures, and trying to describe them as such
causes problems.  Not all devices get mapped onto the bus in the same
way.  ie. a single device can get wired up with 8-bit wide addressing
on one system and 32 wide on another.  A struct cannot encode this.  I
also find I often need to access registers at "none-native" widths due
to implementation details of the device which is made messy when the
layout is encoded in a C struct.  Finally, we're talking about a
hardware interface here.  Driver authors must understand exactly what
they are doing when writing to registers and it is my opinion (though
others may disagree with me) that using structs to describe register
maps encourages a glosses over details that are best left explicit.

I used to prefer C structs for register definitions, but my opinion
changed as I gained more experience.

> Is a structure not the most natural way to encode the specifics of a
> hardware interface (address offet, bus width, etc.) in C?
>
> What do you recommend instead? =A0Using lists of register offsets
> (without any type information) as for example ARM is doing?

Yes, that is what I prefer.  That and, when needed, device-specific
accessor functions that can be adapted for different bus attachements.

>> driver without a structure for a reason. =A0The reason I haven't removed
>
> Could you please explain this reason?

As described above.

> I'm trying to understand if this is a MPC52xx specific reasoning, or
> if you apply this to all of PowerPC, or generally to all kernel code?

I've stated what I prefer.  I don't think I've rejected any code that
uses structs over register offsets, but I do apply friction on any
patch that changes a current driver from one to the other without
need.

> And: is this just your personal preferences, or generally agreed on?

Others will need to answer that.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
