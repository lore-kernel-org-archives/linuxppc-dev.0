Return-Path: <paulus@ozlabs.org>
Date: Wed, 10 Oct 2012 09:23:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 10/20] powerpc/xmon: Factor out the oft-repeated setjmp
 logic
Message-ID: <20121009222358.GB21291@bloggs.ozlabs.ibm.com>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
 <1349792447-15714-10-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349792447-15714-10-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2012 at 01:20:37AM +1100, Michael Ellerman wrote:
> We have over 15 routines that implement essentially the same logic
> in terms of catching faults. Pull the logic out into two helper
> routines.
> 
> The pattern becomes:
> 
> 	if (start_bus_error_jump() == 0) {
> 		<do potentially faulting things>
> 
> 		end_bus_error_jump();
> 	} else {
> 		printf("Faulting thing faulted!\n");
> 	}

NAK...  think about how setjmp() works.  You can't return from the
function that called setjmp() while there is any possibility that
longjmp() could be called for the same jmp_buf.

Paul.
