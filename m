Message-ID: <3D6D1A27.2090700@embeddededge.com>
Date: Wed, 28 Aug 2002 14:44:55 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260/8xx Embedded Boot patch
References: <FA06AA2C99BCD511951200005A99441001E3ED4C@irvexch1.sextantifs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Curtis, Allen wrote:


> 1. The loop that overwrites the b_enetaddr[] should check that it does not
> contain any information before assigning the default. This could have been
> passed in by the bios.

If you have a board/rom configuration where this isn't the right thing
to do, then create a new embed_config() function for it.  These are not
intended to be generic functions, and if you someday have experience with
lots of different board/rom combinations, you'll understand why this is
the case.

This code is intended to be a quick and easy update for a new board without
having to worry about how you may affect someone else.  There are LOTS of
boards using this code, and I don't like to be changing something that is
currently working without the ability to test everything else that may
be affected.  You definitely have to take the "if it works, don't touch it"
attitude here and add something new that suits your purpose.


> 2. If you assume that any platform that uses CONFIG_EMBEDDEDBOOT may want to
> pass in a bd_info structure,

We don't assume that at all.  In fact there are only three boards now where
we make that assumption and it is clear in the code which ones they are.
There is certainly no standard way of linking information between a boot rom
and this code, and tomorrow we may find something completely different.  If
you write code in embed_config() that expects something to be passed from a
boot rom (which in some cases is not a bd_t), then you must ensure it gets
passed from head.S properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
