Message-ID: <3C3CABD8.4060401@embeddededge.com>
Date: Wed, 09 Jan 2002 15:45:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Crash in serial_console_setup
References: <638AA0336D7ED411928700D0B7B0D75BB323E9@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gessner, Matt wrote:


> I'm using the main source from bitkeeper, linuxppc_2_4.
> It just got patched for a Data TLB miss error.

I'm finding lots of trouble with 8xx boards over the past couple of
days.  Did this work before you applied the latest change sets?
I'm not too keen on this patch, as it (or some other software problem)
seem to be dependent on particular silicon revisions for success or failure.

Originally, the 8xx never managed "changed" indicators in the page tables
primarily due to tlb miss overhead.  If a page was marked write enabled, it
was also marked "changed".  This caused additional overhead for page sharing
but I think avoided some software and silicon bugs.  Somewhere around 2.4.5 or
so we started using changed bits on the 8xx, and it has caused nothing but trouble.

The cache management instructions are particularly prone to weird behavior on
the different silicon revisions.  I don't think any processor version ever has
met all of the cache fault (alignment, tlb miss/error, cache enabled, etc)
behavior as described in documentation.

There is more lacking than a few lines of assembler code in the tlb exception
handlers.  I don't yet know what that is (but I intend to find it :-).  Any
examples of success/failure would be appreciated, along with posting the details
of the processor mask.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
