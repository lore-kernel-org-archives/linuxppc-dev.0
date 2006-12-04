Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 327AC67B92
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 17:33:44 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2594597ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Dec 2006 22:33:43 -0800 (PST)
Message-ID: <528646bc0612032233y573dfbcdk29a969e19540242a@mail.gmail.com>
Date: Sun, 3 Dec 2006 23:33:42 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [LIBFDT] Fixup byteswapping code
In-Reply-To: <20061204055217.GA32026@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<20061204015329.GA4790@localhost.localdomain>
	<528646bc0612032118i689e9c83gdfc841a3d7b91fcf@mail.gmail.com>
	<20061204055217.GA32026@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/3/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Sun, Dec 03, 2006 at 10:18:25PM -0700, Grant Likely wrote:
> > This requires a hacky cast from int to pointer and back again, and it
> > makes the assumption that int and void* are the same size.  However,
> > on a x86_64 system (not sure about power64), int is 32 bits and void*
> > is 64.  Therefore; a return of (void*)-1 results in address
> > 0xffffffff; not 0xffffffffffffffff.  0xffffffff is right in the middle
> > of valid address ranges.
>
> Urg.  Yes indeed.  The same is true on powerpc64, but userspace is
> usually 32-bits on powerpc64 machines; I hadn't tested compiling
> 64-bit.  An extra (long) in PTR_ERROR() appears to be enough to fix
> it.
>
> > This, of course, produces the warning: "cast to pointer from integer
> > of different size"
> >
> > I believe the accepted convention (at least in the kernel) is to
> > return NULL on error, and libfdt should probably follow that
> > convention.
>
> Actually, there are two conventions in the kernel.  Just returning
> NULL on error is the most common.  But there's a significant number of
> functions that encode an errno into the returned pointer in just this
> way - see the IS_ERR(), PTR_ERR() and ERR_PTR() macros.

Ah, okay, I see that code now.

Hmmm....

Gah, this still makes me really nervous.  The hard part will be how to
make it *blatently* obvious to users that checking for NULL is *not*
sufficient for error checking when using these functions.  Otherwise a
very common code defect will be code using just a NULL check before
dereferencing the returned pointer.

>
> > If you must return the actual error code; maybe rework
> > the API to accept a void** argument to be used to pass back the
> > pointer and use 'return code', or include an 'int*' argument for
> > passing back the err code.
>
> I thought quite a bit about how to pass back errors here.  I'm not
> very fond of the current method of encoding the error codes into the
> return values - it's more magic than I'm comfortable with (especially
> given the multiple encoding methods for different return types) - but
> I haven't thought of a better way.

heh; Isn't beating your head against the limits of a language fun?  I
wish I had a better suggestion myself, but I understand your point and
the difficulty involved.

>
> Having to use a void ** for the real return value is ugly - and means
> you can't stack library calls together (result of one call as
> parameter to another call).  Using int * for the error code is also
> ugly and all too much encouragement for people not too check it.

Yeah, I agree 100%.

>
> What I'd really prefer is an errno-style interface, where a separate
> variable or call must be consulted to find the details of the error.
> But, I can't see any way to do that safely in code that's supposed to
> be easy to import into a wide variety of execution environments
> (kernel, zImage, bootloader, userspace) - some of which could be
> multithreaded.

Unfortunately, there is no simple way to keep around execution
context.  newlib uses a scheme where the exec environment has to
specifically tell it which thread context to use, but it's a bit ugly
in that hooks must be added to the thread scheduler to change the
context pointer on every schedule.

> Oh incidentally, this isn't true at present, but I'd like to make it
> true:  all the library functions should check their parameters so if
> they're *given* one of the encoded error values, they'll just
> propagate the error out again and won't do anything nasty.  That will
> make it safe to nest library calls, even if the inner ones could fail.

good idea

Cheers,
g.
-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
