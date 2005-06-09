Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id F311B679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:29:21 +1000 (EST)
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <OFD05D82FF.63484065-ONC125701B.00332983@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 9 Jun 2005 11:30:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_Read_in_/dev/port_with_Segment?=
 =?iso-8859-1?q?ation?=  Fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Matt,

then what is the use of /dev/port driver file ? When i do "cat /dev/port"
on the standard console, i have also a segmentation fault.

Another question, if i use mmap to map physical addresses of I/O registers,
could i dereference the pointer on virtual adresse to access data or should
i use read/write on the file descriptor ?

Best regards.

Sophie CARAYOL




                                                                                                                                                    
                    Matt Porter                                                                                                                     
                    <mporter@kernel.cra        Pour :  scarayol@assystembrime.com                                                                   
                    shing.org>                 cc :    linuxppc-embedded@ozlabs.org                                                                 
                                               Objet :      Re: Read in /dev/port with Segmentation Fault                                           
                    09/06/05 11:12                                                                                                                  
                                                                                                                                                    
                                                                                                                                                    



On Thu, Jun 09, 2005 at 09:30:43AM +0200, scarayol@assystembrime.com wrote:
> Hi all,
>
> I want to access to IO ports on a MPC885. The iopl() is not implemented,
in
> my distribution, to use inw() outw().
> So I use /dev/port. It works for open("/dev/port",..) and lseek() but
when
> i do a read()  i have a segmentation fault. I gave all the right to
> /dev/port
> Does anybody have an idea ?

You are trying to use x86-specific interfaces to x86-specific IO space.
By "IO ports" you must mean memory mapped I/O registers since you are
on PPC. From userspace, use mmap() to map physical address space to a
user virtual address range.

-Matt
