Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 8FA0ADE094
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 05:50:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1382063wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Apr 2008 12:50:04 -0700 (PDT)
Message-ID: <440abda90804071250v60bd970fh938e9690836ab61@mail.gmail.com>
Date: Mon, 7 Apr 2008 13:50:04 -0600
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MVL Linux on MPC8560 Booting goes into infinite loop in
	early_init memset_io ( )
In-Reply-To: <47FA4601.1080707@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080407064547.M56295@cdotd.ernet.in>
	<47FA4601.1080707@freescale.com>
Cc: Deepak Gaur <dgaur@cdotd.ernet.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 7, 2008 at 10:04 AM, Scott Wood <scottwood@freescale.com> wrote:
>  BTW, it's generally bad form to post the same question repeatedly.  If you
> have new information regarding your problem, just post a followup in the
> same thread containing the new information.

Agreed!  I was about to respond to your new post, and then I
discovered this nearly identical slightly older post.

On Mon, Apr 7, 2008 at 12:37 AM, Deepak Gaur <gaur.deepak@gmail.com> wrote:
> While booting MVL linux on MPC8560 based board the kernel goes into a
> infinite loop in setup.c

Someone please correct me if I am wrong, but those symbols inside the
BSS should only be variables (not functions....) which are initialized
to zero.  The whole reason for BSS is to initialize variables to a
0/null value.

Now, about the infinite loop.  Can you check to see if perhaps you are
getting an exception?

I have no experience with the MPC8560, but I've seen a couple problems
that occur involving memset_io.  What happens is that a TLB miss
exception occurs when the CPU gets inside of memset_io.  Do you have
the ability to check that with a debugger (by setting breakpoints at
exceptions, such as the data and instruction TLB miss exceptions) to
see if you are getting exceptions?
