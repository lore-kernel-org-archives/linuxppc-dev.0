Return-Path: <rdreier@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4CA7DB716B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 02:10:47 +1000 (EST)
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 68175DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 02:10:46 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Alexander Schmidt <alexs@linux.vnet.ibm.com>
Subject: Re: [ewg] Re: [PATCH 2.6.31] ehca: Tolerate dynamic memory operations
	and huge pages
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<adar5xoybwt.fsf@cisco.com>
	<20090616090809.34d162fc@BL3D1974.boeblingen.de.ibm.com>
Date: Tue, 16 Jun 2009 09:10:39 -0700
In-Reply-To: <20090616090809.34d162fc@BL3D1974.boeblingen.de.ibm.com>
	(Alexander Schmidt's message of "Tue, 16 Jun 2009 09:08:09 +0200")
Message-ID: <adazlc8w45c.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <HNGUYEN@linux.vnet.ibm.com>,
	raisch@de.ibm.com, linux-kernel@vger.kernel.org, ewg@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 > Yeah, the notifier code remains untouched as we still do not allow dynamic
 > memory operations _while_ our module is loaded. The patch allows the driver to
 > cope with DMEM operations that happened before the module was loaded, which
 > might result in a non-contiguous memory layout. When the driver registers
 > its global memory region in the system, the memory layout must be considered.
 > 
 > We chose the term "toleration" instead of "support" to illustrate this.

I see.  So things just silently broke in some cases when the driver was
loaded after operations you didn't tolerate?

Anyway, thanks for the explanation.
