Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id 1D7C6DE108
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:44:39 +1100 (EST)
Message-ID: <49B8CBB7.3070307@lebon.org.ua>
Date: Thu, 12 Mar 2009 10:45:43 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <49B58779.9040905@lebon.org.ua> <200903120905.11542.sr@denx.de>
	<1236845549.7086.86.camel@pasglop> <200903120924.13378.sr@denx.de>
In-Reply-To: <200903120924.13378.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
>> Either get the mem 
>> size from there or some flag or version in there can indicate if it's
>> been "fixed".
>
> I don't think that we have some flag and/or version information in the bd_info 
> struct. And extending this struct doesn't sound like a good idea to me.

May I suggest an easier way ?

The problem we currently have is some evaluation board(s), we know them, 
use wrong DDR configuration parameters, so do as U-Boot does - simply 
hardcode memory size for these particular board(s), don't calculate, but 
use patched function to calculate memory size for all other boards, 
including variety of customers' made. To be absolutely sure, we can 
check board revision register - it's theoretically possible that future 
board revisions will have more or less memory installed.

This way we can avoid U-Boot to Linux compatibility issues.
