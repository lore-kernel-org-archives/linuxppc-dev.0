Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f11.bay110.hotmail.com [65.54.229.21])
	by ozlabs.org (Postfix) with ESMTP id 058DF67BBD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Jun 2006 23:52:54 +1000 (EST)
Message-ID: <BAY110-F11CA5067CA16CB9E95E997B28B0@phx.gbl>
In-Reply-To: <200606081536.15145.arnd.bergmann@de.ibm.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: arnd.bergmann@de.ibm.com
Subject: Re: a problem of kernel-module version mismatch.
Date: Thu, 08 Jun 2006 13:52:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your telling first.

>The easiest way is usually to put the driver in your source tree
>and compile everything together. That also makes it easier to
>distribute the complete source tree to your users.

Sorry that I am a novice in Linux. I don't know how can I put the driver in 
my source tree and compile everything together. It looks like that there is 
no option in the menuconfig to choose a specially customed peripheral. So I 
think I only can include the customed peripheral as a module. Could you 
please say in a detail on how to do that? 


> > insmod: unresolved symbol XIo_In32
> > insmod: unresolved symbol XIO_Out32
>
>that looks like part of your module is missing. Try to find where thses
>functions are defined in there and why that isn't compiled.

It's very strange because I have checked the source. In the header file of 
xio.h, there are the following sentences,

/************************** Function Prototypes 
******************************/

/* The following functions allow the software to be transportable across
 * processors which may use memory mapped I/O or I/O which is mapped into a
 * seperate address space such as X86.  The functions are better suited for
 * debugging and are therefore the default implementation. Macros can 
instead
 * be used if USE_IO_MACROS is defined.
 */
#ifndef USE_IO_MACROS

/* Functions */
Xuint8 XIo_In8(XIo_Address InAddress);
Xuint16 XIo_In16(XIo_Address InAddress);
Xuint32 XIo_In32(XIo_Address InAddress);

void XIo_Out8(XIo_Address OutAddress, Xuint8 Value);
void XIo_Out16(XIo_Address OutAddress, Xuint16 Value);
void XIo_Out32(XIo_Address OutAddress, Xuint32 Value);

#else

/* The following macros allow optimized I/O operations for memory mapped 
I/O
 * Note that the SYNCHRONIZE_IO may be moved by the compiler during
 * optimization.
 */

#define XIo_In8(InputPtr)  (*(volatile Xuint8  *)(InputPtr)); 
SYNCHRONIZE_IO;
#define XIo_In16(InputPtr) (*(volatile Xuint16 *)(InputPtr)); 
SYNCHRONIZE_IO;
#define XIo_In32(InputPtr) (*(volatile Xuint32 *)(InputPtr)); 
SYNCHRONIZE_IO;

#define XIo_Out8(OutputPtr, Value)  \
    { (*(volatile Xuint8  *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
#define XIo_Out16(OutputPtr, Value) \
    { (*(volatile Xuint16 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
#define XIo_Out32(OutputPtr, Value) \
    { (*(volatile Xuint32 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }

#endif

I think these are the defination of XIo_In32 and XIo_Out32. Also, during 
the compilation, there is no error to complain that "XIo_In32 or XIo_Out32 
undeclared". 

More suggestions are appreciated. Thanks.

BR
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
