Return-Path: <peter.ryser@xilinx.com>
Received: from mail77-red-R.bigfish.com (mail-red.bigfish.com [216.148.222.61])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4D8C66807F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Aug 2005 08:48:40 +1000 (EST)
Message-ID: <430F9BEB.70805@xilinx.com>
Date: Fri, 26 Aug 2005 15:47:07 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<20050826031057.GA6553@siegfried.thelikelysolution.ca>
In-Reply-To: <20050826031057.GA6553@siegfried.thelikelysolution.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Since there is no seperate IO memory space you can access the registers
>with simple pointers.
>
>Whether or not it is a good idea (based on coding conventions) I'll
>leave for someone else to answer.  :)
>
You want to use the read{b,w,l} and write{b,w,l} macros for two reasons:
1. Accesses to registers need to be synch'ed with 'eieio' or some other 
synchronizing instructions.
2. Portability of your driver if you ever should ever move it to a 
different architecture and/or change the endianness in your system

- Peter
