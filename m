Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id B86602BDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Oct 2004 09:58:12 +1000 (EST)
Received: from [10.35.5.214] ([10.35.5.214])
	by kla-tencor.com (8.11.6+Sun/KLAC-1.0i) with ESMTP id i9SNwBj01359
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Oct 2004 16:58:11 -0700 (PDT)
Message-ID: <4181878C.20605@vision.caltech.edu>
Date: Thu, 28 Oct 2004 16:58:04 -0700
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston>
In-Reply-To: <1099006771.29690.83.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Thu, 2004-10-28 at 14:45 -0700, Arrigo Benedetti wrote:
>
>>Dear all,
>>
>>how can I (temporarily) disable all or some specific interrupts on a 
>>specific CPU in an SMP system
>>from user space code? In my case this is an Apple dual G5 system.
>>
>
>You can't ... why do you want to do that ?
>
>

To achieve real-time performance in a very critical section of code. 
Even after moving all the
interrupts to CPU0, there are still two interrupts running on CPU1 that 
are disturbing the
execution of the time-critical code:

           CPU0       CPU1      
  0:      45127          0   OpenPIC   Level     libata
 25:        225          0   OpenPIC   Level     VIA-PMU
 26:          0          0   OpenPIC   Level     keywest i2c
 27:          0          0   OpenPIC   Level     ohci_hcd
 28:          0          0   OpenPIC   Level     ohci_hcd
 39:     189380          0   OpenPIC   Level     ide0
 40:        304          0   OpenPIC   Level     ohci1394
 41:    1288195          0   OpenPIC   Level     eth0
 47:          0          0   OpenPIC   Level     GPIO1/ADB
 55:          0          0   OpenPIC   Edge      NMI - XMON
 56:          1          0   OpenPIC   Edge      U3->K2 Cascade
 63:      15212          0   OpenPIC   Level     ehci_hcd, ohci_hcd, 
ohci_hcd
118:         15      21134   OpenPIC   Level     IPI0 (call function)
119:        888        904   OpenPIC   Level     IPI1 (reschedule)
120:          0          0   OpenPIC   Edge      IPI2 (invalidate tlb)
121:          0          0   OpenPIC   Edge      IPI3 (xmon break)
128:          0          0   OpenPIC2  Level     keywest i2c
IPI (recv/sent):      22941/22941
BAD:          1


I agree that this is not an elegant solution, but I would like to give 
it a try anyway...

Thanks

-Arrigo
