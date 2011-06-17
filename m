Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41109B6FD4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 06:24:46 +1000 (EST)
In-Reply-To: <1308290028.32158.45.camel@pasglop>
References: <20110617045358.544896830@samba.org>
	<20110617045421.538184870@samba.org>
	<1308290028.32158.45.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <41dcb51d42aa3a2c6124526b1e97ad11@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: POWER7 optimised copy_page using VMX
Date: Fri, 17 Jun 2011 22:26:25 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +	addi	r1,r1,STACKFRAMESIZE
>> +
>> +	.align	5
>
> Do we know that the blank will be filled with something harmless ?

Yes.  See ppc_handle_align() in gas/config/tc-ppc.c : it fills with nops
(ori 0,0,0), and a branch if there are more than four nops, and for 
POWER6
and POWER7 it puts a group-terminating insn (ori 1,1,0 resp. ori 2,2,0) 
at
the end.

It has done this (well, nops at least) since 2001.


Segher
