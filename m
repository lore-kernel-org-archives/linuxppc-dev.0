Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id C32C62BDD3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 10:22:13 +1000 (EST)
Date: Mon, 20 Sep 2004 20:15:43 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <E91A9C3A-0B51-11D9-9327-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0409201949550.6348@dell.enoriver.com>
References: <Pine.LNX.4.60.0409201531570.5653@dell.enoriver.com>
	<E91A9C3A-0B51-11D9-9327-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Sep 2004, Dan Malek wrote:

> On Sep 20, 2004, at 4:05 PM, Robert P. J. Day wrote:

>> ...... i'm not even going to ask what that
>>    does, but it will come up later.  i'm just going to accept it as
>>    magic and move on.
>
> Don't ask later.  It's all magic.  Just follow the instructions.

hold on a minute.  while i can appreciate not digging too deeply into 
the magic that is a microcode patch, a number of the questions i asked 
were pretty fundamental ones that should be answerable, completely 
independent of the actual patch.  at least, they should be answerable 
to the extent that the source code in micropatch.c makes a certain 
amount of sense.  so, given that i've been told on occasion to RTFS to 
get the answers to my questions, and i've gone and RTFS, it's not 
unreasonable that i get to ask some questions about TFS. :-)

and some of those fundamental questions, based on reading TFS, would 
be:

1) what does it mean to have two different areas for the microcode
    patch in DPRAM?  the manual describes the second area as an
    "extension"?  does that mean that execution simply flows from the
    first area to the second?  (frankly, that would make no sense to
    me, but what do i know?)

    and it would be useful to understand to know why the SMC patch
    writes a little info into offset 0x2e00 and far more into 0x2f00,
    which means that the patch written into that alleged 512-byte
    "extension" isn't even contiguous.  now *that's* confusing, and
    it shouldn't just be dismissed as magic.

2) is the cpm_load_patch() routine justified in assuming that,
    regardless of the patch, there will *always* be a 0x2000 and 0x2f00
    array to load?  why should that be the case when one scenario is
    that the extension might just as well start at 0x2e00 instead?

    again, that's a pretty straightforward question that's independent
    of the *function* of the patch.  it's just asking about the basic
    format.

apart from the underlying magic, are there *any* rules that patches
have to follow, just to make micropatch.c more comprehensible, or to
at least be able to see when something just doesn't look right?

(as an aside, you didn't comment on a couple of other things, so i'm 
not sure if they had any validity.  that is, what is obviously a bad 
value for RPBASE, and the fact that verify_patch() hardcodes the value 
commproc->cp_rccr = 0x0009 at the end, which seems pretty clearly a 
bad idea.  can we agree that those things seem to be a problem? 
because if they aren't i'm more confused than ever.)

> At one time, we had a bunch of little patches.  IIC only, SMC only,
> USB SOF.  Then, some of them were combined so you could do
> multiple relocations at once, like IIC and SMCs.  I don't know if
> we have ever done that.  I know Wolfgang has been keeping
> more up to date with his development trees, so it wouldn't hurt
> to look there.

in fact, i've looked at his trees pretty carefully, and i like the way 
he's broken out his patches as individual .c files.  based on that, i 
hacked up a 2.6-based Kconfig file which gives the user a menu of 
patches to choose from, so there's none of this "you have to manually
define USE_SMC_PATCH to get this patch" silliness.

instead, you get something under the MPC8xx menu like (assuming you 
only ever get to install a single patch):

Microcode patches -->
 	[ ] None	(the default)
 	[ ] I2C/SPI
 	[ ] I2C/SPI/SMC

and so on.

if patches aren't going away any time soon, then it only makes sense 
to make their selection as simple and as comprehensible as possible, 
and not require the user to actually edit files to define selection 
macros for them.

rday
