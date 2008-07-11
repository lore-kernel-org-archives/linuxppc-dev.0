Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re: Making __copy_tofrom_user more readable for powerpc
	(arch/powerpc/lib/copy_32.S)
In-reply-to: <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com> 
References: <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com>
Date: Fri, 11 Jul 2008 16:50:10 +1000
Message-ID: <22167.1215759010@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com> you wro
te:
> Hi all,
> I am trying to optimize the __copy_tofrom_user function for PPC4xx,
> and I would want to know why the exception handling code has been made
> so complicated. All the fixup code should do is to store the number of
> bytes that failed in copy in r3 and return back.
> 
> The current code tries to copy one byte at a time after read fault. I
> don't understand why that is necessary. It then clears out the
> destination. All these logic has made the code very unfriendly to
> read.

Would a multibyte read be guaranteed to be aligned?

> I have a version which just keeps a count of bytes copied till any
> fault happened. Then for any exception, I just substract this value
> from the total number of bytes to be copied, and store in r3 and
> return back. This is the common fixup code for all paths. It makes the
> fixup code much more readable like other architectures (eg. x86).
> 
> My questions are:
> 1) Why do we need to distinguish between load and store failure? If
> either load or store fails, the copy did not go thru. But the code
> sets r9 to 0 for load failure, and r9 to 1 for write failure. Why do
> we need to care for that?
> 
> 2) For read failure, why do we clear out the destination (lines 509 to
> 529 in arch/powerpc/lib/copy_32.S)? Other architecture don't do that.

Which version of the code are you referring to here?  Can you give us a
git SHA1?

Clean up patches are welcome.  Maybe it would be best to post what you
have as an RFC patch.  Then people can take a closer/easier look at your
cleanups and/or try them out.

Mikey

> 
> I would appreciate any comments.
> 
> Thanks,
> Prodyut
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
