Message-ID: <39E5EC6E.D1CF00E2@mvista.com>
Date: Thu, 12 Oct 2000 12:53:02 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ian Abbott <abbotti@mev.co.uk>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Possible bug in CPM interrupt handling
References: <00933BFA237CD2119B3400409543582704A275@MEV01>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ian Abbott wrote:
>
> In function cpm_interrupt (commproc.c), the last line is:
>
>         ((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr |= (1 << vec);

Oh crap, it that _still_ there?  Yes, you are correct, and I don't
know why I can't make this modification stick.  I'm going to push
it into the 2.4 BK tree right now.......

> If there are nested interrupts (are these allowed?) this makes sure
> only the specific interrupt we are dealing with is acknowledged.

Yes, they are allowed and this is a bug.  Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
