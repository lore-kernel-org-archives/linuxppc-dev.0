Date: Thu, 22 Aug 2002 17:04:22 -0700
From: Matt Porter <porter@cox.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: set_cfg_type
Message-ID: <20020822170422.A2053@home.com>
References: <15716.30526.816418.995714@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15716.30526.816418.995714@argo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Aug 22, 2002 at 03:31:42PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 22, 2002 at 03:31:42PM +1000, Paul Mackerras wrote:
>
> I see that the indirect_pci methods only do Type 1 configuration
> cycles for devices behind PCI-PCI bridges if ppc_md.set_cfg_type is
> set.  Are there *any* host bridges for which we *don't* want to do
> Type 1 cycles for devices behind PCI-PCI bridges?  If the answer is
> no, let's get rid of ppc_md.set_cfg_type and do Type 1 cycles
> unconditionally when dev->bus->number != hose->first_busno.

Although spec defines the format of type 0 and type 1 transactions,
it doesn't define how the registers the host bridge registers that
generate the transactions behave.  Previously, all the host bridges
we have dealt with have been somewhat intelligent.  That is, they
would note a config transaction addressed for the primary bus and
generate a type 0 transaction.  A non 0 bus number (on a single hose
system) on most host bridge's CFGA generates a type1.  This is ,of
course, slightly different on multi-hose systems.  I've touched
a lot of different host bridges, and the 440GP's PCIX macro cell
was the first that actually used the speced type 1 transation bit
in their CFGA to control generation of type 1 transactions.

I made it an option since we may get undesirable results fiddling
with that bit on other host bridges.  We *could* leave it that
way for safety sake on 2.4 and do it all the time on 2.5 and see
what we break.  Recall that the PCI spec does not define host
bridge operation, so the CFGA could do just about anything by
twiddling that bit.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
