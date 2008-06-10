Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3C82DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 18:22:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5A8O087004728
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 04:24:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5A8LXEV184072
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 04:21:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5A8LWSj007578
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 04:21:33 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH 0/2] Prevent loss of interrupts in IB/ehca
Date: Tue, 10 Jun 2008 10:21:26 +0200
References: <200806091742.29421.ossrosch@linux.vnet.ibm.com>
	<18509.44672.668946.207110@cargo.ozlabs.ibm.com>
In-Reply-To: <18509.44672.668946.207110@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101021.28795.ossrosch@linux.vnet.ibm.com>
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

On Tuesday 10 June 2008 00:28:16 Paul Mackerras wrote:
> Stefan Roscher writes:
> 
> > This patchset contains two changes for IB/ehca and ibmebus.
> > 
> > The first patch enables ibmebus_request_irq() to optionally return the 
> > IRQ number, which is used by the second patch to trigger EOI in case of 
> > lost interrupts.
> 
> At first sight it seems like a very bad idea for a driver to be poking
> into the internals of the interrupt subsystem like this.  Under what
> circumstances do interrupts get lost, and why does doing an extra EOI
> like this fix the problem?
> 
> Paul.
> 

The processing of events with a timer controlled polling is not the "typical"
way how you should handle adapter events.
During corner case testing, we noticed that some versions of ehca 
do not properly transition to interrupt done in special load situations.
This can be resolved by periodically triggering EOI through H_EOI, 
if eqes are pending.
Hope this clarifys the backround of the patch.

Is there a better way to initiate this type of EOI in a non-irq case?

regards Stefan R. and Christoph R.
