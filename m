Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 451B7B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 01:22:48 +1000 (EST)
Date: Mon, 16 Aug 2010 08:22:44 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: Distinguish between kernel and user space
Message-ID: <20100816152244.GA30251@ovro.caltech.edu>
References: <AANLkTi=ZSeYf0apwK3Tuf3b3-OTsRrddMkNHkxgViw-x@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=ZSeYf0apwK3Tuf3b3-OTsRrddMkNHkxgViw-x@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, MJ embd <mj.embd@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 16, 2010 at 05:52:41PM +0530, Ravi Gupta wrote:
> Hi,
> 
> I have defined a header file for ioctls macros definitions. I am including
> it in both, my user space application as well as in my device driver. Now
> there are some macros that I want to be visible only in device drive and
> some only in user space application. Is there any set of macros defined in
> linux for such purpose? This is my present header file
> 
> gpio_ioctl.h
> 
> #ifndef _GPIO_IOCTL_H_
> #define _GPIO_IOCTL_H_
> 
> /*
>  * Ioctl definitions
>  */
> 
> /* Use 250 as type/magic number */
> #define GPIO_IOC_MAGIC    250
> #define GPIO_READ         _IOW (GPIO_IOC_MAGIC, 0, int)
> #define GPIO_WRITE        _IOW (GPIO_IOC_MAGIC, 1, int)
> #define GPIO_IOC_MAXNR    2
> 
> 
> #ifdef _DEVICE_DRIVE_ ---> these macros should not be visible in user space
> application
> #define ...
> ...
> ..
> #endif
> 
> #ifdef _USER_SPACE_ ---> these macros should not be visible in device driver
> i.e kernel space
> #define ...
> ...
> ..
> 
> #endif  /*_GPIO_IOCTL_H_ */
> 

#ifdef __KERNEL__
/* kernel only definitions here */
#else
/* userspace only definitions here */
#endif

See tons of headers in include/linux/ for examples.

Ira
