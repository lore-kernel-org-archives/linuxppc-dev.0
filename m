Date: Sat, 17 Nov 2001 11:47:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011117114724.H12763@zax>
References: <20011116164625.K673@zax> <3BF542D4.10706@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BF542D4.10706@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 11:46:12AM -0500, Dan Malek wrote:
> David Gibson wrote:
>
>
> >Thoughts?
>
> For some reason, the 4xx "structure" wasn't started correctly and
> has taken a weird path.  I've discussed this with a few folks that
> have asked about it.  Unfortunately, I've been working on a variety
> of 4xx boards just to get them to work and haven't been able to
> spend time sorting this out.
>
> I don't have a response to your specific question, but in general
> we have messed up the 4xx processor/board configuration.  This starts
> all of the way from the include files and I'm sure exists in other
> source files.  The problem I have with 4xx is we conceptually start with a
> processor type, and then try to determine what board we have.  If you
> use the 8xx as a model, it is done the other way around.  You first
> start with some architecture common things, then do the board, then
> let the board determine further unique processor or I/O configuration
> details.  Other platforms seem to do something similar.
>
> We need to start right at the top.  The ibm4xx.h file should include
> the properly configured board description file, then that file should
> include the proper processor type.  The kernel initialization should
> do the same.
>
> Specific to your question, I guess you are proposing to have a bunch
> of platform_init functions, one for each board, then have them call generic
> 4xx functions if necessary.  Makes sense.
>
> Who is going to restructure this and when is it going to be done :-)?
> I have a big mess of STB and other 4xx stuff to check in, and it
> doesn't fit anywhere right now (but is closer to the current model).

I'm offering...  As far as I can see the sanest (i.e. least gratuitous
breakage) way to do it is as follows:  create a new ppc4xx.c which
will probably have a lot of code copied out of ppc4xx_setup.c, migrate
one or two boards (probably ep405 and walnut, because I have access)
over to have their own platform_init() calling code in ppc4xx.c.
Gradually move each of the other 4xx machines over to the new scheme
and finally remove ppc4xx_setup.c

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
