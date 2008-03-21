Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB72EDE083
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 22:39:53 +1100 (EST)
In-Reply-To: <18403.32257.725539.470771@cargo.ozlabs.ibm.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <82ce3dbb9ebdb1fa4fc7407ed3396411@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
Date: Fri, 21 Mar 2008 12:39:45 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Personally, I'm not fond of this approach.  There is already some
>> traction to using the reg-shift property to specify spacing, and I
>> think it would be appropriate to also define a reg-offset property to
>> handle the +3 offset and then let the xilinx 16550 nodes use those.
>
> Why do we need a reg-offset property when we can just add the offset
> to the appropriate word(s) in the reg property?

Because if you do that, the "reg" property cannot describe the full
register block (it misses the first few bytes).  Not a huge problem
in practice, sure.


Segher
