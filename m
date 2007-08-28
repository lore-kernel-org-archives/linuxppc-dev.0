Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18131.45155.16087.714489@cargo.ozlabs.ibm.com>
Date: Tue, 28 Aug 2007 15:19:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: what is ~1MB of memory allocated at fffea000-fffff000 on ppc64?
In-Reply-To: <46D34A9E.7010501@nortel.com>
References: <46D3326C.3000505@nortel.com> <20070827203157.GD13612@kryten>
	<46D34A9E.7010501@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> For some background, we're running an emulator that uses a null pointer 
> value of 0xffff0000 and we want any accesses to that address to trap.
> 
> Do you anticipate any issues with the following change?
> 
> -#define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
> +#define TASK_SIZE_USER32 (0x00000000FFFF0000UL - (1*PAGE_SIZE))

Can you fix this in userspace instead by moving the stack down below
0xffff0000 and then doing munmap(0xffff0000, 0x1000) ?

Paul.
