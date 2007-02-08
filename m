Return-Path: <maynardj@us.ibm.com>
Message-ID: <45CB3BDF.4080408@us.ibm.com>
Date: Thu, 08 Feb 2007 09:03:59 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] CELL Oprofile SPU profiling updated
	patch
References: <1170721711.5204.44.camel@dyn9047021078.beaverton.ibm.com>
	<1170802957.5204.56.camel@dyn9047021078.beaverton.ibm.com>
	<45C9F317.9010700@us.ibm.com>
	<1170888537.7831.14.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1170888537.7831.14.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael,
Thanks very much for the advice.  Both issues have been solved now, with 
your help.

-Maynard

Michael Ellerman wrote:

>On Wed, 2007-02-07 at 09:41 -0600, Maynard Johnson wrote:
>  
>
>>Carl Love wrote:
>>
>>    
>>
>>>Subject: Add support to OProfile for profiling Cell BE SPUs
>>>
>>>From: Maynard Johnson <maynardj@us.ibm.com>
>>>
>>>This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
>>>to add in the SPU profiling capabilities.  In addition, a 'cell' subdirectory
>>>was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
>>>code.
>>>
>>>Signed-off-by: Carl Love <carll@us.ibm.com>
>>>Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
>>>
>>>Index: linux-2.6.20-rc1/arch/powerpc/configs/cell_defconfig
>>> 
>>>
>>>      
>>>
>>I've discovered more problems with the kref handling for the cached_info 
>>object that we store in the spu_context.  :-(
>>
>>When the OProfile module initially determines that no cached_info yet 
>>exists for a given spu_context, it creates the cached_info, inits the 
>>cached_info's kref (which increments the refcount) and does a kref_get 
>>(for SPUFS' ref) before passing the cached_info reference off to SUPFS 
>>to store into the spu_context.  When OProfile shuts down or the SPU job 
>>ends, OProfile gives up its ref to the cached_info with kref_put.  Then 
>>when SPUFS destroys the spu_context, it also gives up its ref.  HOWEVER 
>>. . . . If OProfile shuts down while the SPU job is still active _and_ 
>>_then_ is restarted while the job is still active, OProfile will find 
>>that the cached_info exists for the given spu_context, so it won't go 
>>through the process of creating it and doing kref_init on the kref.  
>>Under this scenario, OProfile does not own a ref of its own to the 
>>cached_info, and should not be doing a kref_put when done using the 
>>cached_info -- but it does, and so does SPUFS when the spu_context is 
>>destroyed.  The end result (with the code as currently written) is that 
>>an extra kref_put is done when the refcount is already down to zero.  To 
>>fix this, OProfile needs to detect when it finds an existing cached_info 
>>already stored in the spu_context.  Then, instead of creating a new one, 
>>it sets a reminder flag to be used later when it's done using the cached 
>>info to indicate whether or not it needs to call kref_put.
>>    
>>
>
>I think all you want to do is when oprofile finds the cached_info
>already existing, it does a kref_get(). After all it doesn't have a
>reference to it, so before it starts using it it must inc the ref count.
>
>  
>
>>Unfortunately, there's another problem (one that should have been 
>>obvious to me).  The cached_info's kref "release" function is 
>>destroy_cached_info(), defined in the OProfile module.  If the OProfile 
>>module is unloaded when SPUFS destroys the spu_context and calls 
>>kref_put on the cached_info's kref -- KABOOM!  The destroy_cached_info 
>>function (the second arg to kref_put) is not in memory, so we get a 
>>paging fault.  I see a couple options to solve this:
>>    1) Don't store the cached_info in the spu_context.  Basically, go 
>>back to the simplistic model of creating/deleting the cached_info on 
>>every SPU task activation/deactivation.
>>    2)  If there's some way to do this, force the OProfile module to 
>>stay loaded until SPUFS has destroyed its last spu_context that holds a 
>>cached_info object.
>>    
>>
>
>There is a mechanism for that, you just have each cached_info inc the
>module's refcount.
>
>Another option would be to have a mapping, in the oprofile code, from
>spu_contexts to cached_infos, ie. a hash table or something.
>
>cheers
>
>  
>
