Message-ID: <638AA0336D7ED411928700D0B7B0D75BB323EB@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Crash in serial_console_setup
Date: Wed, 9 Jan 2002 15:47:20 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Dan,

IMMR is 0xFF000502.
PVR is 0x00500000.

This is an 860P, running at about 80MHz.

What's odd is that I had a (patched) version of a tree
that I had working.  I came back from vacation, did a make
and THAT one didn't work.  I have one I did, based on that
same one, much earlier, that STILL works to this day.  But
when I did a 'diff --recursive' I didn't see any changes
between the two that I couldn't write off to some modules
I'm doing on my own (HDLC/WAN).

Maybe I should look at this again.

I've not gotten ANYTHING off bitkeeper to work right; not
2_4 nor 2_4_devel.

I'm not sure why we're getting a fault writing to IMMR
space.  Isn't that somehow protected???

Thanks,

Matt

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Wednesday, January 09, 2002 3:45 PM
> To: Gessner, Matt
> Cc: 'Linux PPC'
> Subject: Re: Crash in serial_console_setup
>
>
> Gessner, Matt wrote:
>
>
> > I'm using the main source from bitkeeper, linuxppc_2_4.
> > It just got patched for a Data TLB miss error.
>
> I'm finding lots of trouble with 8xx boards over the past couple of
> days.  Did this work before you applied the latest change sets?
> I'm not too keen on this patch, as it (or some other software problem)
> seem to be dependent on particular silicon revisions for
> success or failure.
>
> Originally, the 8xx never managed "changed" indicators in the
> page tables
> primarily due to tlb miss overhead.  If a page was marked
> write enabled, it
> was also marked "changed".  This caused additional overhead
> for page sharing
> but I think avoided some software and silicon bugs.
> Somewhere around 2.4.5 or
> so we started using changed bits on the 8xx, and it has
> caused nothing but trouble.
>
> The cache management instructions are particularly prone to
> weird behavior on
> the different silicon revisions.  I don't think any processor
> version ever has
> met all of the cache fault (alignment, tlb miss/error, cache
> enabled, etc)
> behavior as described in documentation.
>
> There is more lacking than a few lines of assembler code in
> the tlb exception
> handlers.  I don't yet know what that is (but I intend to
> find it :-).  Any
> examples of success/failure would be appreciated, along with
> posting the details
> of the processor mask.
>
> Thanks.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
