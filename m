Return-Path: <zinosat@tiscali.it>
Received: from cp-out7.libero.it (cp-out7.libero.it [151.1.108.64])
 by ozlabs.org (Postfix) with ESMTP id 3509E2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 19:21:45 +1100 (EST)
Date: Thu, 25 Oct 2012 10:21:04 +0200
From: Davide <zinosat@tiscali.it>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI device not working
Message-ID: <20121025082104.GA931@zinosat.dyndns.org>
References: <11976036.82651349353479389.JavaMail.defaultUser@defaultHost>
 <62666FBA-F62E-44B7-814E-0718AE957EC0@kernel.crashing.org>
 <CAKpAL0m3YnsbbGxL+ejfyE4zfGE5LD9Qxb7oobHVaAZGE1_Jnw@mail.gmail.com>
 <CAKpAL0mErR3vR4AdSAT_vJG_kM=GvHnZR+b3dtSCN0GMU56pAw@mail.gmail.com>
 <750F6602-132E-449A-A852-43E739EA6D3E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <750F6602-132E-449A-A852-43E739EA6D3E@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On Fri, Oct 05, 2012 at 07:47:24AM -0500, Kumar Gala wrote:
> 
> On Oct 5, 2012, at 3:54 AM, Davide Viti wrote:
> 
> >> On Oct 4, 2012, at 7:24 AM, Davide Viti wrote:
> >> 
> >>> Hi,
> >>> it turns out that if define CONFIG_PCI_NOSCAN in u-boot (as per [1]), the
> >>> device behind the second controller is detected by the  Linux kernel.
> >>> 
> >>> Would
> >>> you suggest any particular patch I should apply to fix this (I'm using kernel
> >>> 2.6.34)
> >>> 
> >>> thanx alot in advance
> >>> Davide
> >>> 
> >>> [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/20140
> >> 
> >> My suggestion would be to try and dump all the controller registers between the case that works and doesn't and compare.  There's some minor setting difference that I'm guessing is causing issues.
> >> 
> >> - k
> 
> When I said controller registers, I meant the FSL PCI controller and the CCSR registers not the PCI cfg register space
> 

I've collected a complete dump of the registers in the working and not working cases

0x9000: 0x80000048 (not working) -> 0x8003007c (ok)
0x9004: 0x00000000 (not working) -> 0x08000000 (ok)

According to the p1020 manual, the register fall in the PCI Express controller 2 area,
in particular:

0x9000 PEX_CONFIG_ADDR—PCI Express configuration address register
0x9004 PEX_CONFIG_DATA—PCI Express configuration data register

does that ring any bell?

thank you in advance
Davide
