Return-Path: <olof@lixom.net>
Date: Thu, 23 Mar 2006 16:49:26 -0600
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [patch 02/13] powerpc: add hvc backend for rtas
Message-ID: <20060323224925.GC5538@pb15.lixom.net>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323213217.GB5538@pb15.lixom.net>
	<200603232336.19683.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200603232336.19683.arnd@arndb.de>
From: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2006 at 11:36:19PM +0100, Arnd Bergmann wrote:
> Am Thursday 23 March 2006 22:32 schrieb Olof Johansson:
> > > +static inline int hvc_rtas_write_console(uint32_t vtermno, const char
> > > *buf, int count) +{
> > > +     int done;
> > > +
> > > +     /* if there is more than one character to be displayed, wait a bit */
> > > +     for (done = 0; done < count; done++) { 
> > > +             int result;
> > > +             result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
> > > +             if (result) 
> > > +                     break;
> >
> > Why introduce a scope-local variable just to check it?
> >                 if(rtas_call(...))   would be cleaner.
> 
> I don't like doing the important stuff inside of another expression,
> and I prefer conditions not to have side-effects.
> If nobody else has a strong opinion on it, I'd prefer to leave it.

Ok. It just looked silly to have the declaration/assignment/test and no
use of result outside of those three lines.

> BTW, who is the current maintainer of hvc_console? Ryan is working on
> glibc nowadays, right?

That's what I think IBM pays him to do, that's never stopped people from
maintaining other code in the past though. :-)


-Olof
