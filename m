Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD718DDF46
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 05:45:36 +1000 (EST)
In-Reply-To: <47FCFDA4.10709@austin.ibm.com>
References: <47FAB221.7050406@austin.ibm.com>
	<20080408024352.GA32761@lixom.net> <47FCFDA4.10709@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76b6f0069fd6d80f69620e39c8528e9d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
Date: Wed, 9 Apr 2008 21:39:59 +0200
To: Manish Ahuja <ahuja@austin.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, mahuja@us.ibm.com, linasvepstas@gmail.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	tmp = tmp & ~0x000000001FFFFFFF;

Note that this only works as you expect because the constant is
signed here -- the extra zeroes do not magically make it a 64-bit
number.  So it goes 32-bit 0x1fffffff -> 32-bit -0x20000000 ->
64-bit -0x20000000.

Please consider writing it with an "L" suffix, or "UL" even, to
reduce trickiness and surprises if ever that number is changed.


Segher
