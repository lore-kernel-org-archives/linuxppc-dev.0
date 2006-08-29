Return-Path: <nielsen.esben@gogglemail.com>
Received: from mx01.stofanet.dk (mx01.stofanet.dk [212.10.10.11])
	by ozlabs.org (Postfix) with ESMTP id 2893667B5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 02:06:02 +1000 (EST)
Date: Tue, 29 Aug 2006 18:05:43 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
To: Li Yang <LeoLi@freescale.com>
Subject: RE: atomic operations in user space
In-Reply-To: <a0bc9bf80608290637q165d1f54x2d80e771671c894f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608291804260.22067@frodo.shire>
References: <a0bc9bf80608290637q165d1f54x2d80e771671c894f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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



On Tue, 29 Aug 2006, Li Yang wrote:

>> This is exactly how it is supposed to work! That's why there is a loop
>> in the atomic increment - you check if you still had the reservation
>> after the transaction by checking the result from the stwcx, and if not,
>> retry.
>
> I surely know all the theories you mentioned clearly.  But please do
> look at the case I gave.  Correct me if I missed anything.  Thanks
>
> All the lwarx and stwcx operate on the same address.
>
>> Task A		Task B
>> lwarx
> // Get RESERVATION
>> 			......
>> 			lwarx
>> 			stwcx
>
> // RESERVATION cleared
>>
>> 			.....
>> 			.....
>> 			lwarx
>
> // Get RESERVATION again

Now we do a task switch involving atomic operations, and thus an 
reservation on another address.

>> stwcx
>
> //Note here: RESERVATION is valid, address is the same.
> So the result is commited, no retry for task A
>
>> .....
>> 			stwcx
> //RESERVATION is cleared, retry atomic op for task B
>
> Please be noted that reservation is only identified by reservation bit
> and address operated on.  So different lwarx's on the same address,
> may be considered as the same reservation.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
