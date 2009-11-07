Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id AE264B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 13:52:49 +1100 (EST)
Received: from crust.elkhashab.com ([24.28.25.36])
	by hrndva-omta04.mail.rr.com with ESMTP
	id <20091107024747328.UZDH23932@hrndva-omta04.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 Nov 2009 02:47:47 +0000
Received: from [192.168.1.20] (millhouse.elkhashab.com [192.168.1.20])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	nA72lkKF014109
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2009 20:47:46 -0600
Message-ID: <4AF4DFD0.3080604@elkhashab.com>
Date: Fri, 06 Nov 2009 20:47:44 -0600
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: help with unhandled IRQ error with mpt2sas driver and powerpc
	460EX
References: <4AE72D83.7000404@elkhashab.com>
	<1256689358.11607.139.camel@pasglop>
In-Reply-To: <1256689358.11607.139.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/2009 7:22 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2009-10-27 at 12:27 -0500, Ayman El-Khashab wrote:
>   
>> The first problem I noticed is that the physical address is read into a 
>> 32 bit variable, but the 460ex has a 36 bit bus so the ioremap would 
>> always fail.  I've change the defn of chip_phys in mpt2sas_base.h to u64 
>> and that cleared up that issue.
>>     
>
> That looks indeed like a common driver bug. Please make sure you submit
> the fix upstream. The "right" type to use is resource_size_t in fact.
>
>   
Thank you Benjamin for your help.  The info was passed onto the 
maintainer and they were able to use it
to improve their driver.  In the background, the mpt2sas was brought up 
on the canyonlands/460ex.  The
biggest thing turned out to be an #ifdef in the code that referred to 
BITS_32 to determine whether to prog
the high and low of the DMA addresses.  Once that was adjusted, it did 
function and detect the sas drive.
