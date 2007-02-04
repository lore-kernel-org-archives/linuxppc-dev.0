Return-Path: <maynardj@us.ibm.com>
Message-ID: <45C613DB.6000301@us.ibm.com>
Date: Sun, 04 Feb 2007 11:11:55 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling
	Cell BE SPUs -- update
References: <45BE4ED0.5030808@us.ibm.com> <200702030840.06270.arnd@arndb.de>
	<45C4EA7D.4000709@us.ibm.com> <200702040342.39626.arnd@arndb.de>
In-Reply-To: <200702040342.39626.arnd@arndb.de>
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

>On Saturday 03 February 2007 21:03, Maynard Johnson wrote:
>  
>
>>I presume you mean 'object_id'. 
>>    
>>
>
>Right, sorry for the confusion.
>
>  
>
>>What you're asking for is a new  
>>requirement, and one which I don't believe is achievable in the current 
>>timeframe.  Since this is spufs code that's dynamicaly loaded into the 
>>SPU at runtime, the symbol information for this code is not accessible 
>>to the userspace post-processing tools.
>>    
>>
>
>We can always fix the user space tool later, but it is important to
>get at least the kernel interface right, so we can add the functionality
>later without breaking new user space on old kernels or vice versa.
>  
>
There's no obvious solution to this problem, so it's going to take some 
design effort to come up with a solution.  We can work on the problem, 
but I don't think we can allow it to get in the way of getting our 
currently proposed SPU profiling functionality into the kernel.

>  
>
>>It would require an altogether  
>>different mechanism to record samples along with necessary information, 
>>not to mention the changes required in the post-processing tools.  This 
>>will have to be a future enhancement.
>>    
>>
>
>So what do you do with the samples for object_id == 0? I would expect them
>to be simply added to the sample buffer for the kernel, which is sort
>of special in oprofile anyway.
>  
>
There is no sample buffer for the kernel in SPU profiling.  When 
OProfile gets notified of an SPU task switching out (object_if == 0), we 
stop recording samples for the corresponding SPU.  If SPUFs sends the 
notification after the spu_save operation, we still would be collecting 
samples during that time; however, since the VMAs of these samples would 
not map to any fileoffset in the SPU binary that's executing, our 
current implementation throws them away.  We could change that behavior 
and record them in the samples buffer as "anonymous samples".  Not sure 
it that would help too much, as you wouldn't be able to distinguish 
between spu_save samples and samples from generated stubs that are 
executing from the stack.

-Maynard

>	Arnd <><
>  
>
