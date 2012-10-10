Return-Path: <michael@ellerman.id.au>
Message-ID: <1349830791.14090.1.camel@concordia>
Subject: Re: [PATCH 10/20] powerpc/xmon: Factor out the oft-repeated setjmp
 logic
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Date: Wed, 10 Oct 2012 11:59:51 +1100
In-Reply-To: <20121009222358.GB21291@bloggs.ozlabs.ibm.com>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
 <1349792447-15714-10-git-send-email-michael@ellerman.id.au>
 <20121009222358.GB21291@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-10-10 at 09:23 +1100, Paul Mackerras wrote:
> On Wed, Oct 10, 2012 at 01:20:37AM +1100, Michael Ellerman wrote:
> > We have over 15 routines that implement essentially the same logic
> > in terms of catching faults. Pull the logic out into two helper
> > routines.
> > 
> > The pattern becomes:
> > 
> > 	if (start_bus_error_jump() == 0) {
> > 		<do potentially faulting things>
> > 
> > 		end_bus_error_jump();
> > 	} else {
> > 		printf("Faulting thing faulted!\n");
> > 	}
> 
> NAK...  think about how setjmp() works.  You can't return from the
> function that called setjmp() while there is any possibility that
> longjmp() could be called for the same jmp_buf.

Sigh, yeah. Somehow I'd convinced myself that it worked in this case,
but after a night's sleep I'm not sure what my logic was.

cheers
