Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18429.28416.578860.961632@cargo.ozlabs.ibm.com>
Date: Thu, 10 Apr 2008 11:36:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
In-Reply-To: <76b6f0069fd6d80f69620e39c8528e9d@kernel.crashing.org>
References: <47FAB221.7050406@austin.ibm.com>
	<20080408024352.GA32761@lixom.net> <47FCFDA4.10709@austin.ibm.com>
	<76b6f0069fd6d80f69620e39c8528e9d@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, mahuja@us.ibm.com, linasvepstas@gmail.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> >>> +	tmp = tmp & ~0x000000001FFFFFFF;
> 
> Note that this only works as you expect because the constant is
> signed here -- the extra zeroes do not magically make it a 64-bit
> number.  So it goes 32-bit 0x1fffffff -> 32-bit -0x20000000 ->
> 64-bit -0x20000000.

Huh?  It's not big enough to be negative when considered as a 32-bit
number...

But yes, adding a UL would be a good idea.

Paul.
