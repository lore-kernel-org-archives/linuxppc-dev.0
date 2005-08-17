Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050805174705.731ffa05.sfr@canb.auug.org.au>
References: <20050805174705.731ffa05.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8DC89F16-0704-484A-9216-D94F3EE90CA4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 00:39:27 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 5, 2005, at 2:47 AM, Stephen Rothwell wrote:

> On Tue, 2 Aug 2005 19:10:56 -0400 Dan Malek <dan@embeddededge.com>
> wrote:
>
>>
>> On Aug 2, 2005, at 6:59 PM, Jon Loeliger wrote:
>>
>>
>>> ..... A stub is left
>>> in asm-ppc and asm-ppc64 pointing to the unified files.
>>>
>>
>> Why bother?  You may as well change all of the source
>> files, too, or else that will never get done :-)
>>
>
> You actually don't need to modify (m)any source files.
>
> Here is an alternative approach.  These patches depend on Olaf's
> boot code cleanup for ppc64 (or similar).  Do the following:
>
> cd linux/include
> mkdir asm-powerpc
> cd asm-ppc
> for i in *
> do
>     [ -e ../asm-ppc64/$i ] || mv $i ../asm-powerpc/$i
> done
> cd ../asm-ppc64
> for i in *
> do
>     [ -e ../asm-ppc/$i ] || mv $i ../asm-powerpc/$i
> done
> for i in *
> do
>     [ -f ../asm-ppc64/$i ] && cmp -s $i ../asm-ppc64/$i &&
>         mv $i ../asm-powerpc/$i && rm ../asm-ppc64/$i
> done
>
> Then apply the patch below and the patch in the following email.
>
> I have built this kernel for ppc (defconfig), ppc64 (iSeries, pSeries
> and
> pmac).

I think conceptual this is ok, just now how we should go about it.   
There is a fair amount of cruft in asm-ppc and I think we should be  
more selective and iterative about what we move into arch-powerpc.   
For example, there is a fair amount of headers that are specific to  
platform support code.  It's probably the case that alot of that  
should move into the proper platform directory.

If we just copy those files into arch-powerpc I think we will never  
get around to moving them to the proper location in the future.

We've been doing some analysis (well, Jon and Becky have) and I think  
there is some low hanging fruit that we can start with:
1. files that are identical are almost identical
2. files that are not overly ppc specific and seem straight forward  
to merge
3. low hanging ppc specific files
4. identify files that we clearly want to wait on (for example  
anything platform related)

This will hopefully leave us with the painful list of things that we  
can start identifying and discussion how we want to go about solving  
things (like what should "current" by defined as :)

Now your makefile hackery seems perfectly reasonable if we want to go  
that way instead of explicitly including files like Jon's original  
patch does.  I dont have any strong feelings one way or the other.  
The makefile hackery seems less intrusive since we dont have to  
duplicate files in both places.  I'd like to see if we can come to  
some consensus on this since it directly impacts future patches that  
we are working on to merge more files and move them into include/asm- 
powerpc/

- kumar
