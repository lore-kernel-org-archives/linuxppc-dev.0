Return-Path: <maynardj@us.ibm.com>
Message-ID: <45D4FBB0.7090109@us.ibm.com>
Date: Thu, 15 Feb 2007 18:32:48 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] CELL Oprofile SPU profiling updated
	patch
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<200702151537.51202.arnd@arndb.de>
In-Reply-To: <200702151537.51202.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Carl Love <cel@us.ibm.com>, cbe-oss-dev@ozlabs.org,
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

>On Thursday 15 February 2007 00:52, Carl Love wrote:
>
>
>  
>
>>--- linux-2.6.20-rc1.orig/arch/powerpc/oprofile/Kconfig	2007-01-18 16:43:14.000000000 -0600
>>+++ linux-2.6.20-rc1/arch/powerpc/oprofile/Kconfig	2007-02-13 19:04:46.271028904 -0600
>>@@ -7,7 +7,8 @@
>> 
>> config OPROFILE
>> 	tristate "OProfile system profiling (EXPERIMENTAL)"
>>-	depends on PROFILING
>>+	default m
>>+	depends on SPU_FS && PROFILING
>> 	help
>> 	  OProfile is a profiling system capable of profiling the
>> 	  whole system, include the kernel, kernel modules, libraries,
>>    
>>
>
>Milton already commented on this being wrong. I think what you want
>is
>	depends on PROFILING && (SPU_FS = n || SPU_FS)
>
>that should make sure that when SPU_FS=y that OPROFILE can not be 'm'.
>  
>
The above suggestion would not work if SPU_FS is not defined, since the 
entire config option is ignored if an undefined symbol is used.  So, 
here's what I propose instead: 
    - Leave the existing 'config OPROFILE' unchanged from its current 
form in mainline (shown below)
    - Add the new 'config OPROFILE_CELL' (shown below)
    - In arch/powerpc/configs/cell-defconfig, set CONFIG_OPROFILE=m, to 
correspond to setting for CONFIG_SPU_FS
    - In arch/powerpc/oprofile/Makefile, do the following:
                oprofile-$(CONFIG_OPROFILE_CELL) += op_model_cell.o \
                                                            
cell/spu_profiler.o cell/vma_map.o cell/spu_task_sync.o

===========
config OPROFILE
        tristate "OProfile system profiling (EXPERIMENTAL)"
        depends on PROFILING
        help
          OProfile is a profiling system capable of profiling the
          whole system, include the kernel, kernel modules, libraries,
          and applications.

          If unsure, say N.

config OPROFILE_CELL
        bool "OProfile for Cell Broadband Engine"
        depends on OPROFILE && SPU_FS
        default y if ((SPU_FS = y && OPROFILE = y) || (SPU_FS = m && 
OPROFILE = m))
        help
          Profiling of Cell BE SPUs requires special support enabled
          by this option.  Both SPU_FS and OPROFILE options must be
          set 'y' or both be set 'm'.
=============

Can anyone see a problem with any of this . . . or perhaps a suggestion 
of a better way?

Thanks.

-Maynard
