Message-ID: <40E2ADCA.4030006@fh-landshut.de>
Date: Wed, 30 Jun 2004 14:10:50 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pci on ppc
References: <200406301233.24676.Schramel.Linux@go.bartec.de>
In-Reply-To: <200406301233.24676.Schramel.Linux@go.bartec.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marco Schramel wrote:
> Where the function "m8260_setup_arch()" (m8260_setup.c) is called ?? With the pci option the kernel does not call this function.
>

I don't know If I understand you right or this is helpful to you, but these
functions are never called directly, but instead in platform_init() function
pointers are stored in the ppc_md struct variable, and this holds true for
m8260_setup_arch() as well (in arch/ppc/kernel/m8260_setup.c):

ppc_md.setup_arch = m8260_setup_arch;


There's always only one platform_init() due to the linking process, so there's
no name clash.

Could you elaborate a bit on your PCI problem anyway? Is your board standard or
custom?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
