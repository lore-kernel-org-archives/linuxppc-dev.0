Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 10F7E67BA2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 23:37:57 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i20so536699wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 06:37:56 -0700 (PDT)
Message-ID: <a0bc9bf80608290637q165d1f54x2d80e771671c894f@mail.gmail.com>
Date: Tue, 29 Aug 2006 21:37:37 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: RE: atomic operations in user space
MIME-Version: 1.0
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

> This is exactly how it is supposed to work! That's why there is a loop
> in the atomic increment - you check if you still had the reservation
> after the transaction by checking the result from the stwcx, and if not,
> retry.

I surely know all the theories you mentioned clearly.  But please do
look at the case I gave.  Correct me if I missed anything.  Thanks

All the lwarx and stwcx operate on the same address.

> Task A		Task B
> lwarx				
// Get RESERVATION
> 			......
> 			lwarx
> 			stwcx

// RESERVATION cleared
>
> 			.....
> 			.....
> 			lwarx

// Get RESERVATION again
> stwcx				

//Note here: RESERVATION is valid, address is the same.
So the result is commited, no retry for task A

> .....
> 			stwcx
//RESERVATION is cleared, retry atomic op for task B

Please be noted that reservation is only identified by reservation bit
and address operated on.  So different lwarx's on the same address,
may be considered as the same reservation.
