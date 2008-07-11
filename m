Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6456ADDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 05:11:12 +1000 (EST)
Message-ID: <4877B04A.8090801@bucknell.edu>
Date: Fri, 11 Jul 2008 15:11:06 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: insmod: unresolved symbol XIo_In32/XIo_Out32
References: <48776D93.5080504@bucknell.edu>
	<20080711183117.GD15321@secretlab.ca>
In-Reply-To: <20080711183117.GD15321@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your reply! I am new to creating loadable kernel modules, so 
I hope you do not mind some more questions... How can I get the XIo_* 
helper routines to compile into the kernel or export them with 
EXPORT_SYMBOL( )? In my c file (my driver file from which I create the 
object file), I made sure to include xio.h, which is where XIo_In32 and 
XIo_Out32 are defined (see below section from xio.h).


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
u8 XIo_In8(XIo_Address InAddress);
u16 XIo_In16(XIo_Address InAddress);
u32 XIo_In32(XIo_Address InAddress);

void XIo_Out8(XIo_Address OutAddress, u8 Value);
void XIo_Out16(XIo_Address OutAddress, u16 Value);
void XIo_Out32(XIo_Address OutAddress, u32 Value);

#else

/* The following macros allow optimized I/O operations for memory mapped I/O
 * Note that the SYNCHRONIZE_IO may be moved by the compiler during
 * optimization.
 */

#define XIo_In8(InputPtr)  (*(volatile u8  *)(InputPtr)); SYNCHRONIZE_IO;
#define XIo_In16(InputPtr) (*(volatile u16 *)(InputPtr)); SYNCHRONIZE_IO;
#define XIo_In32(InputPtr) (*(volatile u32 *)(InputPtr)); SYNCHRONIZE_IO;

#define XIo_Out8(OutputPtr, Value)  \
    { (*(volatile u8  *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
#define XIo_Out16(OutputPtr, Value) \
    { (*(volatile u16 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
#define XIo_Out32(OutputPtr, Value) \
    { (*(volatile u32 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }

#endif


I thought that, by including xio.h, XIo_In32 and XIo_Out32 would be 
taken care of, but that is probably a novice assumption of mine...


-Juliana


Grant Likely wrote:
> On Fri, Jul 11, 2008 at 10:26:27AM -0400, Juliana Su wrote:
>   
>> Hi,
>>
>> Is anybody familiar with the following error?
>>
>> insmod: unresolved symbol XIo_In32
>> insmod: unresolved symbol XIo_Out32
>>
>> I am trying to write a device driver for a Custom IP and get it to run  
>> on a Xilinx ML310's Linux OS. I am using Xilinx EDK 10.1 and MontaVista  
>> Linux version 2.4.20_mvl31-ml300. I ran into this error when trying to  
>> load my module into the kernel. When I try to load the module using  
>> insmod on the ".o" file, the module refuses to load and gives me the  
>> unresolved symbol error message. I actually stumbled upon an older  
>> posting from June 2006 on this mailing list that described a similar  
>> problem, but those suggestions did not help me. Maybe two years later,  
>> there are more ideas/suggestions/solutions to this problem?
>>     
>
> I can't help much with the 2.4 montavista kernel, but I can say that the
> error means that the XIo_* helper routines are either not compiled into
> the kernel or are not exported with EXPORT_SYMBOL().  The XIo_* routines
> are hooks used by Xilinx cross platform device drivers to make the
> actual accesses to hardware.  If they are not implemented, then you need
> to create them yourself.
>
> g.
>
>
>   
