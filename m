Return-Path: <zinosat@tiscali.it>
Received: from cp-out9.libero.it (cp-out9.libero.it [151.1.108.66])
 by ozlabs.org (Postfix) with ESMTP id D35D62C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 19:53:07 +1100 (EST)
Date: Wed, 31 Oct 2012 09:52:11 +0100
From: Davide <zinosat@tiscali.it>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI device not working
Message-ID: <20121031085211.GB931@zinosat.dyndns.org>
References: <11976036.82651349353479389.JavaMail.defaultUser@defaultHost>
 <62666FBA-F62E-44B7-814E-0718AE957EC0@kernel.crashing.org>
 <CAKpAL0m3YnsbbGxL+ejfyE4zfGE5LD9Qxb7oobHVaAZGE1_Jnw@mail.gmail.com>
 <CAKpAL0mErR3vR4AdSAT_vJG_kM=GvHnZR+b3dtSCN0GMU56pAw@mail.gmail.com>
 <750F6602-132E-449A-A852-43E739EA6D3E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
I try to summarize the problem in the hope to fix it for good:
Linux Kernel (2.6.34-6) did not detect one of the two pci devices
that instead u-boot could "see".
This was worakounded by defining CONFIG_PCI_NOSCAN in u-boot as per [1]

To find out the root cause of the problem, you've suggested to dump all 
the controller registers between the case that works and doesn't and 
see what changes.

Te following registers have different values in the faulty situation (u-boot 
compiled without CONFIG_PCI_NOSCAN definition) vs the working case (u-boot
compiled with CONFIG_PCI_NOSCAN defined):

0x9000: 0x80000048 (not working) -> 0x8003007c (ok)
0x9004: 0x00000000 (not working) -> 0x08000000 (ok)

The register values were obtained with the devmem utility.

Thanx very much for your help,
Davide

[1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/20140
