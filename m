Date: Mon, 20 Nov 2000 15:40:22 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: jlhagen@collins.rockwell.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing PReP boot arguments
In-Reply-To: <OFD3445213.1A15922A-ON8625699D.005FB659@collins.rockwell.com>
Message-ID: <Pine.LNX.3.96L.1001120152211.667C-100000@DARVON.WEH.ANDREW.CMU.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Nov 2000 jlhagen@collins.rockwell.com wrote:
>
> could someone point me to the correct place in the source tree to hard code
> the boot arguments for the kernel. I'm currently using the .config file to
> pass the arguments in but they don't make it to the kernel. Then the kernel
> dies mounting the root file system that isn't specified. So I'd like a
> quick hack point to test if this is going to work at all. My ramdisk image
> is working with 2.2 kernels so I think it should be ok to use for 2.4.

This has been left out of 2.4 for a very long time. The solution is
simple:  copy the code out of 2.2 (and add the missing '*'):

--- arch/ppc/kernel/prep_setup.c.old    Mon Nov 20 15:27:55 2000
+++ arch/ppc/kernel/prep_setup.c        Mon Nov 20 15:29:44 2000
@@ -786,6 +786,14 @@

        prep_setup_pci_ptrs();

+        /* take care of cmd line */
+        if ( r6  && (*((char *) r6) != '\0'))
+        {
+                *(char *)(r7+KERNELBASE) = 0;
+                strcpy(cmd_line, (char *)(r6+KERNELBASE));
+        }
+
+
        ppc_md.setup_arch     = prep_setup_arch;
        ppc_md.setup_residual = prep_setup_residual;
        ppc_md.get_cpuinfo    = prep_get_cpuinfo;

This has been left out of the various trees for so long... and it's so
simple. I hope someone commits it soon.

I don't know if it's in Cort's tree because I don't have bk and Cort's
rsync has been down for a month...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
