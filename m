Return-Path: <support@abatron.ch>
Received: from vm-3.internezzo.ch (vm-3.internezzo.ch [195.234.43.35])
 by ozlabs.org (Postfix) with SMTP id 7D700B700E
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 22:26:52 +1000 (EST)
Date: Wed, 30 May 2012 14:08:26 +0200
From: Abatron Support <support@abatron.ch>
Message-ID: <10126984030.20120530140826@abatron.ch>
To: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re[2]: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
In-Reply-To: <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>
Reply-To: Support <support@abatron.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I have tested this briefly with BDI2000 on P2010(e500) and
>> it works for me. I don't know if there are any bad side effects,  
>> therfore
>> this RFC.

> We used to have MSR_DE surrounded by CONFIG_something
> to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
> is set, you will have problems with software debuggers that
> utilize the the debugging registers in the chip itself.  You only want
> to force this to be set when using the BDI, not at other times.

This MSR_DE is also of interest and used for software debuggers that
make use of the debug registers. Only if MSR_DE is set then debug
interrupts are generated. If a debug event leads to a debug interrupt
handled by a software debugger or if it leads to a debug halt handled
by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.

The "e500 Core Family Reference Manual" chapter "Chapter 8
Debug Support" explains in detail the effect of MSR_DE.

Ruedi
