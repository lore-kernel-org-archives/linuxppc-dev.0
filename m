Return-Path: <maynardj@us.ibm.com>
Message-ID: <45C4EA7D.4000709@us.ibm.com>
Date: Sat, 03 Feb 2007 14:03:09 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling
	Cell BE SPUs -- update
References: <45BE4ED0.5030808@us.ibm.com> <200701310752.48632.arnd@arndb.de>
	<45C36B21.60400@us.ibm.com> <200702030840.06270.arnd@arndb.de>
In-Reply-To: <200702030840.06270.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

>On Friday 02 February 2007 17:47, Maynard Johnson wrote:
>  
>
>>>We also want to be able to profile the context switch code itself, which
>>>means that we also need one event buffer associated with the kernel to
>>>collect events that for a zero context_id.
>>>      
>>>
>>The hardware design precludes tracing both SPU and PPU simultaneously.
>>
>>    
>>
>I mean the SPU-side part of the context switch code, which you can find
>in arch/powerpc/platforms/cell/spufs/spu_{save,restore}*.
>
>This code is the one that runs when context_id == 0 is passed to the
>callback.
>  
>
I presume you mean 'object_id'.  What you're asking for is a new 
requirement, and one which I don't believe is achievable in the current 
timeframe.  Since this is spufs code that's dynamicaly loaded into the 
SPU at runtime, the symbol information for this code is not accessible 
to the userspace post-processing tools.  It would require an altogether 
different mechanism to record samples along with necessary information, 
not to mention the changes required in the post-processing tools.  This 
will have to be a future enhancement.

-Maynard

>	Arnd <><
>  
>
