Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B336E2C0160
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 23:34:17 +1000 (EST)
Message-ID: <1375968822.12551.48.camel@pasglop>
Subject: Re: [RFC PATCH 7/9] powerpc: Decode and save machine check event.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 23:33:42 +1000
In-Reply-To: <52039AF7.9080807@linux.vnet.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093913.5389.80206.stgit@mars.in.ibm.com>
 <20130808051422.GE12112@iris.ozlabs.ibm.com>
 <52039AF7.9080807@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 18:49 +0530, Mahesh Jagannath Salgaonkar wrote:
> > Secondly, we shouldn't call save_mce_event() if we're not in
> > hypervisor mode, since per-cpu variables are not in general
> accessible
> > in real mode when running under a hypervisor with a limited
> real-mode
> > area (RMA).
> 
> Does that mean in real mode we can never be able to access per cpu
> variable? OR do I need to use some tweaks to access those?

Right, all you can access is stuff that was specifically allocated to be
in the RMA during boot, such as the PACA's.

Ben.
