Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F4B7DE230
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 00:36:37 +1000 (EST)
Message-Id: <36CB2DB8-2B4D-4F6E-A2DD-31538AA76ECF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18436.12968.728788.841679@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Make Book-E debug handling SMP safe
Date: Tue, 15 Apr 2008 09:36:32 -0500
References: <Pine.LNX.4.64.0804091621140.24556@blarg.am.freescale.net>
	<18436.12968.728788.841679@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 14, 2008, at 11:44 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> global_dbcr0 needs to be a per cpu set of save areas instead of a  
>> single
>> global on all processors.
>
> Looks reasonable.  At some point you might want to use a per-cpu
> variable instead of an array in order to reduce cacheline bouncing.

Can you point me at an example of this.  Do we do any asm access with  
per-cpu variables anywhere today?

>> Also, we switch to using DBCR0_IDM to determine if the user space  
>> app is
>> being debugged as its a more consistent way.  In the future we should
>> support features like hardware breakpoint and watchpoints which will
>> have DBCR0_IDM set but not necessarily DBCR0_IC (single step).
>
> That should be OK.

Ok.  I'll put it my powerpc-next tree.

- k
