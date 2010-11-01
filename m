Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 60C19B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 01:41:53 +1100 (EST)
Subject: Re: [PATCH 04/39] arch/powerpc: Update WARN uses
From: Joe Perches <joe@perches.com>
To: michael@ellerman.id.au
In-Reply-To: <1288609334.10671.4.camel@concordia>
References: <cover.1288471897.git.joe@perches.com>
	<c6c46b5924e1cc9720d3ad76e6c11e982bd661e5.1288471898.git.joe@perches.com>
	<1288609334.10671.4.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Nov 2010 07:41:49 -0700
Message-ID: <1288622509.366.237.camel@Joe-Laptop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-11-01 at 22:02 +1100, Michael Ellerman wrote:
> On Sat, 2010-10-30 at 14:08 -0700, Joe Perches wrote:
> > Coalesce long formats.
> > Align arguments.
> > Add missing newlines.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  arch/powerpc/kernel/hw_breakpoint.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> > index 5ecd040..d7343a7 100644
> > --- a/arch/powerpc/kernel/hw_breakpoint.c
> > +++ b/arch/powerpc/kernel/hw_breakpoint.c
> > @@ -270,8 +270,8 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
> >  	 * message to let the user know about it.
> >  	 */
> >  	if (!stepped) {
> > -		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at "
> > -			"0x%lx will be disabled.", info->address);
> > +		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at 0x%lx will be disabled.\n",
> > +		     info->address);
> 
> That appears to have done nothing other than turn a short line into one
> that is now > 80 columns.

Added '\n'.

The series was done for a few reasons:

o to add missing newlines at the end of messages as was done here
o to convert a couple of misuses of WARN(msg) to WARN(1, msg)
o to remove KERN_ prefixes from WARN(test, KERN_<level> msg)

>  Is that the latest fad?

Pretty much.  Format coalescing is generally preferred for grep.
Some consider it churn.

cheers, Joe
