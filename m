Return-Path: <dpetchkine@certicom.com>
Received: from mail.ca.certicom.com (mail.ca.certicom.com [38.113.160.197])
	by ozlabs.org (Postfix) with ESMTP id DC563DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 06:47:36 +1000 (EST)
Message-ID: <467C3562.4080401@certicom.com>
Date: Fri, 22 Jun 2007 16:47:30 -0400
From: Dmitri Petchkine <dpetchkine@certicom.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: Memory coherency on MPC8272
References: <467C06B8.6070303@certicom.com>
	<AC13379B-60F2-4F76-A2F8-275285E92B0A@embeddedalley.com>
In-Reply-To: <AC13379B-60F2-4F76-A2F8-275285E92B0A@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/22/2007 03:35 PM, Dan Malek wrote:
> On Jun 22, 2007, at 10:28 AM, Dmitri Petchkine wrote:
>> My understanding that the security hardware of MPC8272 uses DMA to write
>> results into the memory which may cause a coherency problem.
> 
> Where did you get such an (incorrect) understanding?
> I suggest you acquire your understanding from reading the
> MPC8272 reference manual, since it describes the cache
> and snooping options between the SEC and memory,
> as well as among the SEC units.
> 
>> My exposure to such hardware issues is very limited, so I appreciate any
>> advice on how to fix it.
> 
> The code snippet clearly shows you don't understand
> the user/kernel interface, since your access to "param" isn't
> correct.

Please note that I'm NOT writing a driver for SEC1, I'm using it. The 
driver has been written by Freescale. The piece of code I quoted in my 
previous email and you reference to has been coded by Freescale guys. If 
you want take a look, the sources can be downloaded from

http://www.freescale.com/webapp/sps/download/license.jsp?colCode=SEC1DRVRS&location=null&fpsp=1

Before performing any crypto operation, my application calls the SEC1 
driver to allocate memory buffers (via IOCTL_MALLOC) in the kernel space 
and copy all the user buffers into the kernel space (via 
IOCTL_COPYFROM), including the request structure itself.

After the completion of the crypt op, the application copies (via 
IOCTL_COPYTO) the request structure back to the user space as well as 
all the output buffers.

 > The SEC is complex and has subtle control
> considerations, any part of this could be incorrect.  I
> suspect your coding errors are hidden/highlighted
> by adding the code for the printing, not the actual
> operation itself.

Yes it might be that I use the driver improperly. Although the app's 
interaction with it is very limited: set up a structure in the kernel 
space, do a crypto op, get data back to the user space. All of it is 
done through ioctl().

The application is a quite comprehensive unit test for crypto, which 
includes DES/TDES/AES/RC4, SHA-1/SHA-2/MD5, RSA, DSA, DH, and ECC. It 
can be built also as a kernel module - this passes all the exact same 
tests, which gives me some assurance that request structures for the 
SEC1 hardware are set properly.

Thanks
Dmitri Petchkine
