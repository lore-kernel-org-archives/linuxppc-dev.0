Return-Path: <maynardj@us.ibm.com>
Message-ID: <45D62583.5080701@us.ibm.com>
Date: Fri, 16 Feb 2007 15:43:31 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] CELL Oprofile SPU profiling updated
	patch
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<200702151537.51202.arnd@arndb.de> <45D4FBB0.7090109@us.ibm.com>
	<200702161814.26855.arnd@arndb.de>
In-Reply-To: <200702161814.26855.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Carl Love <cel@us.ibm.com>, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> On Friday 16 February 2007 01:32, Maynard Johnson wrote:
> 
>>config OPROFILE_CELL
>>        bool "OProfile for Cell Broadband Engine"
>>        depends on OPROFILE && SPU_FS
>>        default y if ((SPU_FS = y && OPROFILE = y) || (SPU_FS = m && 
>>OPROFILE = m))
>>        help
>>          Profiling of Cell BE SPUs requires special support enabled
>>          by this option.  Both SPU_FS and OPROFILE options must be
>>          set 'y' or both be set 'm'.
>>=============
>>
>>Can anyone see a problem with any of this . . . or perhaps a suggestion 
>>of a better way?
> 
> 
> The text suggests it doesn't allow SPU_FS=y with OPROFILE=m, which I think
> should be allowed. 
Right, good catch.  I'll add another OR to the 'default y' and correct 
the text.

 > I also don't see any place in the code where you actually
> use CONFIG_OPROFILE_CELL.
As I mentioned, I will use CONFIG_OPROFILE_CELL in the 
arch/powerpc/oprofile/Makefile as follows:
      oprofile-$(CONFIG_OPROFILE_CELL) += op_model_cell.o \
               cell/spu_profiler.o cell/vma_map.o cell/spu_task_sync.o

> 
> Ideally, you should be able to have an oprofile_spu module that can be
> loaded after spufs.ko and oprofile.ko. In that case you only need
> 
> config OPROFILE_SPU
> 	depends on OPROFILE && SPU_FS
> 	default y
> 
> and it will automatically build oprofile_spu as a module if one of the two
> is a module and won't build it if one of them is disabled.
Hmmm . . . I guess that would entail splitting out the SPU-related stuff 
from op_model_cell.c into a new file.  Maybe more -- that's just what 
comes to mind right now.  Could be very tricky, and I wonder if it's 
worth the bother.
> 
> 	Arnd <><
