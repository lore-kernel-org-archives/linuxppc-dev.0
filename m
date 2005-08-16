Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17153.30822.529374.24144@cargo.ozlabs.ibm.com>
Date: Tue, 16 Aug 2005 15:23:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <200508160403.j7G43Hd29692@makai.watson.ibm.com>
References: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
	<473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
	<200508160403.j7G43Hd29692@makai.watson.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Edelsohn <dje@watson.ibm.com>, linuxppc64-dev@ozlabs.org
Subject: Re: CONFIG_FRAME_POINTER on ppc/ppc64? 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Edelsohn writes:

> Kumar> I'm assuming that's a guess.  The reason I ask that is my memory  
> Kumar> serves correctly r31 is used as the frame pointer if compiled that  
> Kumar> way.  Maybe some GCC expert can chime in.  I'll copy David Edelsohn  
> Kumar> and see if I get a response :)
> 
> 	I am missing some context here.  On both 32-bit PowerPC Linux
> (PowerPC SVR4) and 64-bit PowerPC Linux, GPR r31 is used as the frame
> pointer.  PowerPC does not have a dedicated frame pointer and the PowerPC
> ABI does not require an independent frame pointer in a function at all
> times, so it can be omitted by default.  If the frame pointer is not
> referenced for any unique needs, uses of the frame pointer are adjusted to
> reference the stack pointer.  GCC only retains the PowerPC frame pointer
> when dynamic stack allocation (alloca) is used within a function.
> -fomit-frame-pointer has no effect on PowerPC because it is enabled by
> default.

OK, my memory was at fault then.

The reason for having the kernel config option is that it is
impossible to get reliable stack traces on x86 without frame pointers.
On PPC, because the stack frames are always linked together, even if
you don't use a frame pointer, the frame pointer doesn't help in
getting stack traces.  Thus there is no point in having the kernel
config option.

Paul.
