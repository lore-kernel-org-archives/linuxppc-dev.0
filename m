Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17534.7026.169023.420733@cargo.ozlabs.ibm.com>
Date: Thu, 1 Jun 2006 08:40:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Collecting hypervisor call stats
In-Reply-To: <20060531204144.GA7909@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> We would like to add code that gathers statistics about hypervisor calls.
> It would keep track of things like # of calls made for each opcode as well
> as time spent processing the calls.
> 
> The 'obvious' place to gather such statistics would be from within the
> routines making hcalls in hvCall.S.  Once thing that I have noticed is
> the following comment at the beginning hvCall.S:
> 
>  * NOTE: this file will go away when we move to inline this work.

I suspect that's a very old comment. :)

> So, it appears someone thought/thinks these routines should be inlined.  
> I assume this is for performance reasons?  If this is the case, then I
> suspect gathering of statistics (which would introduce overhead) would
> meet resistance?
> 
> Comments about the feasibility of adding such statistic gathering code
> would be appreciated.

I think that gathering those statistics would be useful.  I suggest
you use a per-cpu array for them, to reduce the performance impact.

Paul.
