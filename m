Message-ID: <1351.80.7.99.14.1091206704.squirrel@80.7.99.14>
In-Reply-To: <20040730165026.GN16468@smtp.west.cox.net>
References: <20040729213319.GA5857@george.solinno.co.uk>
    <20040730154611.GL16468@smtp.west.cox.net>
    <20040730160848.GA12973@lst.de>
    <20040730165026.GN16468@smtp.west.cox.net>
Date: Fri, 30 Jul 2004 17:58:24 +0100 (BST)
Subject: Re: [0/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Christoph Hellwig" <hch@lst.de>, paulus@samba.org,
	linuxppc-dev@lists.linuxppc.org, barbieri@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Fri, Jul 30, 2004 at 06:08:48PM +0200, Christoph Hellwig wrote:
>
>> On Fri, Jul 30, 2004 at 08:46:11AM -0700, Tom Rini wrote:
>> > OK.  Thinking back to last time, I asked about being able to blacklist
>> > some machines Residual Data (since it's crap on some, but I don't have
>> > the dumps handy) and you mentioned that you'd like to do fixups on the
>> > data since there's a few cases where the data is mostly good, just
>> with
>> > one or two incorrect things.  And it doesn't look like either are
>> > here... yet.
>> >
>> > Could you do a 10/9 patch that adds a bit of help to the PREP_RESIDUAL
>> > config option along the lines of:
>> > "When this information is incorrect, it could lead to the machine
>> > behaving incorrectly.  If this happens, please disable PREP_RESIDUAL
>> and
>> > try again."
>> >
>> > And change the existing "Unless you expect to boot on a PReP system,
>> > there is no need to select Y." to "If you are running a PReP system,
>> say
>> > Y here, otherwise say N."
>>
>> As the residual support is runtime switchable can we also have a kernel
>> boot option?  That way we can switch it off for distro kernels.
>
> A distro kernel would probably want it on by default (it makes more
> machines work than it breaks).  As for runtime switchable, Leigh?

I'm working on it ;-)

You should note that IBM PRePs will not work at all without residual
data, due to this code in arch/ppc/platforms/prep_setup.c:

    if ( !strncmp(res->VitalProductData.PrintableModel,"IBM",3) )
        _prep_type = _PREP_IBM;
    else
        _prep_type = _PREP_Motorola;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
