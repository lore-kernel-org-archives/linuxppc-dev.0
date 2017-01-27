Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1Z6LB1zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:34 +1100 (AEDT)
In-Reply-To: <20161209061850.23281-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v2] cxl: prevent read/write to AFU config space while AFU not
 configured
Message-Id: <3v8g1Z5Gdyz9t5m@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-09 at 06:18:50 UTC, Andrew Donnellan wrote:
> During EEH recovery, we deconfigure all AFUs whilst leaving the
> corresponding vPHB and virtual PCI device in place.
> 
> If something attempts to interact with the AFU's PCI config space (e.g.
> running lspci) after the AFU has been deconfigured and before it's
> reconfigured, cxl_pcie_{read,write}_config() will read invalid values from
> the deconfigured struct cxl_afu and proceed to Oops when they try to
> dereference pointers that have been set to NULL during deconfiguration.
> 
> Add a rwsem to struct cxl_afu so we can prevent interaction with config
> space while the AFU is deconfigured.
> 
> Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
> Suggested-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/14a3ae34bfd0bcb1cc12d55b06a858

cheers
