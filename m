To: Dan Malek <dan@netx4.com>
Cc: reekes@kerbango.com, linuxppc-embedded@lists.linuxppc.org,
        nick@kerbango.com
Subject: Re: does soft-float work?
References: <382B39C8.EF61D039@kerbango.com> <382B46D4.E10355E1@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 19 Nov 1999 18:06:53 +0100
In-Reply-To: Dan Malek's message of "Thu, 11 Nov 1999 17:44:36 -0500"
Message-ID: <kfyg0y24dhu.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> I also remember speaking to someone that found a varargs
> and software floating point combination bug.....let me
> try and track that down.

Well, I know of one such bug in gcc:
I built gcc with --nfp/--without-fpu (don't remember what gcc calls
it) and --with-cpu=860. This causes the compiler to generate
software floating point code by default (in fact it doesn't seem to
be able to generate FPU instructions even with -mhard-float).
However, it does _not_ cause the specs file to define -D_SOFT_FLOAT
for the pre-processor by default.

This means that the caller passes fp arguments in soft-float syntax,
while the va_* macros tries to read them out in hard-float syntax.

The same problem may very well occur if you pass the compiler
-mcpu=860 but not -msoft-float. I'm not sure how to fix this
properly - here I just changed the specs file as I never compile
for PPCs with FPU.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
