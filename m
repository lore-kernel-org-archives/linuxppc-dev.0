Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-4.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC925DE437
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 06:32:17 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] infiniband/ehca: use consistent type
References: <20081231141453.45d7f2c1.sfr@canb.auug.org.au>
Date: Wed, 07 Jan 2009 11:32:13 -0800
In-Reply-To: <20081231141453.45d7f2c1.sfr@canb.auug.org.au> (Stephen
	Rothwell's message of "Wed, 31 Dec 2008 14:14:53 +1100")
Message-ID: <adazli2ud36.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko J Schick <schickhj@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we're going to clean this code up, does it make sense to take it
further?  More precisely, your patch does:

@@ -226,7 +226,7 @@ u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
 			     u32 *eq_ist)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 	u64 allocate_controls;

but every parameter of ehca_plpar_hcall9() is unsigned long, and the
return value is a signed long.  So should we change ret to long and all
these other declarations to unsigned long while we're touching the code
here?

 - R.
