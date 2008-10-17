Return-Path: <amodra@bigpond.net.au>
Received: from nschwmtas05p.mx.bigpond.com (nschwmtas05p.mx.bigpond.com
	[61.9.189.149]) by ozlabs.org (Postfix) with ESMTP id CCB50DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:59:31 +1100 (EST)
Date: Sat, 18 Oct 2008 08:29:30 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: munroesj@us.ibm.com, Tom.Bucken@sybase.com
Subject: Re: [Fwd: finding fuction names]
Message-ID: <20081017215930.GC9946@bubble.grove.modra.org>
References: <1224266789.28869.441.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224266789.28869.441.camel@spokane1.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, vicknair@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 01:06:29PM -0500, Steven Munroe wrote:
> Alan can you respond to this. This XLC but I suspect it is common with
> GCC and the PPC64 ABI.

Indeed, this is due to the ABI.

Content-Description: Forwarded message - finding fuction names
> To: linuxppc-dev@ozlabs.org
> Subject: finding fuction names
> From: Tom.Bucken@sybase.com
> Date: Fri, 17 Oct 2008 11:07:11 -0400
> Cc: vicknair@us.ibm.com
> 
> /*
> 
> Hi,
> 
>    We have code in our product that produces stacktraces.  Part of the
> implementation of this code runs nm to find all of the entry points in 
> our libraries.
> 
>    Using the 7.0 version of this compiler to compile the simple code below
> 
> xlC_r -c -q64 tt.cxx 
>  nm -C tt.o
>                  U __IBMCPlusPlusExceptionV1
> 0000000000000000 D test()
> 0000000000000000 T .test()
> 
>    Using the 8.0 version of this compiler to compile the simple code below
> 
> xlC_r -c -q64 tt.cxx 
> nm -C tt.o
>                  U __IBMCPlusPlusExceptionV2
> 0000000000000000 D test()
> 
> 
>     We grep the nm output for text symbols which are labeled with 'T'.
> Not all function names are not labeled as text in objects compiled with 
> 8.0.
> Is there another way to find all of the fuction names in a library or
> a compiler switch that will put all fuctions into the text segment ?

The PowerPC64 ABI uses function descriptors, stored in the .opd
section, a data section.  The address of a function is that of its
descriptor, which nm correctly shows as a 'D' type symbol.  A symbol
marking the start of the function code is unnecessary since you can
find that from the descriptor, so later compilers omit the "dot"
symbol.

nm --synthetic will look up the descriptor for you and display fake
"dot" symbols marking the start of each function's code.

-- 
Alan Modra
Australia Development Lab, IBM
