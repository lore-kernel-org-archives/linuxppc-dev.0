Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17444.28659.604385.647249@cargo.ozlabs.ibm.com>
Date: Sat, 25 Mar 2006 09:17:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Subject: RE: memory with __get_free_pages and disabling caching
In-Reply-To: <478F19F21671F04298A2116393EEC3D50A9C21@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D50A9C21@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kallol Biswas writes:

> We have a little endian device on a PPC 440GX based system.
> The descriptors need to be swapped. With E bit turned on we can save
> swapping time.

Writing the descriptors with stwbrx should be just as fast as using
stw, and eliminates the need for a special mapping.

If you need it to be cache-inhibited, you should be using
dma_alloc_coherent() or pci_alloc_consistent().

Paul.
