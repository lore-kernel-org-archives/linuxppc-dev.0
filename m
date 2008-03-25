Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Mar 2008 10:59:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: dtc: Simplify error handling for unparseable input
Message-ID: <20080325235936.GH8281@localhost.localdomain>
References: <20080324034424.GC29985@localhost.localdomain>
	<20080324173641.GA22159@loki.buserror.net>
	<20080325012805.GA1227@localhost.localdomain>
	<20080325143619.GB13187@ld0162-tx32.am.freescale.net>
	<20080325212127.GA8281@localhost.localdomain>
	<47E9783F.4@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47E9783F.4@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 05:10:07PM -0500, Scott Wood wrote:
> David Gibson wrote:
>> On Tue, Mar 25, 2008 at 09:36:19AM -0500, Scott Wood wrote:
>>> On Tue, Mar 25, 2008 at 12:28:05PM +1100, David Gibson wrote:
>>>> On Mon, Mar 24, 2008 at 12:36:41PM -0500, Scott Wood wrote:
>>>>> If you remove this, there'll be no way to indicate semantic errors 
>>>>> other
>>>>> than die() (the NULL approaches are no good, since they inhibit 
>>>>> recovery),
>>>>> which is suboptimal if the error is not immediately fatal.
>>>> But everything is immediately fatal.  When we have a *real* example of
>>>> something that's not, we can restore an error code.
>>> Failed binary includes are not immediately fatal.
>> And is there any advantage to having them not immediately fatal?
>
> It's generally nice to the user if you can report as many bugs as you can 
> rather than fail on the first one.

Oh.. and this patch doesn't actually preclude that.  We still have the
treesource_error variable and can report errors that way during the
parse.  The die() just comes at the end of dt_from_source(), instead
of in main().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
