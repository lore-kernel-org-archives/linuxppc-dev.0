Return-Path: <jchapman@katalix.com>
Received: from ptb-relay02.plus.net (ptb-relay02.plus.net [212.159.14.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 374F467A65
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 03:47:46 +1100 (EST)
Message-ID: <423711A8.3060104@katalix.com>
Date: Tue, 15 Mar 2005 16:47:36 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B11@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B11@exnet.3il.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Interrupts handling?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Garcia Jérémie wrote:

> Hi everybody,
> 
> Although I am a newbie in linux powerPC development, I am in charge
> of a related project.
> 
> The project is the following: I have to move a vXWorks application
> to a Linux (montavista) environnment with a 405EP
> processor. Unfotunately, my knowledges are very limited in BSP and
> with all the board specific functions (device drivers too...).
> 
> In my application, we assign IRQ only at its early beginning and we
> never change them after. 

What sort of device does your application need to talk to?

You need to separate your "application" into kernel and userspace parts.
Hooking up interrupt handlers would be done by a device driver. 
Depending on what your device is, there might already be a Linux device 
driver for it.

> Furthermore, this application uses an OS
> API layer in order to make it independant of the OS used. For
> exemple we encapsulate all the OS calls in this layer ; as that we
> theoretically only have to change this file to use another OS.

Nice theory but it's unlikely to cope with the paradigm shift of moving 
from vxworks to Linux. You'll need to change your application to use 
Unix system calls to access the device rather than making direct BSP 
calls that it does today.

> To
> finish, we use POSIX pthreads to get an equivalent of vxWorks tasks.

The pthread code should be straightforward to port into a Linux 
userspace application. However, if it touches the device (messes with 
irqs etc) then bigger changes might be needed. I've seen some vxworks 
code that combines device driver and application functions in one big 
blob. Linux enforces separation.

> Giving that, here are my questions:
> 
> - is it possible to write a driver in this "file" (OS API Layer) or
>   wherever I want?

I don't really understand the question. Linux device drivers live in the 
kernel. They may be statically linked in the kernel or they may be 
dynamically loaded on-demand by the kernel. Your userspace pthread 
application would be another separately linked application. You can't 
call kernel C functions directly from your application like you can call 
BSP or device driver functions in RTOS applications.

> - do I need to use kernel modules even if I need to register my
>   driver only one time?

Kernel modules are just shared libraries that are linked in at runtime 
by the kernel. It doesn't matter whether you implement a Linux driver as 
a kernel module or not. Actually, Linux device drivers can often be 
built statically or as kernel modules, selectable at kernel compile time.

> - is it possible for my application to register itself a driver or
>   is it only a "kernel job"?

If you mean can your application load a driver into the kernel then the 
answer is yes. But it's often automatic. It might happen, for example, 
when your application opens a device file of your driver.

If you mean can your application be a device driver for the kernel then 
the answer is no.

> - I have to map other vxWorks routines as "intEnable", "intDisable"
>   which respectively enable/disable specified interrupt bit : may I
>   use the linux equivalent "enable_irq" and "disqble_irq" and that
>   wherever and whenever I want? (same question for the
>   "request_irq" routine)

This is kernel code. I suggest you try to study how Linux device drivers 
work. Some books are available on the subject. Google.

Hope I helped.

/james
