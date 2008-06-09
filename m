Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18509.44672.668946.207110@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jun 2008 08:28:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Prevent loss of interrupts in IB/ehca
In-Reply-To: <200806091742.29421.ossrosch@linux.vnet.ibm.com>
References: <200806091742.29421.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roscher writes:

> This patchset contains two changes for IB/ehca and ibmebus.
> 
> The first patch enables ibmebus_request_irq() to optionally return the 
> IRQ number, which is used by the second patch to trigger EOI in case of 
> lost interrupts.

At first sight it seems like a very bad idea for a driver to be poking
into the internals of the interrupt subsystem like this.  Under what
circumstances do interrupts get lost, and why does doing an extra EOI
like this fix the problem?

Paul.
