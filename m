Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f15.bay110.hotmail.com [65.54.229.25])
	by ozlabs.org (Postfix) with ESMTP id 6460167BF0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 01:54:03 +1000 (EST)
Message-ID: <BAY110-F15241A28F638236FD2E3E4B28B0@phx.gbl>
In-Reply-To: <200606081725.37621.arnd.bergmann@de.ibm.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: arnd.bergmann@de.ibm.com
Subject: Re: a problem of kernel-module version mismatch.
Date: Thu, 08 Jun 2006 15:54:00 +0000
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

Dear Arnd,
Thanks a lot for your help. Now I have solved the problem of version 
mismatch. The reason is I haven't include the sentence of "#define MODULE". 


However the problem of unresolved symbol XIo_In32 and XIo_Out32 still 
exists. I will try to solve it following your suggestion. If any question, 
I will ask you again. Thanks a lot for your help.

Regards
Ming


>From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>To: "Ming Liu" <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: a problem of kernel-module version mismatch.
>Date: Thu, 8 Jun 2006 17:25:37 +0200
>
>On Thursday 08 June 2006 15:52, Ming Liu wrote:
> > >The easiest way is usually to put the driver in your source tree
> > >and compile everything together. That also makes it easier to
> > >distribute the complete source tree to your users.
> >
> > Sorry that I am a novice in Linux. I don't know how can I put the 
driver in
> > my source tree and compile everything together. It looks like that 
there is
> > no option in the menuconfig to choose a specially customed peripheral. 
So I
> > think I only can include the customed peripheral as a module. Could you
> > please say in a detail on how to do that?
>
>The most simple way would be to put it into linux/drivers/misc and add it
>to the Makefile in there.
>
> > > > insmod: unresolved symbol XIo_In32
> > > > insmod: unresolved symbol XIO_Out32
> > >
> > >that looks like part of your module is missing. Try to find where 
thses
> > >functions are defined in there and why that isn't compiled.
> >
> > It's very strange because I have checked the source. In the header file 
of
> > xio.h, there are the following sentences,
> >
> > /************************** Function Prototypes
> > ******************************/
> >
> > /* The following functions allow the software to be transportable 
across
> > ? processors which may use memory mapped I/O or I/O which is mapped 
into a
> > ? seperate address space such as X86. 燭he functions are better suited 
for
> > ? debugging and are therefore the default implementation. Macros can
> > instead
> > ? be used if USE_IO_MACROS is defined.
> > ?/
> > #ifndef USE_IO_MACROS
>
>The comment tells you that you either need to implement these functions
>youself or #define USE_IO_MACROS in the code before this.
>
> > /* Functions */
> > Xuint8 XIo_In8(XIo_Address InAddress);
> > Xuint16 XIo_In16(XIo_Address InAddress);
> > Xuint32 XIo_In32(XIo_Address InAddress);
> >
> > void XIo_Out8(XIo_Address OutAddress, Xuint8 Value);
> > void XIo_Out16(XIo_Address OutAddress, Xuint16 Value);
> > void XIo_Out32(XIo_Address OutAddress, Xuint32 Value);
> >
> > #else
> >
> > /* The following macros allow optimized I/O operations for memory 
mapped
> > I/O
> > ? Note that the SYNCHRONIZE_IO may be moved by the compiler during
> > ? optimization.
> > ?/
> >
> > #define XIo_In8(InputPtr) ?*(volatile Xuint8 ?)(InputPtr));
> > SYNCHRONIZE_IO;
> > #define XIo_In16(InputPtr) (*(volatile Xuint16 *)(InputPtr));
> > SYNCHRONIZE_IO;
> > #define XIo_In32(InputPtr) (*(volatile Xuint32 *)(InputPtr));
> > SYNCHRONIZE_IO;
> >
> > #define XIo_Out8(OutputPtr, Value) 燶
> > ??{ (*(volatile Xuint8 ?)(OutputPtr) = Value); SYNCHRONIZE_IO; }
> > #define XIo_Out16(OutputPtr, Value) \
> > ??{ (*(volatile Xuint16 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
> > #define XIo_Out32(OutputPtr, Value) \
> > ??{ (*(volatile Xuint32 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
> >
> > #endif
>
>These macros are probably broken on powerpc.
>
> >
> > I think these are the defination of XIo_In32 and XIo_Out32. Also, 
during
> > the compilation, there is no error to complain that "XIo_In32 or 
XIo_Out32
> > undeclared".
> >
>
>I would suggest you remove that part of the header file completely, and
>replace it with:
>
>#define XIo_In32(p) in_le32(x)
>#define XIO_Out32(p,v) out_le32(p, v)
>
>	Arnd <><

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
