Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ADAFDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 22:56:12 +1100 (EST)
Message-Id: <765C1EA1-93F7-4FEF-930B-78E2B3DEB4FA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: CONFIG_DEBUG_PAGEALLOC generates WARN_ON() in ppc32 hash
Date: Fri, 27 Mar 2009 06:56:05 -0500
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

If we have CONFIG_DEBUG_PAGEALLOC enabled we end up hitting the  
WARN_ON() in set_pte_at() when we boot.  This appears because we've  
already setup pte's via mapin_ram() after which we end up calling  
kernel_map_pages().

So I'm not sure if __change_page_attr() should be doing something  
different or if the WARN_ON() should be conditional on ! 
CONFIG_DEBUG_PAGEALLOC

- k
