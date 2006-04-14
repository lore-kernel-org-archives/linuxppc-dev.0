Return-Path: <jimix@watson.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 648B6679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 22:45:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ECj4Ci002626
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:45:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ECj4ip233454
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:45:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3ECj4jm029313
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:45:04 -0400
In-Reply-To: <1144969933.4935.45.camel@localhost.localdomain>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<1144969933.4935.45.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52F25F7B-ED3C-4A72-A8C9-3631D8D83357@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Fri, 14 Apr 2006 08:45:02 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2006, at 7:12 PM, Benjamin Herrenschmidt wrote:
>
> We should make lmb_reserve() of redudant/overlapping entries become
> harmless I think.

Hmm.. I think it would be worthy of a warning, no?

> We need to be backward compatible with earlier blobs
> that do contain themselves in the reserve map

Do you think it is possible that the blob may have a single  
reservation that includes the blob but is larger? if not then we  
could simply do..
--
diff -r eb0990a251a9 arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c	Thu Mar 30 22:05:40 2006 -0500
+++ b/arch/powerpc/kernel/prom.c	Fri Apr 14 08:44:10 2006 -0400
@@ -1129,9 +1129,17 @@ static void __init early_reserve_mem(voi
{
	u64 base, size;
	u64 *reserve_map;
+	unsigned long self_base;
+	unsigned long self_size;
	reserve_map = (u64 *)(((unsigned long)initial_boot_params) +
					initial_boot_params->off_mem_rsvmap);
+
+	/* before we do anything, lets reserve the dt blob */
+	self_base = __pa((unsigned long)initial_boot_params);
+	self_size = initial_boot_params->totalsize;
+	lmb_reserve(self_base, self_size);
+
#ifdef CONFIG_PPC32
	/*
	 * Handle the case where we might be booting from an old kexec
@@ -1146,6 +1154,9 @@ static void __init early_reserve_mem(voi
			size_32 = *(reserve_map_32++);
			if (size_32 == 0)
				break;
+			/* skip if the reservation is for the blob */
+			if (base_32 == self_base && size_32 == self_size)
+				continue;
			DBG("reserving: %x -> %x\n", base_32, size_32);
			lmb_reserve(base_32, size_32);
		}
@@ -1157,6 +1168,9 @@ static void __init early_reserve_mem(voi
		size = *(reserve_map++);
		if (size == 0)
			break;
+		/* skip if the reservation is for the blob */
+		if (base == self_base && size == self_size)
+			continue;
		DBG("reserving: %llx -> %llx\n", base, size);
		lmb_reserve(base, size);
	}
