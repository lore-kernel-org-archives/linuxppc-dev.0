Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17491.6735.199209.247913@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 17:48:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: PCI init vs. memory init
In-Reply-To: <20060428230401.GF22621@austin.ibm.com>
References: <20060428230401.GF22621@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> You mentioned that the sequence of inits seemed wrong, that the 
> PCI init should be done later, after the memory init. I think
> I agree; but when I took a very very quick look at the code, there 
> was no obvious hook in later init to move the PCI init over to. 
> 
> Are you pursuing this further? Should I dig into it?  Any bright
> ideas? Am I missing something obvious?  

I assume you're talking about find_and_init_phbs() and eeh_init(),
which are currently called from pSeries_setup_arch().

Would a core_initcall be early enough for those?  It seems to me that
it probably would be.  What are the actual dependencies?  Clearly it
needs to be before pcibios_init(), which is a subsys_initcall.  Is
there anything else that they need to come before?

> There are several spots in in the powerpc PCI init code where 
> a boot_mem alloc is used instead of kmalloc, and this boot_mem is 
> then hacked around in the case of a PCI hotplug remove.  It would 
> be nice to fix this...

Indeed.

Paul.
