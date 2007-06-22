Return-Path: <dpetchkine@certicom.com>
Received: from mail.ca.certicom.com (mail.ca.certicom.com [38.113.160.197])
	by ozlabs.org (Postfix) with ESMTP id 5C59DDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 03:58:09 +1000 (EST)
Received: from spamfilter.certicom.com (localhost.localdomain [127.0.0.1])
	by mail.ca.certicom.com (Postfix) with ESMTP id 37F1110027FE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jun 2007 09:28:58 -0400 (EDT)
Received: from mail.ca.certicom.com ([127.0.0.1])
	by spamfilter.certicom.com (storm.certicom.com [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id Cp9Op67r3ttP for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jun 2007 09:28:56 -0400 (EDT)
Received: from domino1.certicom.com (domino1.certicom.com [10.0.1.24])
	by mail.ca.certicom.com (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jun 2007 09:28:56 -0400 (EDT)
Message-ID: <467C06B8.6070303@certicom.com>
Date: Fri, 22 Jun 2007 13:28:24 -0400
From: Dmitri Petchkine <dpetchkine@certicom.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Memory coherency on MPC8272
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am working on a user-space application interacting with the security 
engine on MPC8272, which runs Linux 2.6.10_mvl401 (Montavista Pro 
4.0.1). The driver (version 1.2 22-Feb-2006) for the security engine is 
written by Freescale.

The application calls the driver through ioctl() to perform a crypto 
operation. It is non-blocking call, so the app sits and waits for the 
result when it becomes available. Once the driver notifies the app via a 
signal, the latter does another ioctl() to get the result back to the 
user space from the kernel-space.

Sometimes the returned buffer is just all zeroes which is incorrect.

Here is the piece of code in the driver which copies the data back to 
the user space:

sec1_ioctl.c:
int SEC1_ioctl(struct inode  *nd,
                struct file   *fil,
                unsigned int   ioctlCode,
                unsigned long  param)
{
...
         case IOCTL_COPYTO:
             mem = (MALLOC_REQ *)param;
             mem->pid = current->pid;
             copy_to_user(mem->to, mem->from, mem->sz);
             status = SEC1_SUCCESS;
             break;
...
}

The definition of MALLOC_REQ (file Sec1.h):

typedef struct
{
     unsigned long sz;   /* Number of bytes to allocate
                            Zero means to use the default.  A value
                            of zero can be used to avoid fragmentation. */
     void         *ptr;  /* Pointer to the adress that is to
                            be returned by a call to KernelMalloc()
                            or a pointer to an address that is to
                            be freed when calling KernelFree()   */
     char         *to;   /* copy to pointer */
     char         *from; /* copy from pointer*/
     int           pid;  /* pid of requestor */
} MALLOC_REQ;


The problem goes away if I add printing of some buffer (it can be 
mem->to or mem->from, or even another, unrelated buffer) AFTER the call 
to copy_to_user(), i.e.:

         case IOCTL_COPYTO:
         {   char garbage[128]; /* new line */
             mem = (MALLOC_REQ *)param;
             mem->pid = current->pid;
             copy_to_user(mem->to, mem->from, mem->sz);

             PRINT_HEX( garbage, 128 ); /* new line */

             status = SEC1_SUCCESS;
             break;
          }

My understanding that the security hardware of MPC8272 uses DMA to write 
results into the memory which may cause a coherency problem.

My exposure to such hardware issues is very limited, so I appreciate any 
advice on how to fix it.

Thanks in advance,
Dmitri Pechkin
