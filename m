Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CDECDDDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 03:08:21 +1000 (EST)
Message-ID: <46B3617B.10509@ru.mvista.com>
Date: Fri, 03 Aug 2007 21:10:19 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 06/10] 40x decrementer fixes
References: <20070803160900.069522000@linux.vnet.ibm.com>>	<20070803161710.931656000@linux.vnet.ibm.com>>
	<46B35C07.4090806@ru.mvista.com>
In-Reply-To: <46B35C07.4090806@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

>>Allow generic_calibrate_decr to work for 40x platforms.  Given that the hardware
>>behavior is identical, this also changes the set_dec function to reload the PIT

    It's not actually identical. When you're writing to the PIT reg on 40x, 
you're alos writing to the hidden PIT auto-reload reg. which is not the case 
for 440 that is true Book E.

>>on 40x to match the behavior 44x currently has.

>     Why bother doing this?! This will only warrant you imprecise decrementer 
> interrupts while it should be interrupting at the precise period currently (if 
> you load PIT once)...

    I.e. the error will only accumulate. NAK.

WBR, Sergei
