Date: Mon, 2 Dec 2002 15:29:37 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm inline
In-Reply-To: <1038587452.4040.22.camel@zion>
Message-ID: <Pine.LNX.4.33.0212021518030.13937-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Ben,

On 29 Nov 2002, Benjamin Herrenschmidt wrote:

>
> On Fri, 2002-11-29 at 17:08, Samuel Rydh wrote:
> >
> > I just noticed that gcc 3.1 doesn't like the following:
>
> According to Franz Sirl, gcc 3.2.1 is one of the very first gcc's
> to not need any special patch for known bugs for PPC32 :) I'd
> suggest you try this one.
>
> I couldn't reproduce that bug with debian sid's gcc 2.95.4, 3.0.4 and
> 3.2.1

Sorry, I replied far too fast to Samuel just before leaving on Friday,
simply throwing in al the ideas that came through my head. My first guess
turned out not to be so bad since this was indeed an aliasing problem.

In any case Samuel's code is not even 64 bit clean, the parameters for
st_le32 should never be long (64 bit on PPC64 and other 64 bit archs) in
the first place, but IMO something like int, or even u32 or s32 to stress
that you are accessing a 32 bit quantity.

I'm not a language lawyer by any stretch of the imagination but I believe
that the compiler has the right to reorder the accesses in the
-fstrict-aliasing case.

This said different distributions may ship different default options for
the compiler, either by tweaking the source code or the default spec file
IIRC, so checking some Debian's versions without specifying which
compiler flags were in effect does not mean much.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
