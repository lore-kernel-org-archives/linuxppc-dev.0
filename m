Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070329020744.GB16270@localhost.localdomain>
References: <1174681120.32390.82.camel@ld0161-tx32>
	<20070328062159.GJ27401@localhost.localdomain>
	<1175102216.32390.220.camel@ld0161-tx32>
	<20070329020744.GB16270@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1175184168.32390.275.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 29 Mar 2007 11:02:48 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 21:07, David Gibson wrote:

> > > > +<INCLUDE>\"[^"\n]*\"	{
> > > > +			yytext[strlen(yytext) - 1] = 0;
> > > > +			if (!push_input_file(yytext + 1)) {
> > > > +				/* Some unrecoverable error.*/
> > > 
> > > Should be some kind of error message here.
> > 
> > Hrm.  Yeah.

So I looked, and all the return 0 cases issue specific
errors before returning, so that happens already.


> > Well, it has to come early so that the type is seen
> > prior to the builtin version.  But it could be reorganized
> > a bit, I suppose.  I was just angling on not cluttering
> > up the lexer proper.
> 
> Err... builtin version of what?

I forgot I already separated out the YYLTYPE definition
to handle this issue.  Never mind; it's kosher already.


> > Note some people are seeing some compilation problems
> > around the struct field "filenum" that I introduced.
> > I don't see that problem, but a coworker here does,
> > so I am now able to reproduce the issue and am working
> > on a fix. Sorry.
> 
> Hrm.  Which struct did you add the field to?

And the patch I applied yesterday fixed this YYLTYPE up too.

jdl
